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
    private lazy var dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    var situationList: [SituationStatistcsResponse] = []
    var missionList: [MissionStatistcsResponse] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSituationView()
        setUI()
        setLayout()
        requestAchieveAPI()
    }
}

// MARK: - Methods

extension AchievementViewController {
    func setUI() {
        view.backgroundColor = .BG
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.backgroundColor = .BG
        }
        calendarView.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
            $0.calendar.delegate = self
        }
        bottomLabel.do {
            $0.text = I18N.statistcisBottomMessage
            $0.font = .PretendardMedium(size: 12.adjusted)
            $0.textColor = .nottodoGray2
            if missionView.missionList.isEmpty && situationView.situationList.isEmpty {
                $0.isHidden = true
            }
        }
    }
    
    private func requestAchieveAPI() {
        MissionStatisticsAPI.shared.getMissionStatistics { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            self?.missionList = response.data!
            self?.configMissionView()
            self?.missionView.missionTableView.reloadData()
            dump(response)
        }
        SituationStatisticsAPI.shared.getSituationStatistics { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            self?.situationList = response.data!
            self?.configSituationView()
            self?.situationView.expangindTableView.reloadData()
            print(response)
            dump(response)
        }
    }
    func configMissionView(){
        missionView.missionList = missionList
    }
    
    func configSituationView() {
        var isSelected: [Bool] = [Bool](repeating: false, count: situationList.count)
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
                $0.height.equalTo(CGFloat(missionView.missionList.count) * 55.adjusted + 92.adjusted)
            }
            $0.bottom.equalTo(scrollView.snp.bottom).offset(-78.adjusted)
        }
        
        situationView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            if situationView.situationList.isEmpty {
                $0.height.equalTo(300.adjusted)
            } else {
                $0.height.equalTo(CGFloat(situationView.situationList.count) * 55.adjusted + 120.adjusted)
            }
        }
        bottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.adjusted)
            if missionView.isHidden {
                $0.top.equalTo(situationView.snp.top).offset(CGFloat(situationView.situationList.count) * 55.adjusted + 130.adjusted)
            } else {
                $0.top.equalTo(missionView.snp.top).offset(CGFloat(missionView.missionList.count) * 55.adjusted + 102.adjusted)
            }
        }
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setNeedsLayout()
        didChangeValue(segment: self.segmentedControl)
    }
    
    func relayout() {
        bottomLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(20.adjusted)
            if missionView.isHidden {
                $0.top.equalTo(situationView.snp.top).offset(CGFloat(situationView.situationList.count) * 55.adjusted + 130.adjusted)
            } else {
                $0.top.equalTo(missionView.snp.top).offset(CGFloat(missionView.missionList.count) * 55.adjusted + 102.adjusted)
            }
        }
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideMissionView = segment.selectedSegmentIndex != 0
        relayout()
    }
}

extension AchievementViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendarView.calendar.reloadData()
        calendarView.headerLabel.text = calendarView.dateFormatter.string(from: calendar.currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
}
