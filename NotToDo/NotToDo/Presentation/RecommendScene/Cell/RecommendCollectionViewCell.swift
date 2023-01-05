//
//  RecommendCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
     static var reusedId = "RecommendCollectionViewCell"
    
    lazy var titleLabel = UILabel()
    //nested CollectionView
    lazy var nestedCollectionView = NestedView(frame: .zero)
    var item : SortedItemModel?
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func config() {
        setAttributes()
        setViews()
        setConstraints()
    }
    private func setAttributes(){
        titleLabel.do {
            $0.text = "* 박스 터치 시, 낫투두가 아닌 환경만 입력됩니다."
            $0.textAlignment = .center
            $0.font = .PretendardRegular(size: 12)
            $0.textColor = .nottodoGray2
        }
        nestedCollectionView.do {
            $0.backgroundColor = .clear
        }
    }
    
    private func setViews(){
        self.addSubviews(titleLabel,nestedCollectionView)
     //   nestedCollectionView.item = item
        nestedCollectionView.config()
    }
   
    private func setConstraints(){
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        nestedCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}


