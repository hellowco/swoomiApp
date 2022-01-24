//
//  MiniChampCollectionViewCell.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/10.
//

import SnapKit
import UIKit
import Kingfisher

final class MiniChampCollectionViewCell: UICollectionViewCell {
    static var height: CGFloat { 50.0 }
//    static var width: CGFloat { 70.0 }

    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "coffee.png")
        let imageView = UIImageView()
        
        let imageSize = frame.width - 20.0
        let frame = CGRect(x: 0 , y: 0 , width:  imageSize, height: imageSize)
        let countLabel = UILabel(frame: frame)
        countLabel.textAlignment = .center
        countLabel.text = "100"
        countLabel.font = .systemFont(ofSize: 20.0, weight: .regular)
        countLabel.textColor = .white
        
        imageView.image = image
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = ( bounds.width - 20 ) / 2
        imageView.clipsToBounds = true
        imageView.addSubview(countLabel)

        return imageView
    }()
    
    private lazy var spellViewOne: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3.0
        
        let spellImageOne = spellImageOne
        let spellLabelOne = spellLabelOne
        
        [
            spellImageOne,
            spellLabelOne
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var spellViewTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3.0
        
        let spellImageTwo = spellImageTwo
        let spellLabelTwo = spellLabelTwo
        
        [
            spellImageTwo,
            spellLabelTwo
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var spellImageOne: UIImageView = {
        let image = UIImage(named: "coffee.jpeg")
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 7.0

        return imageView
    }()

    private var spellLabelOne: UILabel = {
        let label = UILabel()
        label.text = "스펠1"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .secondaryLabel

        return label
    }()
    
    private lazy var spellImageTwo: UIImageView = {
        let image = UIImage(named: "coffee.jpeg")
        let imageView = UIImageView()
        imageView.image = image
        
        imageView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 7.0

        return imageView
    }()

    private var spellLabelTwo: UILabel = {
        let label = UILabel()
        label.text = "스펠2"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .secondaryLabel

        return label
    }()

    func setup() {
        setupLayout()

//        titleLabel.text = rankingFeature.title
//        descriptionLabel.text = rankingFeature.description
//        inAppPurchaseInfoLabel.isHidden = !rankingFeature.isInPurchaseApp
    }

}

private extension MiniChampCollectionViewCell {
    func setupLayout() {
        [
            imageView,
            spellViewOne,
            spellViewTwo
        ].forEach { addSubview($0) }

        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(4.0)
//            $0.bottom.equalToSuperview().inset(4.0)
            $0.width.equalTo(frame.width - 20.0)
            $0.height.equalTo(frame.width - 20.0)
        }

        spellViewOne.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(4.0)
//            $0.bottom.equalToSuperview().inset(4.0)
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height/4)

        }

        spellViewTwo.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(spellViewOne.snp.bottom)//.inset(4.0)
//            $0.bottom.equalToSuperview().inset(4.0)
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height/4)
        }
    }
}

