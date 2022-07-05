//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 04.07.2022.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9318081737, green: 0.9319422841, blue: 0.9386354089, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var appFullScreenController = UIViewController()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullScreenController = AppFullScreenController()
        let redView = appFullScreenController.view!
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        view.addSubview(redView)
        
        addChild(appFullScreenController)
        
        self.appFullScreenController = appFullScreenController
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // Absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        redView.frame = startingFrame
        redView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            redView.frame = self.view.frame
            self.tabBarController?.tabBar.transform = CGAffineTransform(scaleX: 0, y: 0)
        }, completion: nil)
    }
    
    var startingFrame: CGRect?
    
    @objc func handleRemoveRedView(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut) {
            gesture.view?.frame = self.startingFrame ?? .zero
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { (_) in
            gesture.view?.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}

