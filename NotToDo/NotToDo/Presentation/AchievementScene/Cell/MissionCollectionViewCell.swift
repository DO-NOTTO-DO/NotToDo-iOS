//
//  MissionCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class MissionCollectionViewCell: UICollectionViewCell {
    static var reusedId = "MissionCollectionViewCell"
    lazy var hStack = UIStackView(arrangedSubviews: [num,label]).then {
        $0.axis = .horizontal
        $0.spacing = 13
        $0.distribution = .equalSpacing
    }
    lazy var num = customLabel(color: .black)
    lazy var label = customLabel(color: .black)
    func config(_ item : MissionList){
        num.text = "\(item.num)"
        label.text = item.title
        self.backgroundColor = item.color
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.label.layer.cornerRadius = 10
        setViews()
        setConstraints()
    }
    private func setViews(){
        self.addSubview(hStack)
    }
    private func setConstraints(){
        hStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

