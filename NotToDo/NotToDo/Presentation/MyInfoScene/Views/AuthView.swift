//
//  AuthView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class AuthView: UIView {
    
    // MARK: - UI Components
    
    private var dismissButton = UIButton()
    private var loginImageView = UIImageView()
    private var loginLabel = UILabel()
    private var kakaoLoginButton = UIButton()
    private var appleLoginButton = UIButton()
    private var agreeLabel = UILabel()
    
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

extension AuthView {
    private func setUI() {
        backgroundColor = .nottodoWhite
        dismissButton.setBackgroundImage(.deletePageBtn, for: .normal)
        loginImageView.image = .login
        kakaoLoginButton.setBackgroundImage(.kakaoLoginButton, for: .normal)
        appleLoginButton.setBackgroundImage(.appleLoginButton, for: .normal)
        loginLabel.do {
            $0.font = .PretendardBold(size: 20)
            $0.textColor = .nottodoGray1
            $0.textAlignment = .center
            $0.text = I18N.login
            $0.numberOfLines = 0
        }
        agreeLabel.do {
            $0.font = .PretendardRegular(size: 12)
            $0.textColor = .nottodoGray1
            $0.text = I18N.agreeLogin
        }
    }
    
    private func setLayout() {
        addSubviews(dismissButton, loginImageView, kakaoLoginButton,
                    appleLoginButton, loginLabel, agreeLabel)
        
        dismissButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(75.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.size.equalTo(20.adjusted)
        }
        
        loginImageView.snp.makeConstraints {
            $0.top.equalTo(dismissButton.snp.bottom).offset(85.adjusted)
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(121.adjusted)
            $0.height.equalTo(216.adjusted)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(loginImageView.snp.bottom).offset(39.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        agreeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(120.adjusted)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(agreeLabel.snp.top).offset(-17.adjusted)
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(50.adjusted)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-13.adjusted)
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(50.adjusted)
        }
    }
}
