//
//  CustomTabBarCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

import SnapKit
import Then

class CustomTabBarCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier = "CustomTabBarCell"
    
    // MARK: - UI Components
    
    private var bgView = UIView()
    private var icImage = UIImageView()
    private var titleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CustomTabBarCell {
    private func setUI() {
        titleLabel.do {
            $0.textAlignment = .center
            $0.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    private func setLayout() {
        addSubview(bgView)
        bgView.addSubviews(icImage, titleLabel)
        
        bgView.snp.makeConstraints {
            $0.height.equalTo(82.adjusted)
            $0.width.equalTo(69.adjusted)
            $0.centerX.centerY.equalToSuperview()
        }
        
        icImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(6.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(12.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(icImage.snp.bottom).offset(6.adjusted)
            $0.bottom.equalToSuperview().inset(11.adjusted)
        }
    }
    
    func configure(_ item: CustomTabBarItem, isSelected: Bool) {
        if isSelected {
            titleLabel.text = item.name
            titleLabel.textColor = .nottodoGray1
            titleLabel.font = .PretendardBold(size: 12.adjusted)
            icImage.image = UIImage(named: item.activeImage)
            bgView.backgroundColor = .yellow_mild
        } else {
            titleLabel.text = item.name
            titleLabel.textColor = .nottodoGray2
            titleLabel.font = .PretendardMedium(size: 12.adjusted)
            icImage.image = UIImage(named: item.image)
            bgView.backgroundColor = .clear
        }
    }
}
