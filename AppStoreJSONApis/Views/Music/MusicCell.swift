//
//  MusicCell.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 06.09.2022.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "Track Name", font: .boldSystemFont(ofSize: 18))
    let subtitleLabel = UILabel(text: "Subtitle", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constrainWidth(constant: 80)
        
        let stackVeiw = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedubviews: [nameLabel, subtitleLabel], spacing: 4)], customSpacing: 16)
        stackVeiw.axis = .horizontal
        
        addSubview(stackVeiw)
        stackVeiw.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackVeiw.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
