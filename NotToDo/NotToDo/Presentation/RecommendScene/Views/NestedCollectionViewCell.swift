//
//  NestedCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

class NestedCollectionViewCell: UICollectionViewCell {
    static var reusedId = "NestedCollectionViewCell"
    var itemlist: [SortedItemModel] = SortedItemModel.sampleData
     lazy var titleLabel = UILabel().then{
        $0.text = "One"
        $0.textAlignment = .center
        $0.textColor = UIColor.black
    }
    func config(_ item : ItemModel){
        titleLabel.text = item.subTitle
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.gray.cgColor
        self.backgroundColor = .white
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setViews(){
        self.addSubview(titleLabel)
    }
    private func setConstraints(){
        titleLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
}

