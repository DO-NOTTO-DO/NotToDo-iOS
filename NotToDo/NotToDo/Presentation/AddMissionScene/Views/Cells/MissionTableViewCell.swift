//
//  MissionTableViewCell.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

// MARK: - MissionTableViewCell

final class MissionTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "MissionTableViewCell"
    
    // MARK: - UI Components
    
    private let missionLabel = UILabel()
    private let missionTextField = UITextField()
    
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

extension MissionTableViewCell {
    
    // MARK: - UI Helpers
    
    private func setUI() {
        missionLabel.do {
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        
        missionTextField.do {
            $0.backgroundColor = .nottodoWhite
            $0.borderStyle = .line
            $0.font = .PretendardMedium(size: 16)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 13.15, height: 0.0))
            $0.leftViewMode = .always
//            $0.placeholder = "" // color 설정 필요
        }
    }
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        backgroundColor = .nottodoBlue
        [missionLabel, missionTextField].forEach {
            self.addSubview($0)
        }
        
        missionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        missionTextField.snp.makeConstraints {
            $0.top.equalTo(self.missionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(46)
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(model: MissionModel) {
        missionLabel.text = model.label
        missionTextField.text = model.textField
    }
}
