//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 05.09.2022.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    
    fileprivate var startingFrame: CGRect?
    
    var appFullScreenController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9489304423, green: 0.9490666986, blue: 0.94890064, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appFullScreenController = AppDetailFullScreenController()
        let detailView = appFullScreenController.view!
        detailView.layer.cornerRadius = 16
        detailView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        view.addSubview(detailView)
        addChild(appFullScreenController)
        self.appFullScreenController = appFullScreenController
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        detailView.frame = startingFrame
        
        UIView.animate(withDuration: 0.5, delay:  0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            detailView.frame = self.view.frame
            self.tabBarController?.tabBar.isHidden = true
        }, completion: nil)
    }
    
    @objc fileprivate func handleRemoveRedView(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay:  0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            gesture.view?.frame = self.startingFrame ?? .zero
            self.tabBarController?.tabBar.isHidden = false
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}

