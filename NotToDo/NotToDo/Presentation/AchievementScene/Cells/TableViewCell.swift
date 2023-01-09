//
//  TableViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/08.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var identifier = "TableViewCell"
    
    let titleLabel = UILabel()
    let numberLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = .BG
        titleLabel.do {
            $0.textColor = .red
            $0.font = .PretendardBold(size: 14.adjusted)
        }
        numberLabel.do {
            $0.textColor = .nottodoGray2
            $0.font = .PretendardRegular(size: 14.adjusted)
            $0.text = "n회"
        }
    }
    func setLayout() {
        addSubviews(titleLabel, numberLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35)
            $0.centerY.equalToSuperview()
        }
        numberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(17.adjusted)
        }
    }
    
}
