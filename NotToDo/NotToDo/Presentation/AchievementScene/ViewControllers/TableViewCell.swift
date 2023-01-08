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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = .clear
        titleLabel.do {
            $0.textColor = .red
        }
    }
    func setLayout(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
