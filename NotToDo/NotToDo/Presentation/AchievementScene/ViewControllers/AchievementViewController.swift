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
        requestMonthAPI(month: dateFormatter.string(from: calendarView.calendar.today!))
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
                guard let data = data as? [AchieveCalendarResponseDTO] else { return }
                self.dataSource = [:]
                for item in data {
                    self.dataSource[item.actionDate] = item.count
                }
                calendarView.calendar.reloadData()
                
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
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: String(describing: MissionCalendarDayCell.self), for: date, at: position) as! MissionCalendarDayCell
        
        if let count = self.dataSource[date.toString()] {
            switch count {
            case 0:
                cell.configure(.none)
            case 1:
                cell.configure(.step1)
            case 2:
                cell.configure(.step2)
            case 3:
                cell.configure(.step3)
            default:
                cell.configure(.none)
            }
        }
        return cell
    }
}

