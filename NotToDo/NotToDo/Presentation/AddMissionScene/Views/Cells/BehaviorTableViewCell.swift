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
    
    private let behaviorLabel = UILabel()
    private let recommendButton = UIButton()
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
        behaviorLabel.do {
            $0.text = "구체적인 실천 행동은 무엇인가요?"
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        
        behaviorTextField.do {
            $0.backgroundColor = .nottodoWhite
            $0.borderStyle = .line
            $0.font = .PretendardMedium(size: 16)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 13.15, height: 0.0))
            $0.leftViewMode = .always
            $0.placeholder = "ex) 9시 이후 휴대폰 가방에 넣기" // color 설정 필요
        }
    }
    
    private func setLayout() {
        backgroundColor = .nottodoBlue
        [behaviorLabel, recommendButton, addBehaviorButton, behaviorTextField].forEach {
            self.addSubview($0)
        }
        
        behaviorLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        behaviorTextField.snp.makeConstraints {
            $0.top.equalTo(self.behaviorLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-73)
            $0.height.equalTo(46)
        }
    }
}
