//
//  LabelCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/06.
//

import UIKit

import SnapKit
import Then

class LabelCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier = "LabelCollectionViewCell"
    
    // MARK: - UI Components
    
    private lazy  var titleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension LabelCollectionViewCell {
    func setUI() {
        titleLabel.do {
            $0.text = "* 박스 터치 시, 낫투두가 아닌 환경만 입력됩니다."
            $0.textAlignment = .center
            $0.font = .PretendardRegular(size: 12.adjusted)
            $0.textColor = .nottodoGray2
        }
    }    
    func setLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
