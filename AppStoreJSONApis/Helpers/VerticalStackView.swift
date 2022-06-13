//
//  VerticalStackView.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 02.06.2022.
//

import UIKit

class VerticalStackView: UIStackView {

    init(arrangedubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
