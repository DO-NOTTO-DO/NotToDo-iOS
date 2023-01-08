//
//  TitleView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/08.
//

import UIKit

import SnapKit
import Then

class TitleView: UIView {
    
    private let titleLabel = CustomAchieveLabel(color: .nottodoBlack!, font: .PretendardBold(size: 22))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleView {
    func setUI() {
        addSubview(titleLabel)
        
        titleLabel.text = I18N.achievementMainTitle
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
    }
}
