//
//  MissionCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import SnapKit
import Then

class MissionCollectionViewCell: UICollectionViewCell {
    
    static var reusedId = "MissionCollectionViewCell"
    
    lazy var label = CustomAchieveLabel(color: .nottodoBlack!, font: .PretendardSemiBold(size: 14))
    lazy var image = UIImageView()
    
    func config(_ item: MissionList) {
        label.text = item.title
        self.backgroundColor = item.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MissionCollectionViewCell {
    private func setUI() {
        self.label.layer.cornerRadius = 10
        self.backgroundColor = .clear
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.nottodoGray2?.cgColor
        
        image.do {
            $0.image = UIImage.rank1
        }
    }
    private func setLayout() {
        addSubview(image)
        image.addSubview(label)
        
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(41)
        }
    }
}
