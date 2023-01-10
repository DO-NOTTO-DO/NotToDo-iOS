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
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    var data: [Situation] = Situation.dummy()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        setUI()
        setLayout()
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
        }
    }
    
    func configView() {
        var tableViewData: [[String]] = []
        var titleList: [TitleButtonList] = []
        var isSelected: [Bool] = []
        for item in data {
            tableViewData.append(item.convert())
            titleList.append(TitleButtonList(title: item.name))
            isSelected.append(false)
        }
        situationView.tableViewData = tableViewData
        situationView.titleLists = titleList
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
            $0.height.equalTo(CGFloat(missionView.missionList.count) * 55.adjusted + 92.adjusted)
            $0.bottom.equalTo(scrollView.snp.bottom).offset(-78.adjusted)
        }
        
        situationView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
//            $0.height.equalTo(CGFloat(situationView.titleLists.count) * 65.adjusted + 148.adjusted)
            $0.height.equalTo(CGFloat(situationView.titleLists.count) * 55.adjusted + 92.adjusted)

        }
        
        bottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.adjusted)
            if missionView.isHidden {
//                $0.top.equalTo(situationView.snp.top).offset(CGFloat(situationView.titleLists.count) * 65.adjusted + 168.adjusted)
                $0.top.equalTo(situationView.snp.top).offset(CGFloat(situationView.titleLists.count) * 55.adjusted + 102.adjusted)

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
                $0.top.equalTo(situationView.snp.top).offset(CGFloat(situationView.titleLists.count) * 55.adjusted + 102.adjusted)

//                $0.top.equalTo(situationView.snp.top).offset(CGFloat(situationView.titleLists.count) * 65.adjusted + 168.adjusted)
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
