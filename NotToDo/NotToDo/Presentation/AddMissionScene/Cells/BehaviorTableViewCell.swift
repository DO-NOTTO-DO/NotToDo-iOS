//
//  BehaviorTableViewCell.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

// MARK: - BehaviorTableViewCell

final class BehaviorTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "BehaviorTableViewCell"
    
    // MARK: - UI Components
    
    private let behaviorTextField = UITextField()
    private let addBehaviorButton = UIButton()
    
    // MARK: - View Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension BehaviorTableViewCell {
    
    // MARK: - Layout Helpers
    
    private func setUI() {
        
        behaviorTextField.do {
            $0.backgroundColor = .nottodoWhite
            $0.borderStyle = .line
            $0.font = .PretendardMedium(size: 16)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 13.15.adjusted, height: 0.0))
            $0.leftViewMode = .always
            $0.placeholder = "ex) 9시 이후 휴대폰 가방에 넣기" // color 설정 필요
        }
        
        addBehaviorButton.setImage(.plusBtn, for: .normal)
    }
    
    private func setLayout() {
        [behaviorTextField, addBehaviorButton].forEach {
            contentView.addSubview($0)
        }
        
        behaviorTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.trailing.equalToSuperview().offset(-73.adjusted)
            $0.height.equalTo(46.adjusted)
            $0.bottom.equalToSuperview().inset(35.adjusted)
        }
        
        addBehaviorButton.snp.makeConstraints {
            $0.top.equalTo(behaviorTextField)
            $0.leading.equalTo(behaviorTextField.snp.trailing).offset(7.adjusted)
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
    }
}
