//
//  KakaoAuthModel.swift
//  NotToDo
//
//  Created by 김민서 on 2023/02/07.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import UIKit

class KakaoAuthModel: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var isLoggedIn: Bool = false
    
//    init() {
//        print("KakaoAuthModel - init() called")
//    }
    
    // 카카오톡 앱으로 로그인
    func kakaoLoginWithApp() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("loginWithKakaoTalk() success.")
                    
                    // do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                    
                    let accessToken = oauthToken?.accessToken
                }
            }
        }
    }
    
    // 카카오 계정으로 로그인
    func kakaoLoginWithAccocunt() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("loginWithKakaoAccount() success.")
                    
                    // do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                    
                    let accessToken = oauthToken?.accessToken
                }
            }
        }
    }
    
    @MainActor
    func KakaoLogin() {
        print("KakaoAuthModel - handleKakaoLogin() called")
        Task {
            // 카카오톡 설치 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                isLoggedIn = await kakaoLoginWithApp()
            } else { // 카톡 설치가 안 된 경우
                isLoggedIn = await kakaoLoginWithAccocunt()
            }
        }
    } // login
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogout() {
                self.isLoggedIn = false
            }
        }
    }
    
    func handleKakaoLogout() async -> Bool {
        
        await withCheckedContinuation() { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
}
