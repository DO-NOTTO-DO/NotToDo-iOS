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
        static var reuseId : String = "RecommendHeaderView"
    private lazy var titleLabel = CustomPaddingLabel(padding: .init(top: 7, left: 27, bottom: 10, right: 13))
        
        private lazy var iconImage = UIImageView()
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setAttributes()
            setViews()
            setConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func HeaderTitle(title : String?){
            self.titleLabel.text = title
        }
    
    func setAttributes(){
        titleLabel.do{
            $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
            $0.layer.borderWidth = 1
        }
        iconImage.do{
            $0.image = UIImage.ic_star
        }
    }
        func setViews(){
            self.addSubview(titleLabel)
            titleLabel.addSubview(iconImage)
        }
        func setConstraints(){
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            iconImage.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(10)
                $0.top.equalToSuperview().offset(12)
                $0.height.width.equalTo(7)
            }
        }
    }


