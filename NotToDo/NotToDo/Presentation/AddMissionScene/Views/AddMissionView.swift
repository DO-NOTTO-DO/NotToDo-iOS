//
//  MissionView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import Then
import SnapKit

// MARK: - AddMissionView

class AddMissionView: UIView {
    
    // MARK: - UI Components
    
    private lazy var navigationBarView = NavigationBarView(frame: CGRect(), mode: .plain)
    private lazy var scrollView = UIScrollView()
    private lazy var vStack = UIStackView(arrangedSubviews: [situationView, goalView, dateView])
    
    private let missionView = UIView()
    private let missionTitleView = AddMissionTitleView(frame: .zero, titleLabel: "하지 않을 일을 적어주세요", buttonLabel: nil, icon: nil)
    private let missionTextFieldView = AddMissionTextFieldView(frame: .zero, placeHolder: "ex) 유튜브 2시간 이상 보지 않기")
    
    private let behaviorView = UIView()
    private let behaviorTitleView = AddMissionTitleView(frame: .zero, titleLabel: "구체적인 실천 행동은 무엇인가요?", buttonLabel: "추천받기", icon: .rightArrow)
    private let behaviorTextFieldView = AddMissionTextFieldView(frame: .zero, placeHolder: "ex) 9시 이후 휴대폰 가방에 넣기")
    private let addBehaviorButton = UIButton()
    private let maxBehaviorLabel = UILabel()
    
    private let situationView = AddMissionTitleView(frame: .zero, titleLabel: "어떤 상황인가요?", buttonLabel: "입력하기", icon: .rightArrow)
    
    private let goalView = UIView()
    private let goalTitleView = AddMissionTitleView(frame: .zero, titleLabel: "이루고자 하는 목표는 무엇인가요?", buttonLabel: nil, icon: nil)
    private let goalTextFieldView = AddMissionTextFieldView(frame: .zero, placeHolder: "ex) 책 1권 완독하기")
    
    var date = Date()
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

// MARK: - Extensions

extension AddMissionView {
    
    // MARK: - UI Helpers
    
    private func setUI() {
        vStack.do {
            $0.axis = .vertical
            $0.spacing = 35
        }
    
        addBehaviorButton.setImage(.plusBtn, for: .normal)
        
        maxBehaviorLabel.do {
            $0.text = "* 상황 추가는 낫투두 당 2개까지 가능합니다."
            $0.font = .PretendardRegular(size: 12)
            $0.textColor = .nottodoGray2
        }
        
        dateLabel.do {
            $0.text = "실천 날짜"
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        
        dateButton.do {
            let nowDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let str = dateFormatter.string(from: nowDate)
            $0.configuration?.title = str
            // $0.configuration?.image = .ic_calendar
            $0.configuration?.imagePadding = 10.adjusted
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.trailing
            $0.configuration?.baseBackgroundColor = .BG
            $0.configuration?.baseForegroundColor = .nottodoGray1
            $0.configuration?.cornerStyle = .medium
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.layer.cornerRadius = 5
            $0.titleLabel?.font = .PretendardMedium(size: 16)

//            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        maxMissionLabel.do {
            $0.text = "* 하루 최대 3개까지 낫투두를 작성할 수 있어요!"
            $0.font = .PretendardRegular(size: 14)
            $0.textColor = .nottodoGray1
        }
        
        addMissionButton.do {
            $0.setTitle("추가하기", for: .normal)
            $0.setTitleColor(.nottodoWhite, for: .normal)
            $0.titleLabel?.font = .PretendardBold(size: 18)
            $0.backgroundColor = .nottodoGray2
        }
    }
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        [navigationBarView, scrollView, addMissionButton].forEach {
            addSubview($0)
        }
        
        [missionView, behaviorView, vStack, maxMissionLabel].forEach {
            scrollView.addSubview($0)
        }
        
        [missionTitleView, missionTextFieldView].forEach {
            missionView.addSubview($0)
        }
        
        [behaviorTitleView, behaviorTextFieldView, addBehaviorButton, maxBehaviorLabel].forEach {
            behaviorView.addSubview($0)
        }
        
        [goalTitleView, goalTextFieldView].forEach {
            goalView.addSubview($0)
        }
        
        [dateLabel, dateButton].forEach {
            dateView.addSubview($0)
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(68.adjusted)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        addMissionButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        // MARK: - Cells
        
        missionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(83.adjusted)
        }
        
        behaviorView.snp.makeConstraints {
            $0.top.equalTo(missionView.snp.bottom).offset(35)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(107.adjusted)
        }
        
        vStack.snp.makeConstraints {
            $0.top.equalTo(behaviorView.snp.bottom).offset(35)
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
            $0.top.equalTo(addMissionButton.snp.top).offset(-46)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-103.adjusted)
        }
    
        // MARK: - mission
        
        missionTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        missionTextFieldView.snp.makeConstraints {
            $0.top.equalTo(missionTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        // MARK: - behavior
        
        behaviorTitleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        behaviorTextFieldView.snp.makeConstraints {
            $0.top.equalTo(behaviorTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-73)
            $0.height.equalTo(46.adjusted)
        }
        
        addBehaviorButton.snp.makeConstraints {
            $0.centerY.equalTo(behaviorTextFieldView.snp.centerY)
            $0.leading.equalTo(behaviorTextFieldView.snp.trailing).offset(7.adjusted)
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        maxBehaviorLabel.snp.makeConstraints {
            $0.top.equalTo(behaviorTextFieldView.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
        
        // MARK: - goal
        
        goalTitleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        goalTextFieldView.snp.makeConstraints {
            $0.top.equalTo(goalTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        // MARK: - date
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        dateButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(35)
            $0.width.equalTo(150)
        }
    }
    func updateData(date: String) {
        dateButton.setTitle(date, for: .normal)
    }
}
