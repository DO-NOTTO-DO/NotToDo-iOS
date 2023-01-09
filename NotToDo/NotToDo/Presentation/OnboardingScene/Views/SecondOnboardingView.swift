//
//  SecondOnboardingView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class SecondOnboardingView: UIView {

    // MARK: UI Components
    
    private let indexLabel = UILabel()
    private let indexView = UIView()
    private let secondTitleLabel = UILabel()
    let jumpButton = UIButton()
    private let onboardingImage = UIImageView()
    let nextButton = UIButton()
    let beforeButton = UIButton()
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

extension SecondOnboardingView {
    private func setUI() {
        backgroundColor = .BG
        indexView.backgroundColor = .yellow_basic
        onboardingImage.image = Numbers.height < 700 ? .secondSEOnboarding : .secondOnboarding
        progressBar.image = .progressBarSecond
        
        indexLabel.do {
            $0.text = I18N.secondOnboardingIndex
            $0.font = .PretendardBold(size: 20.adjusted)
            $0.textColor = .nottodoBlack
        }
        
        secondTitleLabel.do {
            $0.text = I18N.secondOnboardingMessage
            $0.textColor = .nottodoBlack
            $0.textAlignment = .left
            $0.font = .PretendardRegular(size: 25.adjusted)
            $0.setAttributedText(
                targetFontList: ["정확하게": .PretendardBold(size: 25.adjusted),
                                 "체계적으로": .PretendardBold(size: 25.adjusted)],
                targetColorList: [:])
            $0.numberOfLines = 0
        }
        
        jumpButton.do {
            $0.setTitle(I18N.jump, for: .normal)
            $0.setTitleColor(.nottodoGray2, for: .normal)
            $0.titleLabel?.font = .PretendardRegular(size: 16.adjusted)
        }
        
        nextButton.setBackgroundImage(.nextArrowButton, for: .normal)
        beforeButton.setBackgroundImage(.beforeArrowButton, for: .normal)
    }
    
    private func setLayout() {
        indexView.addSubview(indexLabel)
        addSubviews(jumpButton, indexView, secondTitleLabel,
                    onboardingImage, nextButton, beforeButton, progressBar)
        
        indexLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(5.adjusted)
            $0.directionalVerticalEdges.equalToSuperview().inset(1.adjusted)
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
        
        secondTitleLabel.snp.makeConstraints {
            $0.top.equalTo(indexView.snp.bottom).offset(15.adjusted)
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
        
        onboardingImage.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(secondTitleLabel.snp.bottom).offset(79.adjusted)
            if Numbers.height < 700 {
                $0.height.equalTo(388)
            } else {
                $0.height.equalTo(443.adjusted)
            }
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(3.adjusted)
            $0.width.equalTo(63.adjusted)
            $0.height.equalTo(34.adjusted)
        }
        
        beforeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21.adjusted)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(5.adjusted)
            $0.width.equalTo(61.adjusted)
            $0.height.equalTo(34.adjusted)
        }
        
        progressBar.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-17.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
