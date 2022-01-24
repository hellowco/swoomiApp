//
//  NotInGameViewController.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/17.
//

import UIKit
import SnapKit

final class NotInGameViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "coffee.jpeg")
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = ( 50.0 / 2 )
        imageView.clipsToBounds = true

        return imageView
    }()
    
    private lazy var summonerName: UILabel = {
        let label = UILabel()
        label.text = "스펠1"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
}

private extension NotInGameViewController {
    func setupLayout() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            $0.top.equalToSuperview()
//            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(50.0)
            $0.width.equalTo(50.0)
//            $0.trailing.equalToSuperview()
        }

        view.addSubview(summonerName)
        summonerName.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            $0.bottom.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).inset(4.0)
//            $0.width.equalToSuperview()
        }
    }
}
