//
//  RecommendHeaderView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

import Then
import SnapKit

class RecommendHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static var reuseId: String = "RecommendHeaderView"
    
    // MARK: - UI Components
    
    lazy var titleLabel = CustomPaddingLabel(padding: .init(top: 7, left: 27, bottom: 10, right: 13))
    private lazy var iconImage = UIImageView()
    
    // MARK: - Network
    
    func HeaderTitle(title: String?) {
        self.titleLabel.text = title
    }
    
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
extension RecommendHeaderView {
    
    func setUI() {
        titleLabel.do {
            $0.textColor = .nottodoGray1
            $0.font = .PretendardMedium(size: 14)
            $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
            $0.layer.borderWidth = 1
        }
        iconImage.do {
            $0.image = UIImage.recommend_star
        }
    }
    func setLayout() {
        addSubview(titleLabel)
        titleLabel.addSubview(iconImage)
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
    }
}
