//
//  SituationCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class SituationCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "SituationCollectionViewCell"
    lazy var label = CustomAchieveLabel(color: .nottodoBlack!, font: UIFont(name: AppFontName.pretendardSemiBold, size: 14)!)
    lazy var image = UIImageView().then {
        $0.image = UIImage.rank1
    }
    func config(_ item: MissionList) {
        label.text = item.title
        self.backgroundColor = item.color
        
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.label.layer.cornerRadius = 10
        self.backgroundColor = .clear
        setUI()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension SituationCollectionViewCell {
    private func setUI() {
        self.label.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.nottodoGray2?.cgColor
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
