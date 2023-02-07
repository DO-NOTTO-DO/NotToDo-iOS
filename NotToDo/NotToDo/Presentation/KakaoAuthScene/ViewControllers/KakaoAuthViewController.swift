//
//  KakaoAuthViewController.swift
//  NotToDo
//
//  Created by 김민서 on 2023/02/07.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoAuthViewController: UIViewController {
    
    // MARK: - UI Components
    
    var kakaoAuthView: KakaoAuthView!

    // MARK: - Life View
    
    override func loadView() {
        super.loadView()
        kakaoAuthView = KakaoAuthView(frame: self.view.frame)
        view = kakaoAuthView
    }
}
