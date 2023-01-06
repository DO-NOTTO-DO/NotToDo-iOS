//
//  NestedCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

class NestedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var reusedId = "NestedCollectionViewCell"
    
    var itemlist: [SortedItemModel] = SortedItemModel.sampleData
    
    // MARK: - UI Components
    
    lazy var colorView = UIView()
    lazy var titleLabel = UILabel()
   
    // MARK: - Network
    
    func config(_ item : ItemModel){
        titleLabel.text = item.subTitle
    }
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setAttributes()
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension NestedCollectionViewCell{
    
    private func setAttributes(){
        colorView.do {
            $0.layer.backgroundColor = UIColor.yellow_basic?.cgColor
        }
        titleLabel.do {
            $0.textColor = UIColor.nottodoGray1
            $0.font = .PretendardSemiBold(size: 16)
        }
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

