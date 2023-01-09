//
//  StartOnboardingView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class StartOnboardingView: UIView {

    // MARK: UI Components
    
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let onboardingImage = UIImageView()
    let startButton = NotTodoButton(frame: CGRect(), mode: .plain, text: I18N.startButton, image: nil, font: .medium, size: 16.adjusted)
    
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

extension StartOnboardingView {
    private func setUI() {
        backgroundColor = .BG
        logoImageView.image = .onboardingLogo
        onboardingImage.image = Numbers.height < 700 ? .startSEOnboarding : .startOnboarding
        
        titleLabel.do {
            $0.text = I18N.startOnboardingTitle
            $0.font = .PretendardBold(size: 25.adjusted)
            $0.textColor = .nottodoBlack
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        subtitleLabel.do {
            $0.text = I18N.startOnboardingSubTitle
            $0.font = .PretendardRegular(size: 16.adjusted)
            $0.textColor = .nottodoGray1
            $0.textAlignment = .center
        }
    }
    
    private func setLayout() {
        addSubviews(logoImageView, titleLabel, subtitleLabel,
                    onboardingImage, startButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(46.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(86.adjusted)
            $0.height.equalTo(30.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(41.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(68.adjusted)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(22.adjusted)
        }
        
        startButton.snp.makeConstraints {
            $0.height.equalTo(50.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(8.adjusted)
        }
        
        onboardingImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(49.adjusted)
            $0.bottom.equalTo(startButton.snp.top).offset(-70.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(49.adjusted)
            if Numbers.height < 700 {
                $0.height.equalTo(368)
            } else {
                $0.height.equalTo(290.adjusted)
            }
        }
    }
}
