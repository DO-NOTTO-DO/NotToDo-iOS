//
//  CustomTabBarCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

import Then
import SnapKit

class CustomTabBarCell: UICollectionViewCell {
    static var reusedId = "CustomTabBarCell"
    lazy var bgView = UIView()
    lazy var icImage = UIImageView()
    lazy var titleLabel = UILabel()
    
    func config(_ item : CustomTabBarItem, isSelected : Bool){
        if isSelected {
            self.titleLabel.text = item.name
            self.titleLabel.textColor = .nottodoGray1
            self.titleLabel.font = .PretendardBold(size: 12)
            self.icImage.image = UIImage(named: item.activeImage)
            self.bgView.backgroundColor = .yellow_mild
        } else {
            self.titleLabel.text = item.name
            self.titleLabel.textColor = .nottodoGray2
            self.titleLabel.font = .PretendardMedium(size: 12)
            self.icImage.image = UIImage(named: item.image) 
            self.bgView.backgroundColor = .clear
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setAttributes()
        setViews()
        setConstraints()
    }
    private func setAttributes(){
        titleLabel.do{
            $0.textAlignment = .center
            $0.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    private func setViews(){
        self.addSubview(bgView)
        bgView.addSubviews(icImage,titleLabel)
    }
    private func setConstraints(){
        bgView.snp.makeConstraints{
            $0.height.equalTo(82.adjusted)
            $0.width.equalTo(69.adjusted)
            $0.centerX.centerY.equalToSuperview()
        }
        icImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(6)
            $0.directionalHorizontalEdges.equalToSuperview().inset(12)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(icImage.snp.bottom).offset(6)
            $0.bottom.equalToSuperview().inset(11)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
