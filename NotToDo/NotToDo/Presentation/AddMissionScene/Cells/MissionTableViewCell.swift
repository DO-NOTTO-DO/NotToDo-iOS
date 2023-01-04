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
        missionTextField.do {
            $0.backgroundColor = .nottodoWhite
            $0.borderStyle = .line
            $0.font = .PretendardMedium(size: 16)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 13.15.adjusted, height: 0.0))
            $0.leftViewMode = .always
        }
    }
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        contentView.addSubview(missionTextField)
        
        missionTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
            $0.bottom.equalToSuperview().inset(35.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    func setPlaceholder(_ placeHolder: String) {
        missionTextField.placeholder = placeHolder
    }
}
