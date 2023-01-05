//
//  AchievementHeaderView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class AchievementHeaderView: UICollectionReusableView {
        static var reuseId : String = "AchievementHeaderView"
    lazy var hStack = UIStackView(arrangedSubviews: [icon,subLabel]).then{
        $0.axis = .horizontal
    }
    lazy var icon = UIImageView().then {
        $0.image = .rank
    }
    lazy var subLabel = customLabel(color: .nottodoBlack!, font: UIFont(name: AppFontName.pretendardSemiBold, size: 16)!)
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setViews()
            setConstraints()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func HeaderTitle(title : String?){
            self.subLabel.text = title
        }
        func setViews(){
            self.addSubview(hStack)
        }
        func setConstraints(){
            hStack.snp.makeConstraints {
                $0.leading.equalToSuperview()
            }
        }
    }


