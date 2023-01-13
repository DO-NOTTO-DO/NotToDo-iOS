//
//  NavigationBarView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

enum NavigationMode {
    case plain
    case addSituation
    case recommend
    case leftRecommend
}

class NavigationBarView: UIView {

    // MARK: - Properties
    
    var navigationMode: NavigationMode
    
    // MARK: - UI Components
    
    var backButton = UIButton()
    private var titleLabel = UILabel()
    var successButton = UIButton()
    private var line = UIView()
    private var recommendLabel = UILabel()
    var createButton = UIButton()
    
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

// MARK: - Methods

extension NavigationBarView {
    private func setupMode(mode: NavigationMode) {
        switch mode {
        case .plain:
            setUI(mode: .plain)
        case .addSituation:
            setUI(mode: .addSituation)
        case .recommend:
            setUI(mode: .recommend)
        case .leftRecommend:
            setUI(mode: .leftRecommend)
        }
        setLayout()
    }
    
    private func setUI(mode: NavigationMode) {
        successButton.do {
            $0.setTitle(I18N.submit, for: .normal)
            $0.setTitleColor(.nottodoBlack, for: .normal)
            $0.titleLabel?.font = .PretendardMedium(size: 18)
        }
        
        line.backgroundColor = .nottodoGray4
        
        switch mode {
        case .plain:
            backButton.setImage(.deletePageBtn, for: .normal)
            titleLabel.do {
                $0.text = I18N.addMission
                $0.textColor = .nottodoBlack
                $0.font = .PretendardSemiBold(size: 22)
            }
            
            successButton.isHidden = true
            createButton.isHidden = true
            line.isHidden = true
            
        case .addSituation:
            backButton.setImage(.leftArrow, for: .normal)
            titleLabel.do {
                $0.text = I18N.addSituation
                $0.textColor = .nottodoGray1
                $0.font = .PretendardSemiBold(size: 22)
            }
            
            successButton.isHidden = false
            createButton.isHidden = true
            line.isHidden = false
            
        case .recommend:
            backButton.setImage(.leftArrow, for: .normal)
            titleLabel.do {
                $0.text = I18N.recommend
                $0.textColor = .nottodoGray1
                $0.font = .PretendardSemiBold(size: 22)
            }
            
            successButton.isHidden = true
            createButton.isHidden = true
            line.isHidden = false
            
        case .leftRecommend:
            recommendLabel.do {
                $0.text = I18N.recommendMainTitle
                $0.textColor = .nottodoGray1
                $0.font = .PretendardSemiBold(size: 22)
            }
            
            createButton.do {
                $0.setTitle(I18N.recommendButtonTitle, for: .normal)
                $0.titleLabel!.font = .PretendardMedium(size: 14.adjusted)
                $0.setTitleColor(UIColor.nottodoGray2, for: .normal)
            }
            
            successButton.isHidden = true
            createButton.isHidden = false
            line.isHidden = true
        }
        backgroundColor = .nottodoWhite
    }
    
    private func setLayout() {
        addSubviews(backButton, titleLabel, successButton, recommendLabel, createButton, line)
        
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
        
        createButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26.adjusted)
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
        
        recommendLabel.snp.makeConstraints {
            $0.centerY.equalTo(createButton)
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
        
        line.snp.makeConstraints {
            $0.top.equalToSuperview().offset(68.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5.adjusted)
        }
    }
}
