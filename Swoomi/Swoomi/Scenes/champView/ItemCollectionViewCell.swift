//
//  ItemCollectionViewCell.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/20.
//

import SnapKit
import UIKit
import Kingfisher

final class ItemCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "coffee.png")
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true

        return imageView
    }()
  

    func setup() {
        setupLayout()

//        titleLabel.text = rankingFeature.title
//        descriptionLabel.text = rankingFeature.description
//        inAppPurchaseInfoLabel.isHidden = !rankingFeature.isInPurchaseApp
    }

}

private extension ItemCollectionViewCell {
    func setupLayout() {
        [
            imageView
        ].forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(4.0)
            $0.width.equalTo(37.0)
            $0.height.equalTo(37.0)
        }
    }
}
