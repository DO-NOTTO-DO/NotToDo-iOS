//
//  TableHeaderView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/08.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    static var identifier = "TableHeaderVIew"
    
    var headerButton = UIButton()
    var headerLabel = UILabel()
    var numberLabel = UILabel()
    var iconImageView = UIImageView()
    let isSelected: Bool = false
   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension TableHeaderView {
    func setUI() {
        contentView.addSubviews(headerButton, numberLabel)
        headerButton.addSubview(headerLabel)
        
        headerButton.do {
            $0.addTarget(self, action: #selector(headerButtonTapped), for: .touchUpInside)
        }
        headerLabel.do {
            $0.textColor = UIColor.nottodoBlack
            $0.font = .PretendardBold(size: 14)
        }
        numberLabel.do {
            $0.text = "n 회"
            $0.font = .PretendardRegular(size: 14.adjusted)
        }
    }
    
    func setLayout() {
        headerButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6)
            $0.height.equalTo(45)
        }
        headerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(37.adjusted)
        }
        numberLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalTo(headerLabel.snp.centerY)
        }
    }
    
    func config(_ title: TitleButton){
        headerLabel.text = title.title
    }
    
    @objc func headerButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        numberLabel.textColor = sender.isSelected ? .yellow_basic : .nottodoGray2
    }
}


