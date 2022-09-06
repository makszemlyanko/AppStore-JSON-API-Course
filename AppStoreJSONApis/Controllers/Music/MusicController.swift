//
//  MusicController.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 06.09.2022.
//

import UIKit

class MusicController: BaseListController {
    
    private let cellId = "cellId"
    private let footerId = "footerId"
    
    private var searchTerm = ""
    private var searchOffset = 0
    
    private var isPaginating = false // don't fetch too many data
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    var musicResult = [Music]()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 200, left: 50, bottom: 0, right: 50))
        
        collectionView.register(MusicCell.self, forCellWithReuseIdentifier: cellId)
        
        // register footer
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Music"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval:  0.5, repeats: false, block: { (_) in
            self.searchTerm = searchText
            self.searchOffset = 0

            Service.shared.fetchMusic(searchTerm: self.searchTerm, offset: String(self.searchOffset)) { (res, err) in
                print(self.searchTerm)
                if let err = err {
                    print("Failed to fetch music:", err)
                    return
                }
                self.musicResult = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        if musicResult.count != 0 {
            footer.isHidden = false
        } else {
            footer.isHidden = true
        }
        return footer
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = musicResult.count != 0
        return musicResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MusicCell
        let track = self.musicResult[indexPath.item]
        cell.nameLabel.text = track.trackName
        cell.subtitleLabel.text = "\(track.artistName) • \(track.collectionName ?? "")"
        cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
            
            // pagination
            if indexPath.item == musicResult.count - 1 && !isPaginating {
                self.isPaginating = true
                Service.shared.fetchMusic(searchTerm: self.searchTerm, offset: String(self.searchOffset)) { (result, error) in
                    if let error = error {
                        print("Failed to fetch music: ", error)
                        return
                    }
//                    sleep(1)
                    self.musicResult += result?.results ?? []
                    self.searchOffset += 20
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    self.isPaginating = false
                }
            }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 100)
    }
    
}

extension MusicController: UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .init(width: view.frame.width, height: 100)
    }
}
