//
//  LabelCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/06.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    static var reuseId: String = "LabelCollectionViewCell"
    
    private lazy  var titleLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setAttributes()
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setAttributes(){
        titleLabel.do {
            $0.text = "* 박스 터치 시, 낫투두가 아닌 환경만 입력됩니다."
            $0.textAlignment = .center
            $0.font = .PretendardRegular(size: 12)
            $0.textColor = .nottodoGray2
        }
    }
    func setViews(){
        self.contentView.addSubview(titleLabel)
    }
    func  setConstraints(){
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

