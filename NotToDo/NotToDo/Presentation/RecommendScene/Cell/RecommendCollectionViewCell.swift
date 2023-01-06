//
//  RecommendCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var reusedId = "RecommendCollectionViewCell"
    
    // MARK: - UI Components
    
    lazy var nestedCollectionView = NestedView(frame: .zero)
    var item: SortedItemModel?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RecommendCollectionViewCell {
    func config() {
        setUI()
        setViews()
        setLayout()
    }
    private func setUI() {
        nestedCollectionView.do {
            $0.backgroundColor = .clear
        }
    }
    
    private func setViews() {
        self.addSubviews(nestedCollectionView)
        nestedCollectionView.item = item
        nestedCollectionView.config()
    }
    
    private func setLayout() {
        nestedCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
