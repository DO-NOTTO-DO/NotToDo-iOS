//
//  myInfoMenuCollectionViewCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class myInfoMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier = "myInfoMenuCollectionViewCell"
    
    // MARK: - UI Components
    
    private var iconImageView = UIImageView()
    private var menuLabel = UILabel()
    private var goToMenuButton = UIButton()
    
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

extension myInfoMenuCollectionViewCell {
    private func setUI() {
        backgroundColor = .nottodoWhite
        contentView.layer.addBorder([.bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
        menuLabel.do {
            $0.font = .PretendardRegular(size: 14)
            $0.textColor = .nottodoBlack
        }
    }
    
    func configure(_ menuTitle: String, menuIcon: UIImage?, rightButton: UIImage?) {
        menuLabel.text = menuTitle
        guard let icon = menuIcon else {
            iconImageView.isHidden = true
            return
        }
        guard let buttonImage = rightButton else {
            goToMenuButton.isHidden = true
            return
        }
        iconImageView.image = icon
        goToMenuButton.setBackgroundImage(buttonImage, for: .normal)
    }
    
    func setLayout() {
        contentView.addSubviews(iconImageView, menuLabel, goToMenuButton)
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.adjusted)
            $0.size.equalTo(30.adjusted)
        }
        
        menuLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(4.adjusted)
        }
        
        goToMenuButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18.adjusted)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24.adjusted)
        }
    }
    
}
