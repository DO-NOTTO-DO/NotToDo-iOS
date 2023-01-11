//
//  AddMissionTitleView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

final class AddMissionTitleView: UIView {
    
    // MARK: - UI Components
    
    var AddMissionTitleLabel = UILabel()
    let AddMissionButton = UIButton(configuration: .plain())
    
    // MARK: - View Life Cycles
    
    init(frame: CGRect, titleLabel: String, buttonLabel: String?, icon: UIImage?) {
        super.init(frame: frame)
        setUI(titleLabel: titleLabel, buttonLabel: buttonLabel, icon: icon)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension AddMissionTitleView {
    private func setUI(titleLabel: String, buttonLabel: String?, icon: UIImage?) {
        AddMissionTitleLabel.do {
            $0.text = titleLabel
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        
        AddMissionButton.do {
            $0.configuration?.title = buttonLabel ?? ""
            $0.configuration?.image = icon ?? nil
            $0.configuration?.titleAlignment = .trailing
            $0.titleLabel?.font = .PretendardMedium(size: 16)
            $0.configuration?.baseForegroundColor = .nottodoGray2
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.trailing
            $0.configuration?.buttonSize = .small
            $0.configuration?.baseBackgroundColor = .clear
            $0.configuration?.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }
    
    private func setLayout() {
        addSubviews(AddMissionTitleLabel, AddMissionButton)
        
        AddMissionTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
        
        AddMissionButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-14.adjusted)
            $0.centerY.equalTo(AddMissionTitleLabel)
        }
    }
}
