//
//  myInfoFooterCollectionReusableView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/05.
//

import UIKit

import SnapKit
import Then

final class myInfoFooterCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static var identifier = "myInfoFooterCollectionReusableView"
    
    // MARK: - UI Components
    
    private let stackView = UIStackView()
    private let logoutLabel = UILabel()
    private let withdrawalLabel = UILabel()
    private let dividingLineView = UIView()
    
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

extension myInfoFooterCollectionReusableView {
    private func setUI() {
        setStackView()
        [logoutLabel, withdrawalLabel].forEach {
            $0.textColor = .nottodoGray2
            $0.font = .PretendardMedium(size: 14)
        }
        logoutLabel.text = I18N.logout
        withdrawalLabel.text = I18N.withdrawal
        dividingLineView.backgroundColor = .nottodoGray2
    }
    
    private func setStackView() {
        stackView.do {
            $0.spacing = 26.adjusted
            $0.axis = .horizontal
            $0.alignment = .fill
        }
        stackView.addArrangedSubviews(logoutLabel, dividingLineView, withdrawalLabel)
    }
    
    private func setLayout() {
        stackView.addArrangedSubviews(logoutLabel, dividingLineView, withdrawalLabel)
        addSubview(stackView)
        
        dividingLineView.snp.makeConstraints {
            $0.width.equalTo(1.adjusted)
            $0.height.equalTo(13.adjusted)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
