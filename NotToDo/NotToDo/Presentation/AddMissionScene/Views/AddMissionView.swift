//
//  MissionView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import Then
import SnapKit

class AddMissionView: UIView {
    
    // MARK: - UI Components
    
    var navigationBarView = NavigationBarView(frame: CGRect(), mode: .plain)
    private lazy var scrollView = UIScrollView()
    private lazy var vStack = UIStackView(arrangedSubviews: [situationView, goalView, dateView])
    
    private let missionView = UIView()
    private let missionTitleView = AddMissionTitleView(frame: .zero, titleLabel: I18N.missionTitle, buttonLabel: nil, icon: nil)
    private let missionTextFieldView = AddMissionTextFieldView(frame: .zero, placeHolder: I18N.missionPlaceHolder)
    
    private let behaviorView = UIView()
    private let behaviorTitleView = AddMissionTitleView(frame: .zero, titleLabel: I18N.behaviorTitle, buttonLabel: I18N.recommend, icon: .rightArrow)
    private let behaviorTextFieldView = AddMissionTextFieldView(frame: .zero, placeHolder: I18N.behaviorPlaceHolder)
    private let addBehaviorButton = UIButton()
    private let maxBehaviorLabel = UILabel()
    
    private let situationView = AddMissionTitleView(frame: .zero, titleLabel: I18N.situationTitle, buttonLabel: I18N.input, icon: .rightArrow)
    
    private let goalView = UIView()
    private let goalTitleView = AddMissionTitleView(frame: .zero, titleLabel: I18N.goalTitle, buttonLabel: nil, icon: nil)
    private let goalTextFieldView = AddMissionTextFieldView(frame: .zero, placeHolder: I18N.goalPlaceHolder)
    
    var date = Date()
    let nowDate = Date()
    let dateFormatter = DateFormatter()
    private let dateView = UIView()
    private let dateLabel = UILabel()
    private let dateButton = UIButton(configuration: .filled())
    
    private let maxMissionLabel = UILabel()
    private let addMissionButton = UIButton()
    
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

extension AddMissionView {
    private func setUI() {
        vStack.do {
            $0.axis = .vertical
            $0.spacing = 35.adjusted
        }
        
        addBehaviorButton.setImage(.plusBtn, for: .normal)
        
        maxBehaviorLabel.do {
            $0.text = I18N.maxBehavior
            $0.font = .PretendardRegular(size: 12)
            $0.textColor = .nottodoGray2
        }
        
        dateLabel.do {
            $0.text = I18N.actionDate
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        
        dateFormatter.do {
            $0.dateFormat = "yyyy.MM.dd"
        }
        
        dateButton.do {
            let str = dateFormatter.string(from: nowDate)
            $0.configuration?.title = str
            $0.configuration?.image = .addCalendar
            $0.configuration?.imagePadding = 10.adjusted
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.trailing
            $0.configuration?.baseBackgroundColor = .BG
            $0.configuration?.baseForegroundColor = .nottodoGray1
            $0.configuration?.cornerStyle = .medium
            $0.layer.borderWidth = 0.5.adjusted
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.layer.cornerRadius = 5.adjusted
            $0.titleLabel?.font = .PretendardMedium(size: 16)
        }
        
        maxMissionLabel.do {
            $0.text = I18N.maxMission
            $0.font = .PretendardRegular(size: 14)
            $0.textColor = .nottodoGray1
        }
        
        addMissionButton.do {
            $0.setTitle(I18N.add, for: .normal)
            $0.setTitleColor(.nottodoWhite, for: .normal)
            $0.titleLabel?.font = .PretendardBold(size: 18)
            $0.backgroundColor = .nottodoGray2
        }
    }
    
    private func setLayout() {
        backgroundColor = .nottodoWhite
        
        addSubviews(navigationBarView, scrollView, addMissionButton)
        scrollView.addSubviews(missionView, behaviorView, vStack, maxMissionLabel)
        missionView.addSubviews(missionTitleView, missionTextFieldView)
        behaviorView.addSubviews(behaviorTitleView, behaviorTextFieldView, addBehaviorButton, maxBehaviorLabel)
        goalView.addSubviews(goalTitleView, goalTextFieldView)
        dateView.addSubviews(dateLabel, dateButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(68.adjusted)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        addMissionButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(74.adjusted)
        }
        
        missionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(83.adjusted)
        }
        
        behaviorView.snp.makeConstraints {
            $0.top.equalTo(missionView.snp.bottom).offset(35.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(107.adjusted)
        }
        
        vStack.snp.makeConstraints {
            $0.top.equalTo(behaviorView.snp.bottom).offset(35.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(212.adjusted)
        }
        
        situationView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(24.adjusted)
        }
        
        goalView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(83.adjusted)
        }
        
        dateView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(37.adjusted)
        }
        
        maxMissionLabel.snp.makeConstraints {
            $0.top.equalTo(addMissionButton.snp.top).offset(-46.adjusted)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-103.adjusted)
        }
        
        missionTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        missionTextFieldView.snp.makeConstraints {
            $0.top.equalTo(missionTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        behaviorTitleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        behaviorTextFieldView.snp.makeConstraints {
            $0.top.equalTo(behaviorTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.trailing.equalToSuperview().offset(-73.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        addBehaviorButton.snp.makeConstraints {
            $0.centerY.equalTo(behaviorTextFieldView.snp.centerY)
            $0.leading.equalTo(behaviorTextFieldView.snp.trailing).offset(7.adjusted)
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        maxBehaviorLabel.snp.makeConstraints {
            $0.top.equalTo(behaviorTextFieldView.snp.bottom).offset(9.adjusted)
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
        
        goalTitleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        goalTextFieldView.snp.makeConstraints {
            $0.top.equalTo(goalTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        dateButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.height.equalTo(35.adjusted)
            $0.width.equalTo(150.adjusted)
        }
    }
    
    func updateData(date: String) {
        dateButton.setTitle(date, for: .normal)
    }
}
