//
//  HomeMissionCollectionReusableView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

final class HomeMissionCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = "HomeMissionCollectionReusableView"
    
    // MARK: - UI Components
    
    let backView = UIView()
    private var statusButton = UIButton()
    private let situationLabel = UILabel()
    private let missionTitleLabel = UILabel()
    private let meatballButton = UIButton()
    private let goalView = UIView()
    private let goalTitleLabel = UILabel()
    private let goalLabel = UILabel()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backView.layer.addBorder([.top, .bottom, .right, .left], color: .nottodoGray2!, width: 0.5)
    }
}

extension HomeMissionCollectionReusableView {
    private func setUI() {
        backgroundColor = .BG
        backView.do {
            $0.backgroundColor = .nottodoWhite
            $0.layer.addBorder([.top, .bottom, .right, .left], color: .nottodoGray2!, width: 0.5)
        }
        situationLabel.do {
            $0.font = .PretendardRegular(size: 16.adjusted)
            $0.textColor = .nottodoGray1
        }
        
        missionTitleLabel.do {
            $0.font = .PretendardBold(size: 16.adjusted)
            $0.textColor = .nottodoBlack
        }
        
        goalView.do {
            $0.backgroundColor = .nottodoBlack
            $0.layer.cornerRadius = 10
        }
        
        goalLabel.do {
            $0.textColor = .yellow_basic
            $0.text = I18N.goal
            $0.font = .PretendardRegular(size: 12.adjusted)
        }
        
        goalTitleLabel.do {
            $0.textColor = .nottodoGray1
            $0.font = .PretendardMedium(size: 12.adjusted)
        }
        
        meatballButton.setBackgroundImage(.dot, for: .normal)
        statusButton.setBackgroundImage(.checkDefault, for: .normal)
    }
    
    private func setLayout() {
        backView.addSubviews(statusButton, situationLabel, missionTitleLabel,
                    goalView, goalTitleLabel, meatballButton)
        goalView.addSubview(goalLabel)
        addSubview(backView)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
        }
        
        goalLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        situationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18.adjusted)
            $0.leading.equalTo(statusButton.snp.trailing).offset(15.adjusted)
        }
        
        missionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(situationLabel.snp.top)
            $0.leading.equalTo(situationLabel.snp.trailing).offset(5.adjusted)
        }
        
        goalView.snp.makeConstraints {
            $0.top.equalTo(missionTitleLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(situationLabel.snp.leading)
            $0.height.equalTo(20.adjusted)
            $0.width.equalTo(51.adjusted)
        }
        
        goalTitleLabel.snp.makeConstraints {
            $0.top.equalTo(missionTitleLabel.snp.bottom).offset(11.adjusted)
            $0.leading.equalTo(goalView.snp.trailing).offset(5.adjusted)
        }
        
        meatballButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(_ model: DailyMission) {
        situationLabel.text = model.situation
        goalTitleLabel.text = model.goal
        missionTitleLabel.text = model.title
    }
}
