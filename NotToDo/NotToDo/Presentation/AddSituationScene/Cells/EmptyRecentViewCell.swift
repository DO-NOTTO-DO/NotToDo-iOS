//
//  EmptyAddSituationViewCell.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

class EmptyRecentCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "EmptyRecentCollectionViewCell"
    
    // MARK: - UI Components
    
    private let emptyRecentLabel = UILabel()
    
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

extension EmptyRecentCollectionViewCell {
    private func setUI() {
        emptyRecentLabel.do {
            $0.text = I18N.emptyHistory
            $0.font = .PretendardRegular(size: 14.adjusted)
            $0.textColor = .nottodoGray2
            $0.textAlignment = .center
        }
    }
    
    private func setLayout() {
        contentView.addSubview(emptyRecentLabel)
        
        emptyRecentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-20.adjusted)
            $0.bottom.equalToSuperview()
        }
    }
}
