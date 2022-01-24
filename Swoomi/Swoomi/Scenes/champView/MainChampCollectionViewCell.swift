//
//  MainChampCollectionViewCell.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/14.
//

import SnapKit
import Kingfisher
import UIKit

final class MainChampCollectionViewCell: UICollectionViewCell {
    private lazy var stackOne: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
        stackView.spacing = 3.0
        stackView.backgroundColor = .tertiarySystemGroupedBackground
        
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.spacing = 3.0
        labelStack.backgroundColor = .tertiarySystemGroupedBackground
        
        let image = UIImage(named: "coffee.png")
        let imageView = UIImageView()
        let imageSize = 80.0
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
        imageView.layer.cornerRadius = imageSize / 2
        imageView.clipsToBounds = true
        imageView.addSubview(countLabel)
        
        let champName = UILabel()
        champName.text = "챔피언"
        champName.font = .systemFont(ofSize: 10.0, weight: .semibold)
        champName.textColor = .green
        
        let summonerName = UILabel()
        summonerName.text = "스펠1"
        summonerName.font = .systemFont(ofSize: 10.0, weight: .semibold)
        summonerName.textColor = .secondaryLabel
        
        let champImage = imageView
        
        [
            champName,
            summonerName
        ].forEach {
            labelStack.addArrangedSubview($0)
        }
        
        [
            champImage,
            labelStack
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        champImage.snp.makeConstraints{
            $0.width.equalTo(imageSize)
//            $0.height.equalTo(imageSize)
        }
        
        labelStack.snp.makeConstraints{
//            $0.leading.equalTo(champImage.snp.trailing)
            $0.top.equalToSuperview()
//            $0.width.equalTo(frame.width / 2)
        }
        
        return stackView
    }()
    
    private lazy var stackTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
        stackView.spacing = 3.0
//        stackView.layer.cornerRadius = 7.0
//        stackView.layer.borderWidth = 0.5
        
        let spellImageOne = haveItemCollectionView
        let spellLabelOne = willItemCollectionView
        
        [
            spellImageOne,
            spellLabelOne
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var willItemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = true

        collectionView.register(
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: "ItemCollectionViewCell"
        )

        return collectionView
    }()
    
    private lazy var haveItemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.isPagingEnabled = true
        collectionView1.backgroundColor = .systemBackground
        collectionView1.showsHorizontalScrollIndicator = false

        collectionView1.register(
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: "ItemCollectionViewCell"
        )

        return collectionView1
    }()
    
    private lazy var stackThree: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1.0
        
        let spellImage = UIImageView()
        let image = UIImage(named: "coffee.png")
        spellImage.image = image
        spellImage.layer.cornerRadius = 7.0
        spellImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        spellImage.layer.borderWidth = 0.5
        spellImage.clipsToBounds = true
        
//        let imageSize = 80.0
//        let frame = CGRect(x: 0 , y: 0 , width:  imageSize, height: imageSize)
//        let spellTime = UILabel(frame: frame)
//        spellTime.text = "90s"
//        spellTime.textColor = .black
//        spellImage.addSubview(spellTime)
        
        let spellButton0s = UIButton()
        spellButton0s.layer.borderWidth = 0.5
        spellButton0s.setTitle("0s전", for: .normal)
        spellButton0s.backgroundColor = .black
        let spellButton15s = UIButton()
        spellButton15s.layer.borderWidth = 0.5
        spellButton15s.setTitle("15s전", for: .normal)
        spellButton15s.backgroundColor = .black
        let spellButton30s = UIButton()
        spellButton30s.layer.cornerRadius = 7.0
        spellButton30s.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        spellButton30s.layer.borderWidth = 0.5
        spellButton30s.setTitle("30s전", for: .normal)
        spellButton30s.backgroundColor = .black
        
        [
            spellImage,
            spellButton0s,
            spellButton15s,
            spellButton30s
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var stackFour: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1.0
        
        let spellImage = UIImageView()
        spellImage.layer.cornerRadius = 7.0
        spellImage.layer.borderWidth = 0.5
        let spellButton0s = UIButton()
        spellButton0s.layer.cornerRadius = 7.0
        spellButton0s.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        spellButton0s.layer.borderWidth = 0.5
        spellButton0s.setTitle("0s전", for: .normal)
        spellButton0s.backgroundColor = .black
        let spellButton15s = UIButton()
        spellButton15s.layer.borderWidth = 0.5
        spellButton15s.setTitle("15s전", for: .normal)
        spellButton15s.backgroundColor = .black
        let spellButton30s = UIButton()
        spellButton30s.layer.cornerRadius = 7.0
        spellButton30s.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        spellButton30s.layer.borderWidth = 0.5
        spellButton30s.setTitle("30s전", for: .normal)
        spellButton30s.backgroundColor = .black
        
        [
            spellImage,
            spellButton0s,
            spellButton15s,
            spellButton30s
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var stackFive: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1.0
        
        let spellImage = UIImageView()
        spellImage.layer.cornerRadius = 7.0
        spellImage.layer.borderWidth = 0.5
        let spellButton0s = UIButton()
        spellButton0s.layer.cornerRadius = 7.0
        spellButton0s.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        spellButton0s.layer.borderWidth = 0.5
        spellButton0s.setTitle("0s전", for: .normal)
        spellButton0s.backgroundColor = .black
        let spellButton15s = UIButton()
        spellButton15s.layer.borderWidth = 0.5
        spellButton15s.setTitle("15s전", for: .normal)
        spellButton15s.backgroundColor = .black
        let spellButton30s = UIButton()
        spellButton30s.layer.cornerRadius = 7.0
        spellButton30s.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        spellButton30s.layer.borderWidth = 0.5
        spellButton30s.setTitle("30s전", for: .normal)
        spellButton30s.backgroundColor = .black
        
        [
            spellImage,
            spellButton0s,
            spellButton15s,
            spellButton30s
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    func setup() {
        setupLayout()

//        titleLabel.text = rankingFeature.title
//        descriptionLabel.text = rankingFeature.description
//        inAppPurchaseInfoLabel.isHidden = !rankingFeature.isInPurchaseApp
    }


}

private extension MainChampCollectionViewCell {
    func setupLayout() {
        [
            stackOne,
            stackTwo,
            stackThree,
            stackFour,
            stackFive
        ].forEach { addSubview($0) }

        stackOne.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height/5)
        }

        stackTwo.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(stackOne.snp.bottom)
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height/5)
        }

        stackThree.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(stackTwo.snp.bottom)
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height/5)
        }

        stackFour.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(stackThree.snp.bottom)
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height/5)
        }
        
        stackFive.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(stackFour.snp.bottom)
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height/5)
//            $0.bottom.equalToSuperview().inset(8.0)
        }
    }

}

extension MainChampCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 37.0, height: 37.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4.0
    }
}

extension MainChampCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell
//        let feature = featureList[indexPath.item]
        cell?.setup()

        return cell ?? UICollectionViewCell()
    }
    
}
