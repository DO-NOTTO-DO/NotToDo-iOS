//
//  MissionHistoryCell.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class MissionHistoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    static let identifier = "AddSituationCollectionViewCell"

    // MARK: - UI Components

    let missionHistoryLabel = UILabel()

    // MARK: - View Life Cycle

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

// MARK: - Methods

extension MissionHistoryCollectionViewCell {
    private func setUI() {
        missionHistoryLabel.do {
            $0.font = .PretendardRegular(size: 16.adjusted)
            $0.textColor = .nottodoGray1
        }
    }
    
    private func setLayout() {
        addSubview(missionHistoryLabel)
        
        missionHistoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(26.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setBorder(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            return
        default:
            layer.addBorder([.top], color: .nottodoGray4!, width: 0.5)
        }
    }
    
    func configure(model: MissionHistoryModel) {
        missionHistoryLabel.text = model.title
    }
}
