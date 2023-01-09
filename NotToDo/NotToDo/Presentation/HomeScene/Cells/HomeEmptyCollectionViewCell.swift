//
//  HomeEmptyCollectionViewCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class HomeEmptyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "HomeEmptyCollectionViewCell"
    
    // MARK: - UI Components
    
    private let emptyView = UIImageView()
    private let emptyLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeEmptyCollectionViewCell {
    private func setUI() {
        emptyView.image = .heartEmpty
        emptyLabel.do {
            $0.text = I18N.empty
            $0.font = .PretendardSemiBold(size: 16.adjusted)
            $0.textColor = .nottodoGray2
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
        backgroundColor = .BG
    }
    
    private func setLayout() {
        contentView.addSubviews(emptyView, emptyLabel)
        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(98.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(141.adjusted)
            $0.height.equalTo(124.adjusted)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyView.snp.bottom).offset(7.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
