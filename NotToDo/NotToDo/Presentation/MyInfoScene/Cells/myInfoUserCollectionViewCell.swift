//
//  myInfoUserCollectionViewCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class myInfoUserCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "myInfoUserCollectionViewCell"
    
    // MARK: - UI Components
    
    private let backgroundImageView = UIImageView()
    private let userImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let userEmailLabel = UILabel()
    private let threeSecLoginLabel = UILabel()
    private let goToLoginImageView = UIImageView()
    private let subLoginLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension myInfoUserCollectionViewCell {
    private func setUI() {
        contentView.layer.addBorder([.all], color: .nottodoGray2!, width: 0.5)
        backgroundImageView.image = .myInfoBackground
    }
    
    private func setLayout() {
        contentView.addSubviews(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
