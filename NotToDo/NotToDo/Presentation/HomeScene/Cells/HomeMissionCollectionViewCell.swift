//
//  HomeMissionCollectionViewCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class HomeMissionCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let identifier = "HomeMissionCollectionViewCell"
    var selectStatusButton: Bool? = true
    var clickedStatusButton: ((Int) -> Void)?
    var meatballClickedEvent: ((Int) -> Void)?
    var missionId: Int?
    var indexPath: IndexPath?
    
    // MARK: - UI Components
    
    private let headerBackView = UIView()
    private let headerView = UIView()
    var statusButton = UIButton()
    private let statusButtonView = UIView()
    private let situationLabel = UILabel()
    private let missionTitleLabel = UILabel()
    private let meatballView = UIView()
    private let meatballButton = UIButton()
    private let goalView = UIView()
    private let goalTitleLabel = UILabel()
    private let goalLabel = UILabel()
    private let cancelLineView = UIView()
    
    private let solutionStackview = UIStackView()
    private var firstSolusionView = UIImageView()
    private var secondSolustionView = UIImageView()
    private var firstSolutionLabel = UILabel()
    private var secondSolutionLabel = UILabel()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setRecognizer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeMissionCollectionViewCell {
    private func setUI() {
        backgroundColor = .BG
        headerBackView.backgroundColor = .nottodoGray2
        
        headerView.do {
            $0.backgroundColor = .nottodoWhite
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
        
        statusButtonView.backgroundColor = .clear
        meatballView.backgroundColor = .clear
        meatballButton.setBackgroundImage(.dot, for: .normal)
        statusButton.do {
            $0.setBackgroundImage(.checkDefault, for: .normal)
        }
        
        solutionStackview.do {
            $0.distribution = .fill
            $0.axis = .vertical
            $0.spacing = 0
        }
        
        firstSolusionView.image = .firstSolutionView
        secondSolustionView.image = .secondSolutionView
        
        [firstSolutionLabel, secondSolutionLabel].forEach {
            $0.textColor = .nottodoGray1
            $0.font = .PretendardBold(size: 14.adjusted)
        }
        
        headerView.clipsToBounds = false
        
        cancelLineView.do {
            $0.backgroundColor = .nottodoGray1
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        goalView.addSubview(goalLabel)
        firstSolusionView.addSubview(firstSolutionLabel)
        secondSolustionView.addSubview(secondSolutionLabel)
        solutionStackview.addArrangedSubviews(firstSolusionView, secondSolustionView)
        headerBackView.addSubview(headerView)
        meatballView.addSubview(meatballButton)
        headerView.addSubviews(statusButton, statusButtonView, situationLabel, missionTitleLabel,
                               goalView, goalTitleLabel, meatballButton,
                               meatballView, cancelLineView)
        addSubviews(headerBackView, solutionStackview)
        
        headerBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17.adjusted)
            $0.height.equalTo(81.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
        }
        
        headerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview().inset(0.5.adjusted)
        }
        
        goalLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        statusButtonView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10.adjusted)
            $0.directionalVerticalEdges.equalToSuperview()
            $0.width.equalTo(40.adjusted)
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
        
        meatballView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.directionalVerticalEdges.equalToSuperview()
            $0.width.equalTo(30.adjusted)
        }
        
        meatballButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        meatballView.snp.makeConstraints {
            $0.trailing.directionalVerticalEdges.equalToSuperview()
            $0.width.equalTo(50.adjusted)
        }
        
        solutionStackview.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(7.adjusted)
            $0.leading.equalToSuperview().inset(51.adjusted)
            $0.trailing.equalTo(headerBackView.snp.trailing)
            $0.bottom.equalToSuperview()
        }
        
        [firstSolusionView, secondSolustionView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(40.adjusted)
            }
        }
        
        [firstSolutionLabel, secondSolutionLabel].forEach {
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(22.adjusted)
            }
        }
        
        cancelLineView.snp.makeConstraints {
            $0.height.equalTo(1.adjusted)
            $0.leading.equalTo(situationLabel.snp.leading).offset(-8.adjusted)
            $0.trailing.equalTo(missionTitleLabel.snp.trailing).offset(11.adjusted)
            $0.centerY.equalTo(missionTitleLabel.snp.centerY)
        }
    }
    
    func configure(_ model: DailyMissionResponseDTO) {
        situationLabel.text = model.situation
        missionTitleLabel.text = model.title
        goalTitleLabel.text = model.goal
        setAction(model.actions.map { $0.name })
        missionId = model.id
        
        if model.completionStatus == "FINISH" {
            statusButton.setImage(.checkCircle, for: .normal)
            cancelLineView.isHidden = false
        } else if model.completionStatus == "AMBIGUOUS" {
            statusButton.setImage(.checkTriangle, for: .normal)
            cancelLineView.isHidden = true
        } else {
            statusButton.setImage(.checkDefault, for: .normal)
            cancelLineView.isHidden = true
        }
    }
    
    private func setAction(_ actionList: [String]) {
        secondSolustionView.isHidden = actionList.count != 2
        if actionList.count >= 2 {
            secondSolutionLabel.text = actionList[1]
            secondSolustionView.image = .secondSolutionView
        } else {
            firstSolusionView.image = .secondSolutionView
        }
        firstSolutionLabel.text = actionList[0]
    }
    
    private func setRecognizer() {
        let meatballRecognizer = UITapGestureRecognizer(target: self,
                                                        action: #selector(meatballButtonTapped))
        let statusButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(statusButtonTapped))
        meatballView.addGestureRecognizer(meatballRecognizer)
        statusButtonView.addGestureRecognizer(statusButtonRecognizer)
    }
    
    @objc func statusButtonTapped(_ sender: UIButton) {
        guard let missionId = missionId else { return }
        clickedStatusButton?(missionId)
    }
    
    @objc func meatballButtonTapped(_ sender: UIView) {
        guard let missionId = missionId else { return }
        meatballClickedEvent?(missionId)
    }
}
