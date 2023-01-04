//
//  HomeView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/02.
//

import UIKit

import SnapKit
import Then

class HomeView: UIView {
    
    var button = UIButton()
    
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

extension HomeView {
    private func setUI() {
        button.do {
            $0.setTitle("테스트버튼", for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
    }
    
    private func setLayout() {
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30.adjusted)
            $0.height.equalTo(15.adjusted)
        }
    }
}
