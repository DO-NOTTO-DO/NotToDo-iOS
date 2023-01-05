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
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension myInfoUserCollectionViewCell {
    private func setUI() {
        backgroundImageView.image = .myInfoBackground
        userImageView.image = .home         // 이미지 에셋 추가 후 변경
        userNameLabel.do {
            $0.text = "홍서현"
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        userEmailLabel.do {
            $0.text = "ghdtjgus123!"
            $0.textColor = .nottodoGray2
            $0.font = .PretendardRegular(size: 14)
        }
        threeSecLoginLabel.do {
            $0.text = I18N.threeSecLogin
            $0.textColor = .nottodoGray1
            $0.font = .PretendardRegular(size: 16)
        }
        subLoginLabel.do {
            $0.text = I18N.loginGuide
            $0.textColor = .nottodoGray2
            $0.font = .PretendardRegular(size: 12)
        }
        goToLoginImageView.image = .rightArrow      // rightArrow 색 다름 변경
        contentView.layer.addBorder([.top, .bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
    }
    
    func setLayout(isLogin: Bool) {
        contentView.addSubviews(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        isLogin ? setLoginLayout() : setBeforeLoginLayout()
    }
    
    private func setLoginLayout() {
        contentView.addSubviews(userImageView, userNameLabel, userEmailLabel)
        
        userImageView.snp.makeConstraints {
            $0.size.equalTo(69.adjusted)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29.adjusted)
            $0.leading.equalTo(userImageView.snp.trailing).offset(18.adjusted)
        }
        
        userEmailLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(3.adjusted)
            $0.leading.equalTo(userNameLabel.snp.leading)
        }
    }
    
    private func setBeforeLoginLayout() {
        contentView.addSubviews(threeSecLoginLabel, goToLoginImageView, subLoginLabel)
        
        threeSecLoginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
        }
        
        goToLoginImageView.snp.makeConstraints {
            $0.centerY.equalTo(threeSecLoginLabel)
            $0.leading.equalTo(threeSecLoginLabel.snp.trailing)
            $0.size.equalTo(24.adjusted)
        }
        
        subLoginLabel.snp.makeConstraints {
            $0.leading.equalTo(threeSecLoginLabel.snp.leading)
            $0.top.equalTo(goToLoginImageView.snp.bottom).offset(6.adjusted)
        }
    }
}
