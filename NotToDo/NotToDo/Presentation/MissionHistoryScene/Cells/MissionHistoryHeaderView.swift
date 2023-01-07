//
//  MissionHistoryHeaderView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

class MissionHistoryHeaderView: UICollectionReusableView {
    
    // MARK: - Identifier
    
    static let identifier: String = "MissionHistoryHeaderView"
    
    // MARK: - UI Components
    
    private lazy var icon = UIImageView()
    private lazy var titleLabel = UILabel()
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension MissionHistoryHeaderView {
    
    private func setUI() {
        icon.do {
            $0.image = .recentSearch
        }
        
        titleLabel.do {
            $0.text = I18N.missionHistory
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16.adjusted)
        }
    }
    
    private func setLayout() {
        addSubviews(icon, titleLabel)
        
        icon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(30.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(icon.snp.centerY)
            $0.leading.equalTo(icon.snp.trailing).offset(4.adjusted)
        }
    }
}
