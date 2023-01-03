//
//  NavigationBarView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

// MARK: - NavigationBarView

enum NavigationMode {
    case plain
    case addSituation
    case recommend
}

class NavigationBarView: UIView {

    // MARK: - Properties
    
    private var navigationMode: NavigationMode
    
    // MARK: - UI Components
    
    private var backButton = UIButton()
    private var titleLabel = UILabel()
    private var successButton = UIButton()
    
    // MARK: - View Life Cycle
    
    init(frame: CGRect, mode: NavigationMode) {
        self.navigationMode = mode
        super.init(frame: frame)

        setupMode(mode: mode)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension NavigationBarView {
    
    // MARK: - setupMode
    
    private func setupMode(mode: NavigationMode) {
        switch mode {
        case .plain:
            setUI(mode: .plain)
        case .addSituation:
            setUI(mode: .addSituation)
        case .recommend:
            setUI(mode:.recommend)
        }
        setLayout()
    }
    
    // MARK: - UI Helpers
    
    private func setUI(mode: NavigationMode) {
        successButton.do {
            $0.setTitle("완료", for: .normal)
            $0.setTitleColor(.nottodoGray2, for: .normal)
            $0.titleLabel?.font = .PretendardMedium(size: 18)
        }
        
        switch mode {
        case .plain:
            backButton.setImage(.deletePageBtn, for: .normal)
            titleLabel.do {
                $0.text = "낫투두 추가하기"
                $0.textColor = .nottodoGray1
                $0.font = .PretendardSemiBold(size: 22)
            }
            successButton.do {
                $0.isHidden = true
            }
        case .addSituation:
            backButton.setImage(.leftArrow, for: .normal)
            titleLabel.do {
                $0.text = "상황 추가하기"
                $0.textColor = .nottodoGray1
                $0.font = .PretendardSemiBold(size: 22)
            }
            successButton.isHidden = false
        case .recommend:
            backButton.setImage(.leftArrow, for: .normal)
            titleLabel.do {
                $0.text = "추천받기"
                $0.textColor = .nottodoGray1
                $0.font = .PretendardSemiBold(size: 22)
            }
            successButton.isHidden = true
        }
        backgroundColor = .nottodoWhite
    }
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        [backButton, titleLabel, successButton].forEach {
            addSubview($0)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.width.height.equalTo(20.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        successButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20.adjusted)
        }
    }
}
