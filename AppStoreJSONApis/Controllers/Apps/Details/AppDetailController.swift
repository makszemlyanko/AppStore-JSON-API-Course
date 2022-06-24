//
//  AppDetailController.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 15.06.2022.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appId: String! {
        didSet {
            print("HEre is my app", appId ?? "")
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
            let reviewUrl = "https://itunes.apple.com/us/rss/customerreviews/id=\(appId ?? "")/mostrecent/json"
            Service.shared.fetchGenericJSONData(urlString: reviewUrl) { (reviews: Reviews?, err) in
                if let err = err {
                    print("Failed to decode reviews", err)
                    return
                }
                self.reviews = reviews
               // reviews?.feed.entry.forEach({print($0.rating.label)})
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
//                reviews?.feed.entry.forEach({ (entry) in
//                    print(entry.title, entry.author.label, entry.content)
//                })
            }
        }
    }
    
    var app: Result?
    var reviews: Reviews?
    
    let detailCellId = "detailCellId"
    let previewCellId = "previewCellId"
    let reviewCellId = "reviewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        } else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 280
        if indexPath.item == 0 {
            let dummycell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummycell.app = app
            dummycell.layoutIfNeeded()
            let estimatedSize = dummycell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 280
        }
        return .init(width: view.frame.width, height: height)
    }
}
