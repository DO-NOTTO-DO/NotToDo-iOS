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
    
    static var reusedId = "CustomTabBarCell"
    
    // MARK: - UI Components
    
    lazy var bgView = UIView()
    lazy var icImage = UIImageView()
    lazy var titleLabel = UILabel()
    
    // MARK: - Network
    
    func config(_ item: CustomTabBarItem, isSelected: Bool) {
        if isSelected {
            self.titleLabel.text = item.name
            self.titleLabel.textColor = .nottodoGray1
            self.titleLabel.font = .PretendardBold(size: 12.adjusted)
            self.icImage.image = UIImage(named: item.activeImage)
            self.bgView.backgroundColor = .yellow_mild
        } else {
            self.titleLabel.text = item.name
            self.titleLabel.textColor = .nottodoGray2
            self.titleLabel.font = .PretendardMedium(size: 12.adjusted)
            self.icImage.image = UIImage(named: item.image)
            self.bgView.backgroundColor = .clear
        }
    }
    
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
}
