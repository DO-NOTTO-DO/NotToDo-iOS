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

final class AchievementViewController: UIViewController, SituationButtonDelegate {
  
    
    // MARK: - UI Components
    
    private lazy var scrollView = UIScrollView()
    private var titleView = TitleView()
    private var mainTableView = UITableView(frame: .zero, style: .grouped)

    private lazy var calendarView = CustomCalendar(frame: .zero)
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        register()
        setLayout()
    }
}

// MARK: - Methods

extension AchievementViewController {
    private func setUI() {
        view.backgroundColor = .BG
        
        mainTableView.do {
            $0.rowHeight = UITableView.automaticDimension
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
        }
    }
    private func register() {
        mainTableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.identifier)
        mainTableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: StatisticsTableViewCell.identifier)
    }
    private func setLayout() {
        view.addSubviews(titleView, mainTableView)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(17.adjusted)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(30.adjusted)
        }
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
        
    }
}

extension AchievementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let calendarCell = tableView.dequeueReusableCell(
                withIdentifier: CalendarTableViewCell.identifier, for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }
            calendarCell.selectionStyle = .none
            calendarCell.backgroundColor = .clear
            
            return calendarCell
        case 1:
            guard let statisticsCell = tableView.dequeueReusableCell(
                withIdentifier: StatisticsTableViewCell.identifier, for: indexPath) as? StatisticsTableViewCell else { return UITableViewCell() }
            statisticsCell.selectionStyle = .none
            statisticsCell.backgroundColor = .clear
            statisticsCell.delegate = self
            
            return statisticsCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
  
    }
    func buttonTapped(cell: UITableViewCell) {
        mainTableView.reloadData()
    }
    
}
