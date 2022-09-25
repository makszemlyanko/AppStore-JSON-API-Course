//
//  AppDetailCell.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 17.06.2022.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var app: Result! {
        didSet {
            nameLabel.text = app?.trackName
            artistLabel.text = app?.primaryGenreName
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            priceButton.setTitle(app?.formattedPrice, for: .normal)
            releaseNotesLabel.text = app?.releaseNotes
        }
    }
    
    let appIconImageView = UIImageView(cornerRadius: 24)
    
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let artistLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    let priceButton = UIButton(title: "$4.99")
    
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    
    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        priceButton.backgroundColor = #colorLiteral(red: 0, green: 0.4797471166, blue: 0.9998757243, alpha: 1)
        priceButton.constrainHeight(constant: 32)
        priceButton.constrainWidth(constant: 80)
        priceButton.layer.cornerRadius = 16
        priceButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        
        let stackView = VerticalStackView(arrangedubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedubviews: [
                    nameLabel,
                    artistLabel,
                    UIStackView(arrangedSubviews: [priceButton, UIView()]),
                    UIView()
                ], spacing: 12)
            ],customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel
        ], spacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
