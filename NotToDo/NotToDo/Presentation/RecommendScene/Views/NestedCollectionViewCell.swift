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
    lazy var colorView = UIView().then{
        $0.layer.backgroundColor = UIColor.yellow_basic?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
    }
     lazy var titleLabel = UILabel().then{
         $0.text = "One"
         $0.textColor = UIColor.nottodoGray1
         $0.font = .PretendardSemiBold(size: 16)
    }
    func config(_ item : ItemModel){
        titleLabel.text = item.subTitle
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.backgroundColor = .white
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setViews(){
        self.addSubviews(colorView,titleLabel)
    }
    private func setConstraints(){
        colorView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(11)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(13)
            $0.centerY.equalToSuperview()
        }
    }
}

