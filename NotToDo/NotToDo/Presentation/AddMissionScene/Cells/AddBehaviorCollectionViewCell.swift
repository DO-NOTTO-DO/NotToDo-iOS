//
//  AddBehaviorCollectionViewCell.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/10.
//

import UIKit

import SnapKit
import Then

class AddBehaviorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "AddBehaviorCollectionViewCell"
    
    // MARK: - UI Components
    
    let addBehaviorLabel = CustomPaddingLabel(padding: .init(top: 11.5, left: 15, bottom: 11.5, right: 15))
    let deleteBehaviorButton = UIButton()
    
    // MARK: - View Life Cycle
    
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

// MARK: - Methods

extension AddBehaviorCollectionViewCell {
    private func setUI() {
        backgroundColor = .nottodoWhite
        
        addBehaviorLabel.do {
            $0.font = .PretendardMedium(size: 14.adjusted)
            $0.textColor = .nottodoGray2
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.layer.borderWidth = 0.5.adjusted
        }
        
        deleteBehaviorButton.do {
            $0.setImage(.deleteBtn, for: .normal)
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(addBehaviorLabel, deleteBehaviorButton)
        
        addBehaviorLabel.snp.makeConstraints {
            $0.height.equalTo(40.adjusted)
            $0.top.leading.equalToSuperview()
        }
        
        deleteBehaviorButton.snp.makeConstraints {
            $0.leading.equalTo(addBehaviorLabel.snp.trailing)
            $0.height.width.equalTo(40.adjusted)
        }
    }
    
    func configure(model: AddBehaviorModel) {
        addBehaviorLabel.text = model.behavior
    }
}
