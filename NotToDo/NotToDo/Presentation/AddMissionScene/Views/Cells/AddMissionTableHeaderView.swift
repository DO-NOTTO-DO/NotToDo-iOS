//
//  AddMissionTableHeaderView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

// MARK: - AddMissionTableHeaderView

class AddMissionTableHeaderView: UICollectionReusableView {
    
    // MARK: - Identifier

    static var reuseId: String = "HeaderView"
    
    // MARK: - UI Components
    
    private lazy var titleLabel = UILabel()
    private lazy var button = UIButton(configuration: .plain())
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        // setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func HeaderTitle(title: String?) {
        self.titleLabel.text = title
    }
    
    func ButtonWithIcon(title: String?, icon: String?) {
        self.button.configuration?.title = title ?? ""
        self.button.configuration?.image = UIImage(named: icon ?? "")
    }
}

// MARK: - Extensions

extension AddMissionTableHeaderView {

    // MARK: - UI Helpers
    
    private func setUI() {
        titleLabel.do {
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        
        button.do {
            $0.configuration?.titleAlignment = .trailing
            $0.titleLabel?.font = .PretendardMedium(size: 16)
            $0.configuration?.baseForegroundColor = .nottodoGray2
            // $0.configuration?.imagePadding = 0
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.trailing
            $0.configuration?.buttonSize = .small
            $0.configuration?.baseBackgroundColor = .clear
            $0.configuration?.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }
        
    // MARK: - Layout Helpers
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
