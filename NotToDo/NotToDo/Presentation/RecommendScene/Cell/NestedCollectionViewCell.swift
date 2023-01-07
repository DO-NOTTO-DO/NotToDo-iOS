//
//  NestedCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

import SnapKit
import Then

class NestedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier = "NestedCollectionViewCell"
    
    // MARK: - UI Components
    
    lazy var colorView = UIView()
    lazy var titleLabel = UILabel()
    
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

extension NestedCollectionViewCell {
    private func setUI() {
        backgroundColor = .white
        colorView.do {
            $0.layer.backgroundColor = UIColor.yellow_basic?.cgColor
        }
        titleLabel.do {
            $0.textColor = UIColor.nottodoGray1
            $0.font = .PretendardSemiBold(size: 16.adjusted)
        }
    }
    
    private func setLayout() {
        addSubviews(colorView, titleLabel)
        
        colorView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(11.adjusted)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(13.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    func config(_ item: ItemModel) {
        titleLabel.text = item.subTitle
    }
}
