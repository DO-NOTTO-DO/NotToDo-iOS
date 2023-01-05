//
//  MissionCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class MissionCollectionViewCell: UICollectionViewCell {
    static var reusedId = "MissionCollectionViewCell"
    lazy var label = customLabel(color: .nottodoBlack!, font: UIFont(name: AppFontName.pretendardSemiBold, size: 14)!)
    lazy var image = UIImageView().then {
        $0.image = UIImage.rank1

    }
    func config(_ item : MissionList){
        label.text = item.title
        self.backgroundColor = item.color
        
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.label.layer.cornerRadius = 10
        self.backgroundColor = .clear
        setAttributes()
        setViews()
        setConstraints()
        
    }
    private func setAttributes(){
        self.label.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.nottodoGray2?.cgColor
    }
    private func setViews(){
        self.addSubview(image)
        image.addSubview(label)
    }
    private func setConstraints(){
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
       label.snp.makeConstraints {
           $0.centerY.equalToSuperview()
           $0.leading.equalToSuperview().offset(41)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

