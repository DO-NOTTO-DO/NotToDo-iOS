//
//  AchievementViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//
import UIKit

import FSCalendar
import SnapKit
import Then

final class AchievementViewController: UIViewController {
    
    // MARK: - Properties
    
    var shouldHideMissionView: Bool? {
        didSet {
            guard let shouldHideMissionView = self.shouldHideMissionView else { return }
            missionView.isHidden = shouldHideMissionView
            situationView.isHidden = !self.missionView.isHidden
        }
    }

    
    // MARK: - UI Components
    
    private lazy var scrollView = UIScrollView()
    private var titleView = TitleView()
    private lazy var segmentedControl = CustomSegmentedControl(items: [I18N.missionStatisticsMessage, I18N.situationStatisticsMessage])
    private lazy var calendarView = CustomCalendar(frame: .zero)
    private lazy var missionView = MissionStatisticsView(frame: view.bounds)
    private lazy var situationView = SituationStatisticsView(frame: view.bounds)
    private var bottomLabel = UILabel()
    private var dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM"
    }
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    var situationList: [SituationStatistcsResponseDTO] = []
    var missionList: [MissionStatistcsResponseDTO] = []
    var dataSource: [String: Int] = [:]
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestAchieveAPI()
       // requestMonthAPI(month: month)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSituationView()
        setUI()
        setLayout()
    }
}

// MARK: - Methods

extension AchievementViewController {
    func reloadMonthData(month: String) {
        print(month)
        requestMonthAPI(month: month)
    }
    
    func setUI() {
        view.backgroundColor = .BG
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.backgroundColor = .BG
        }
        calendarView.do {
            $0.monthCalendarClosure = { [self] result in
                let month = result
                self.reloadMonthData(month: month)
                }
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
            $0.calendar.delegate = self
            $0.calendar.dataSource = self
            $0.calendar.register(MissionCalendarDayCell.self, forCellReuseIdentifier: String(describing: MissionCalendarDayCell.self))
        }
        
        bottomLabel.do {
            $0.text = I18N.statistcisBottomMessage
            $0.font = .PretendardMedium(size: 12.adjusted)
            $0.textColor = .nottodoGray2
        }
    }
    
    private func requestAchieveAPI() {
        AchieveAPI.shared.getMissionStatistics { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            self?.missionList = response.data!
            self?.configMissionView()
            self?.missionView.setUI()
            self?.missionView.missionTableView.reloadData()
            self?.relayout()
            dump(response)
        }
        AchieveAPI.shared.getSituationStatistics { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            self?.situationList = response.data!
            self?.configSituationView()
            self?.situationView.setUI()
            self?.situationView.expangindTableView.reloadData()
            self?.relayout()
            dump(response)
        }
    }
    
    func requestMonthAPI(month: String) {
        AchieveAPI.shared.getAchieveCalendar(month: month) { [self] result in
            switch result {
            case let .success(data):
                guard data is [AchieveCalendarResponseDTO] else { return }
            case .requestErr:
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func configMissionView() {
        missionView.missionList = missionList
    }
    
    func configSituationView() {
        let isSelected: [Bool] = [Bool](repeating: false, count: situationList.count)
        situationView.situationList = situationList
        situationView.isSelected = isSelected
    }
    
    func setLayout() {
        view.addSubviews(titleView, scrollView)
        scrollView.addSubviews(calendarView, segmentedControl, missionView, situationView, bottomLabel)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(17.adjusted)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(65.adjusted)
        }
        
        scrollView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalTo(safeArea)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.height.equalTo(380.adjusted)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(calendarView.snp.bottom).offset(30.adjusted)
            $0.height.equalTo(20.adjusted)
        }
        
        missionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            if missionView.missionList.isEmpty {
                $0.height.equalTo(300.adjusted)
            } else {
                $0.height.equalTo(CGFloat(missionView.missionList.count) * 55.adjusted + 105.adjusted)
            }
            $0.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-78.adjusted)
        }
        
        situationView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            if situationView.situationList.isEmpty {
                $0.height.equalTo(300.adjusted)
            } else {
                $0.height.equalTo(CGFloat(situationView.situationList.count) * 55.adjusted + 105.adjusted)
            }
            $0.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-78.adjusted)
        }
        bottomLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20.adjusted)
            if missionView.isHidden {
                $0.top.equalTo(situationView.snp.bottom).offset(10.adjusted)
            } else {
                $0.top.equalTo(missionView.snp.bottom).offset(10.adjusted)
            }
        }
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setNeedsLayout()
        didChangeValue(segment: self.segmentedControl)
    }
    
    func relayout() {
        missionView.snp.remakeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            if missionView.missionList.isEmpty {
                $0.height.equalTo(300.adjusted)
            } else {
                $0.height.equalTo(CGFloat(missionView.missionList.count) * 55.adjusted + 105.adjusted)
            }
            $0.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-78.adjusted)
        }
        
        situationView.snp.remakeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            if situationView.situationList.isEmpty {
                $0.height.equalTo(300.adjusted)
            } else {
                $0.height.equalTo(CGFloat(situationView.situationList.count) * 55.adjusted + 105.adjusted)
            }
            $0.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-78.adjusted)
        }
        bottomLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(20.adjusted)
            if missionView.isHidden {
                $0.top.equalTo(situationView.snp.bottom).offset(10.adjusted)
            } else {
                $0.top.equalTo(missionView.snp.bottom).offset(10.adjusted)
            }
        }
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideMissionView = segment.selectedSegmentIndex != 0
        relayout()
    }
}

extension AchievementViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendarView.calendar.reloadData()
        calendarView.headerLabel.text = calendarView.dateFormatter.string(from: calendar.currentPage)
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
}

extension AchievementViewController: FSCalendarDataSource {
    
    // 서버에서 넘어온 dateString이랑 이 메서드의 date를 잘 매칭시켜줘야 함
    // date 매칭된 것에 맞게 데이터를 넘겨줘야 함
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: String(describing: MissionCalendarDayCell.self), for: date, at: position) as! MissionCalendarDayCell
//        switch cell.state {
//        case .none:
//            return
//        case .step1:
//           return
//        case .step2:
//            return
//        case .step3:
//            return
//        default:
//            break
//        }
        
        // MARK: 서버에서 넘어온 값에 따라 셀 상태 변화시켜주기
        // Date : Int(Enum)
        /*
         NotToDoCalendarCell에 가보면 Enum이 보일 것임
         프로젝트 상황에 따라 적절하게 바꿔서 사용하기
         
         현재는 5개의 case가 있음
         - none, step1, step2, step3, bordered
         
         case에 따라서 backgroundColor 변화시키는 식으로 구현되어 있는데 UI 디테일을 살리고 싶으면
         그냥 case에 따라 이미지를 넣는 것이 더 쉬움
         */
        
        // 캘린더 셀 설정해주는 코드 : CollectionViewCell이랑 동일하게 생각하면 됨
        cell.configure(.step1)
        return cell
    }
}

extension AchievementViewController: FSCalendarDelegateAppearance {
    
}
