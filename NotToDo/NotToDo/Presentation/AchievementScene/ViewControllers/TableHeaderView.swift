//
//  TableHeaderView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/08.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    static var identifier = "TableHeaderVIew"
    var isSelected: Bool = false
    
    var headerButton = UIButton()
    var headerLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TableHeaderView {
    func setUI() {
        contentView.addSubviews(headerButton)
        headerButton.addSubview(headerLabel)
        
        headerButton.do {
            $0.addTarget(self, action: #selector(headerButtonTapped), for: .touchUpInside)
            
        }
        headerLabel.do {
            $0.textColor = UIColor.nottodoBlack
            $0.font = .PretendardBold(size: 14)
            
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
    }
    
    func config(_ title : TitleButton){
        headerLabel.text = title.title
    }
    
    @objc func headerButtonTapped(_ sender: UIButton){
        sender.isSelected.toggle()
    }
}


