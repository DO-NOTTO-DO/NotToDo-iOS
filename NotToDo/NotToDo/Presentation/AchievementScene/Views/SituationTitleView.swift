//
//  SituationTitleView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

class SituationTitleView: UIView {
    
    // MARK: - UI Components
    
    lazy var hStack = UIStackView(arrangedSubviews: [icon, subLabel])
    lazy var icon = UIImageView()
    lazy var subLabel = CustomAchieveLabel(color: .nottodoBlack!, font: .PretendardSemiBold(size: 16))
    
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

extension SituationTitleView {
    func setUI() {
        backgroundColor = .clear
        
        hStack.do {
            $0.axis = .horizontal
        }
        icon.do {
            $0.image = .rank
        }
    }
    
    func setLayout() {
        addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
    }
    
    func HeaderTitle(title: String?) {
        self.subLabel.text = title
    }
}
