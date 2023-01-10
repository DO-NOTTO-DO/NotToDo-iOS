//
//  TableViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/08.
//
import UIKit

import SnapKit
import Then

class SituationTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier = "SituationTableViewCell"
    
    // MARK: - UI Components
    
    let titleLabel = UILabel()
    let numberLabel = UILabel()
    let backGroundImage = UIImageView()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SituationTableViewCell {
    func setUI() {
        backGroundImage.do {
            $0.image = .situation1
        }
        titleLabel.do {
            $0.textColor = .nottodoBlack
            $0.font = .PretendardBold(size: 14.adjusted)
        }
        numberLabel.do {
            $0.textColor = .nottodoGray2
            $0.font = .PretendardRegular(size: 14.adjusted)
            $0.text = "n회"
        }
    }
    func setLayout() {
        addSubview(backGroundImage)
        backGroundImage.addSubviews(titleLabel, numberLabel)
        
        backGroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(50)
            $0.centerY.equalToSuperview()
        }
        numberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(17.adjusted)
        }
    }
}
