//
//  AddSituationHeaderView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

class AddSituationHeaderView: UICollectionReusableView {
    
    // MARK: - Identifier
    
    static let identifier: String = "AddSituationHeaderView"
    
    // MARK: - UI Components
    
    private var icon = UIImageView()
    private var titleLabel = UILabel()
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Icon(icon: UIImage?) {
        self.icon.image = icon
    }
    
    func HeaderTitle(title: String?) {
        self.titleLabel.text = title
    }
}

// MARK: - Extensions

extension AddSituationHeaderView {
    
    private func setUI() {
        titleLabel.do {
            $0.textColor = .nottodoGray1
            $0.font = .PretendardMedium(size: 16.adjusted)
        }
    }
    
    private func setLayout() {
        addSubviews(titleLabel, icon)
        
        icon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(13.adjusted)
            $0.height.width.equalTo(30.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(icon.snp.centerY)
            $0.leading.equalTo(icon.snp.trailing).offset(4.adjusted)
        }
    }
}
