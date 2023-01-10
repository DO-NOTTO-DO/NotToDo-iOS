//
//  RecommendHeaderView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

import SnapKit
import Then

class RecommendHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static var reuseId: String = "RecommendHeaderView"
    
    // MARK: - UI Components
    
    var titleLabel = CustomPaddingLabel(padding: .init(top: 7, left: 27, bottom: 10, right: 13))
    private var backgroundView = UIView()
    private var iconImage = UIImageView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension RecommendHeaderView {
    func setUI() {
        titleLabel.do {
            $0.textColor = .nottodoGray1
            $0.font = .PretendardMedium(size: 14.adjusted)
        }
        
        iconImage.do {
            $0.image = UIImage.recommend_star
        }
    }
    
    func setLayout() {
        addSubview(titleLabel)
        titleLabel.addSubviews(backgroundView, iconImage)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(34.adjusted)
        }
        iconImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(7.adjusted)
        }
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func HeaderTitle(title: String?) {
        self.titleLabel.text = title
    }
}
