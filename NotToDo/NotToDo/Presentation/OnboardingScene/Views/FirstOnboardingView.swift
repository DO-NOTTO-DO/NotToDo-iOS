//
//  FirstOnboardingView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class FirstOnboardingView: UIView {
    
    // MARK: UI Components
    
    private let indexLabel = UILabel()
    private let indexView = UIView()
    private let firstTitleLabel = UILabel()
    let jumpButton = UIButton()
    private let onboardingImage = UIImageView()
    let nextButton = UIButton()
    private let progressBar = UIImageView()
    
    // MARK: - Life Cycle
    
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

extension FirstOnboardingView {
    private func setUI() {
        backgroundColor = .BG
        indexView.backgroundColor = .yellow_basic
        onboardingImage.image = Numbers.height < 700 ? .firstSEOnboarding : .firstOnboarding
        progressBar.image = .progressBarFirst
        
        indexLabel.do {
            $0.text = I18N.firstOnboardingIndex
            $0.font = .PretendardBold(size: 20.adjusted)
            $0.textColor = .nottodoBlack
        }
        
        firstTitleLabel.do {
            $0.text = I18N.firstOnboardingMessage
            $0.textColor = .nottodoBlack
            $0.textAlignment = .left
            $0.font = .PretendardRegular(size: 25.adjusted)
            $0.partFontChange(targetString: "구체적으로 작성", font: .PretendardBold(size: 25.adjusted))
            $0.numberOfLines = 0
        }
        
        jumpButton.do {
            $0.setTitle(I18N.jump, for: .normal)
            $0.setTitleColor(.nottodoGray2, for: .normal)
            $0.titleLabel?.font = .PretendardRegular(size: 16.adjusted)
        }
        
        nextButton.setBackgroundImage(.nextArrowButton, for: .normal)
    }
    
    private func setLayout() {
        indexView.addSubview(indexLabel)
        addSubviews(jumpButton, indexView, firstTitleLabel, onboardingImage, nextButton, progressBar)
        
        indexLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(5.adjusted)
            $0.directionalVerticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview().inset(2.adjusted)
        }
        
        jumpButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(11.adjusted)
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
        
        indexView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(52.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        firstTitleLabel.snp.makeConstraints {
            $0.top.equalTo(indexView.snp.bottom).offset(15.adjusted)
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(3.adjusted)
            $0.width.equalTo(63.adjusted)
            $0.height.equalTo(34.adjusted)
        }
        
        onboardingImage.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(firstTitleLabel.snp.bottom).offset(73.adjusted)
            if Numbers.height < 700 {
                $0.height.equalTo(322)
            } else {
                $0.height.equalTo(351.adjusted)
            }
        }
        
        progressBar.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-17.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
    
