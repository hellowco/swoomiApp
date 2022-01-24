//
//  SearchBarView.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/10.
//

import SnapKit
import UIKit

final class SearchBarView1: UIView {
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()

        searchBar.placeholder = "소환사 이름을 입력해주세요."
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 15.0)
        searchBar.backgroundColor = .tertiarySystemGroupedBackground
        searchBar.layer.cornerRadius = 15.0

        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(searchBarView)

        searchBarView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.bottom.equalToSuperview().offset(32.0)
            $0.height.equalTo(40.0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
