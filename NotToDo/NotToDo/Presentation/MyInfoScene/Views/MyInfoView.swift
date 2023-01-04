//
//  MyInfoView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class MyInfoView: UIView {
    
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
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyInfoView {
    private func setUI() {

    }
    
    private func setLayout() {
        
    }
}
