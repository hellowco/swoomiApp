//
//  MiniChampSectionView.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/10.
//

import SnapKit
import UIKit

final class MiniChampSectionView: UIView {
//    private var rankingFeatureList: [RankingFeature] = []

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .black)
        label.text = "Swoomi"

        return label
    }()

    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("KR/EN", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)

        return button
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 2.0, bottom: 0.0, right: 2.0)

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(
            MiniChampCollectionViewCell.self,
            forCellWithReuseIdentifier: "MiniChampCollectionViewCell"
        )

        return collectionView
    }()

    private let separatorView = SeparatorView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        fetchData()
        collectionView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MiniChampSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
//            width: collectionView.frame.width - 32.0,
//            height: RankingFeatureCollectionViewCell.height
            width: frame.width/5,
            height: collectionView.frame.height
//            width: 100, height: 150
        )
    }
}

extension MiniChampSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MiniChampCollectionViewCell",
            for: indexPath
        ) as? MiniChampCollectionViewCell
//        let rankingFeature = rankingFeatureList[indexPath.item]
        cell?.setup()

        return cell ?? UICollectionViewCell()
    }
}

private extension MiniChampSectionView {
    func setupViews() {
        [
            collectionView,
            separatorView
        ]
            .forEach { addSubview($0) }

//        titleLabel.snp.makeConstraints {
//            $0.leading.equalToSuperview().inset(16.0)
//            $0.top.equalToSuperview().inset(16.0)
//            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8.0)
//        }
//
//        showAllAppsButton.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(16.0)
//            $0.bottom.equalTo(titleLabel.snp.bottom)
//        }

        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()//.inset(16.0)
            $0.height.equalTo(210.0)
//            $0.width.equalTo(10.0)
            $0.leading.equalToSuperview().inset(6.0)
            $0.trailing.equalToSuperview().inset(6.0)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)//.inset(16.0)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }

    func fetchData() {
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else { return }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
//            rankingFeatureList = result
//        } catch {}
    }
}
