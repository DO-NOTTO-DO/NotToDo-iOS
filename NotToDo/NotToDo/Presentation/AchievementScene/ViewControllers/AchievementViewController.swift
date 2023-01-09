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
    
    private var missionHidden: Bool = false {
        didSet {
            print(missionHidden)
            setUpdateConstraint()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var scrollView = UIScrollView()
    private var titleView = TitleView()
    private lazy var segmentedControl = CustomSegmentedControl(items: [" 낫투두 통계보기 ", " 상황별 통계보기 "])
    private lazy var calendarView = CustomCalendar(frame: .zero)
    private lazy var missionView = MissionStatisticsView(frame: view.bounds)
    private lazy var situationView = SituationStatisticsView(frame: view.bounds)
    private var bottomLabel = UILabel()
    private lazy var dateFormatter = DateFormatter()

    private lazy var safeArea = self.view.safeAreaLayoutGuide

    // MARK: - Properties
    
    var shouldHideMissionView: Bool? {
        didSet {
            guard let shouldHideMissionView = self.shouldHideMissionView else { return }
            self.missionView.isHidden = shouldHideMissionView
            self.situationView.isHidden = !self.missionView.isHidden
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            $0.text = "* 올해의 낫투두가 누적된 통계예요!"
            $0.font = .PretendardMedium(size: 12)
            $0.textColor = .nottodoGray2
        }
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
            $0.bottom.equalToSuperview()
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
            $0.height.equalTo(missionView.missionList.count * 55 + 88)
            $0.bottom.equalToSuperview().offset(-78.adjusted)
        }
        
        situationView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            $0.height.equalTo(situationView.titleLists.count * 55 + 88 )
        }
        
        bottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.top.equalTo(situationView.snp.bottom).offset(12.adjusted)
        }
        
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setNeedsLayout()
        didChangeValue(segment: self.segmentedControl)
    }
    
    private func setUpdateConstraint() {
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideMissionView = segment.selectedSegmentIndex != 0
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
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
            switch dateFormatter.string(from: date) {
            case dateFormatter.string(from: Date()):
                return "오늘"
            default:
                return nil
            }
        }
}
