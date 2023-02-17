//
//  KakaoAuthView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/02/07.
//

import UIKit

import SnapKit
import Then
import Combine
import KakaoSDKUser

final class KakaoAuthView: UIView {
    
    // MARK: - UI Components
    
    private var dismissButton = UIButton()
    var loginImageView = UIImageView()
    var loginLabel = UILabel()
    private var kakaoLoginButton = UIButton()
    private var kakaoLogoutButton = UIButton()
    private var loginStatusLabel = UILabel()
    lazy var kakaoAuthModel: KakaoAuthModel = { KakaoAuthModel() }()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setBindings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KakaoAuthView {
    private func setUI() {
        backgroundColor = .nottodoWhite
        dismissButton.setBackgroundImage(.deletePageBtn, for: .normal)
        // loginImageView.image = .login
        kakaoLoginButton.do {
            $0.setBackgroundImage(.kakaoLoginButton, for: .normal)
            $0.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        }
        
        kakaoLogoutButton.do {
            $0.setTitle("카카오 로그아웃", for: .normal)
            $0.setTitleColor(.nottodoGray1, for: .normal)
            $0.titleLabel?.font = .PretendardRegular(size: 14)
            $0.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        }
        
        loginLabel.do {
            $0.font = .PretendardBold(size: 20)
            $0.textColor = .nottodoGray1
            $0.textAlignment = .center
            $0.text = I18N.login
            $0.numberOfLines = 0
        }
        
        loginStatusLabel.do {
            $0.font = .PretendardRegular(size: 12)
            $0.textColor = .nottodoGray1
            $0.text = I18N.agreeLogin
        }
    }
    
    private func setLayout() {
        addSubviews(dismissButton, loginImageView, kakaoLoginButton,
                    kakaoLogoutButton, loginLabel, loginStatusLabel)
        
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
        
        loginStatusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(120.adjusted)
        }
        
        kakaoLogoutButton.snp.makeConstraints {
            $0.bottom.equalTo(loginStatusLabel.snp.top).offset(-17.adjusted)
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(50.adjusted)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(kakaoLogoutButton.snp.top).offset(-13.adjusted)
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(50.adjusted)
        }
    }
    
    // MARK: - @objc Methods
    
    @objc func loginButtonClicked() {
        print("login button clicked")
        kakaoAuthModel.KakaoLogin()
    }
    
    @objc func logoutButtonClicked() {
        print("logout button clicked")
        kakaoAuthModel.kakaoLogout()
    }
    
    fileprivate func setBindings() {
        var nickname: String?
        var imageUrl: Any?
        
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            } else {
                print("me() success.")
                
                // do something
                _ = user
                
               nickname = user?.kakaoAccount?.profile?.nickname
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                   let data = try? Data(contentsOf: url) {
                    imageUrl = try? Data(contentsOf: url)
                }
            }
        }
        
        self.kakaoAuthModel.$isLoggedIn.sink { [weak self] isLoggedIn in
            guard let self = self else { return }
            self.loginStatusLabel.text = isLoggedIn ? "로그인 상태입니다." : "로그아웃 상태입니다."
            self.loginLabel.text = isLoggedIn ? nickname : I18N.login
            self.loginImageView.image = isLoggedIn ? UIImage(data: imageUrl as! Data) : .login
        }
        .store(in: &subscriptions)
    }
}
