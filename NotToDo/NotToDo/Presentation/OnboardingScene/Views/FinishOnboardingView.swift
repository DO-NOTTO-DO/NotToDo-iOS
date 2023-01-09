//
//  FinishOnboardingView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class FinishOnboardingView: UIView {

    // MARK: UI Components
    
    private let indexLabel = UILabel()
    private let indexView = UIView()
    private let finishTitleLabel = UILabel()
    private let onboardingImage = UIImageView()
    let enrollButton = NotTodoButton(frame: CGRect(), mode: .plain, text: I18N.enroll, image: nil, font: .medium, size: 16.adjusted)
    
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

extension FinishOnboardingView {
    private func setUI() {
        backgroundColor = .BG
        indexView.backgroundColor = .yellow_basic
        onboardingImage.image = Numbers.height < 700 ? .finishSEOnboarding : .finishOnboarding
        
        indexLabel.do {
            $0.text = I18N.finishOnboardingIndex
            $0.font = .PretendardBold(size: 20.adjusted)
            $0.textColor = .nottodoBlack
        }
        
        finishTitleLabel.do {
            $0.text = I18N.finishOnboardingMessage
            $0.textColor = .nottodoBlack
            $0.textAlignment = .left
            $0.font = .PretendardRegular(size: 25.adjusted)
            $0.setAttributedText(
                targetFontList: ["통계": .PretendardBold(size: 25.adjusted)],
                targetColorList: [:])
            $0.numberOfLines = 0
        }
    }
    
    private func setLayout() {
        indexView.addSubview(indexLabel)
        addSubviews(onboardingImage, indexView,
                    finishTitleLabel, enrollButton)
        
        indexLabel.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().inset(5.adjusted)
            $0.trailing.equalToSuperview().inset(2.adjusted)
        }
        
        indexView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(52.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        finishTitleLabel.snp.makeConstraints {
            $0.top.equalTo(indexView.snp.bottom).offset(15.adjusted)
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
        
        onboardingImage.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(finishTitleLabel.snp.bottom).inset(33.adjusted)
            if Numbers.height < 700 {
                $0.height.equalTo(399)
            } else {
                $0.height.equalTo(522.adjusted)
            }
        }
        
        enrollButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(50.adjusted)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(15.adjusted)
        }
    }
}
