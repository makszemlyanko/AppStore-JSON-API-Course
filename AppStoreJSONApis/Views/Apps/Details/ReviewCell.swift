//
//  ReviewCell.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 20.06.2022.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review title", font: .boldSystemFont(ofSize: 18))
    
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 18))
    
    let starsLabel = UILabel(text: "stars", font: .systemFont(ofSize: 16))
    
    let bodyLabel = UILabel(text: "ReviewReviewReviewReviewReviewReviewReviewReview", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9489304423, green: 0.9490666986, blue: 0.94890064, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedubviews: [
            UIStackView(arrangedSubviews: [titleLabel, authorLabel]),
            starsLabel,
            bodyLabel
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
