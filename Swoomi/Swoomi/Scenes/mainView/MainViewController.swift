//
//  MainViewController.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/10.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
    
//    private lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 0.0
        
//        let featureSectionView = FeatureSectionView(frame: .zero)
//        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
//        let searchBarView = SearchBarView(frame: .zero)
//
//        let spacingView = UIView()
//        spacingView.snp.makeConstraints {
//            $0.height.equalTo(100.0)
//        }
        
//        [
//            featureSectionView,
//            rankingFeatureSectionView,
//            searchBarView,
//            spacingView
//        ].forEach {
//            stackView.addArrangedSubview($0)
//        }
//
//        return stackView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
//        setupNavigationController()
//        setupLayout()
    }
    
    private func setNavigationItems() {
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Swoomi"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "소환사 이름을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
}

//private extension MainViewController {
//    func setupNavigationController() {
//        navigationItem.title = "SWOOMI"
//        navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//
//    func setupLayout() {
//        view.addSubview(scrollView)
//        scrollView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            $0.bottom.equalToSuperview()
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview()
//        }
//
//        scrollView.addSubview(contentView)
//        contentView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.width.equalToSuperview()
//        }
//
//        contentView.addSubview(stackView)
//        stackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//}

extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let ab = true
        if ab {
            self.navigationController?.pushViewController(ChampCollectionViewController(), animated: true)
        } else {
            self.navigationController?.pushViewController(NotInGameViewController(), animated: true)
        }
        
    }
}
