//
//  EmptyCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import SnapKit
import Then

class EmptyCollectionViewCell: UICollectionViewCell {
    
    static var reuseId: String = "EmptyCollectionViewCell"
    
    private lazy var mainTitle = UILabel()
    private lazy var iconImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EmptyCollectionViewCell {
    func setUI() {
        iconImage.do {
            $0.image = UIImage.heartFill2
        }
        mainTitle.do {
            $0.backgroundColor = .clear
            $0.textColor = .nottodoGray2
            $0.numberOfLines = 2
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.13
            $0.font = UIFont(name: AppFontName.pretendardSemiBold, size: 16)
            $0.attributedText = NSMutableAttributedString(string: "아직 아무것도 없네요,\n새로운 낫투두를 작성해보세요!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            $0.textAlignment = .center
        }
    }
    func setLayout() {
        addSubviews(iconImage, mainTitle)
        iconImage.snp.makeConstraints {
            $0.width.equalTo(111.adjusted)
            $0.height.equalTo(124.adjusted)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(iconImage.snp.bottom).offset(10)
            $0.directionalHorizontalEdges.equalToSuperview().inset(80)
        }
    }
}
