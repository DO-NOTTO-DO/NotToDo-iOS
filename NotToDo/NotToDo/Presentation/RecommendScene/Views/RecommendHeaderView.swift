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
    
    lazy var titleLabel = CustomPaddingLabel(padding: .init(top: 7, left: 27, bottom: 10, right: 13))
    var bgView = UIView()
    private lazy var iconImage = UIImageView()
    
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
            $0.font = .PretendardMedium(size: 14)
        }
        
        iconImage.do {
            $0.image = UIImage.recommend_star
        }

        bgView.do {
            $0.frame = .init(x: 0, y: 0, width: titleLabel.frame.width, height: 34.adjusted)
            $0.layer.addBorder([.top, .left, .right], color: .nottodoGray2!, width: 0.5.adjusted)

        }
    }
    
    func setLayout() {
        addSubview(titleLabel)
        titleLabel.addSubviews(bgView, iconImage)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(34)
        }
        iconImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(7)
        }
        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func HeaderTitle(title: String?) {
        self.titleLabel.text = title
    }
}
