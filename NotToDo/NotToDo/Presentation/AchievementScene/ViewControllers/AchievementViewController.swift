//
//  AchievementViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then
import FSCalendar

final class AchievementViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var scrollView = UIScrollView()
    private lazy var calendarView = customCalendar(frame: .zero)
    private lazy var bottomLabel = UILabel()
    private lazy var segmentedControl = CustomSegmentedControl(items: ["낫투두 통계보기","상황별 통계보기"])
    private lazy var missionVC = MissionStatisticsViewController()
    private lazy var situationVC = SituationStatisticsViewController()
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal).then{
        $0.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
    }
    var dataViewControllers: [UIViewController] {
      [self.missionVC, self.situationVC]
    }
    var currentPage: Int = 0 {
      didSet {
        print(oldValue, self.currentPage)
        let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
        self.pageViewController.setViewControllers(
          [dataViewControllers[self.currentPage]],
          direction: direction,
          animated: true,
          completion: nil
        )
      }
    }
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .BG
        setAttributes()
        setViews()
        setConstraints()
    }
    
    private func setAttributes(){
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.backgroundColor = .nottodoWhite
        }
        calendarView.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
            $0.calendar.delegate = self
        }
        bottomLabel.do {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M월"
            let resultDate = dateFormatter.string(from: date)
            $0.text = "* \(resultDate) 1달간의 낫투두를 바탕으로 만들어진 자료에요!"
            $0.textColor = UIColor.nottodoGray2
            $0.font = UIFont(name: AppFontName.pretendardMedium, size: 12)
        }
    }
    private func setViews(){
        view.addSubviews(scrollView)
        scrollView.addSubviews(calendarView,segmentedControl,pageViewController.view,bottomLabel)
    }
    private func setConstraints(){
        scrollView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.top.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(118.adjusted)
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.height.equalTo(380.adjusted)
        }
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.top.equalTo(calendarView.snp.bottom).offset(30.adjusted)
            $0.height.equalTo(20.adjusted)
        }
        pageViewController.view.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.height.equalTo(400)
        }
        bottomLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(pageViewController.view.snp.bottom).offset(15)
            $0.bottom.equalTo(scrollView.snp.bottom).inset(35.adjusted)
        }
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
    }
    @objc private func changeValue(control: UISegmentedControl) {
        self.currentPage = control.selectedSegmentIndex
    }
}
extension AchievementViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendarView.calendar.reloadData()
        calendarView.headerLabel.text = calendarView.dateFormatter.string(from: calendar.currentPage)
    }
}

