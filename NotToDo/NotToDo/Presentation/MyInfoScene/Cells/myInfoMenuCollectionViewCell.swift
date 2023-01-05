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
        menuLabel.do {
            $0.font = .PretendardRegular(size: 14)
            $0.textColor = .nottodoBlack
        }
    }
    
    private func setBorder(_ row: Int) {
        row == 0 ? contentView.layer.addBorder([.top, .right, .bottom, .left], color: .nottodoGray2!, width: 0.5) : contentView.layer.addBorder([.bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
    }
    
    func configure(_ menuTitle: String, menuIcon: UIImage?, rightButton: UIImage?, indexPath: IndexPath) {
        menuLabel.text = menuTitle
        if let icon = menuIcon {
            iconImageView.isHidden = false
            iconImageView.image = icon
            updateLayout()
        }
        if let buttonImage = rightButton {
            goToMenuButton.isHidden = false
            goToMenuButton.setBackgroundImage(buttonImage, for: .normal)
        }
        setBorder(indexPath.row)
        return
    }
    
    private func updateLayout() {
        menuLabel.snp.remakeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(4.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(iconImageView, menuLabel, goToMenuButton)
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.adjusted)
            $0.size.equalTo(30.adjusted)
        }
        
        menuLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
        
        goToMenuButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18.adjusted)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24.adjusted)
        }
    }
    
}
