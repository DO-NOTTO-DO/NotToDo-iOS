//
//  HomeCalendarCollectionViewCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/06.
//

import UIKit

import FSCalendar
import SnapKit
import Then

final class HomeCalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "HomeCalendarCollectionViewCell"
    var dataSource: [String: Int] = [:]
    
    // MARK: - UI Components
    
    var calendar: FSCalendar! = FSCalendar(frame: .zero)
    
    // MARK: - Life Cycle
    
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

extension HomeCalendarCollectionViewCell {
    private func setUI() {
        backgroundColor = .nottodoWhite
        clipsToBounds = true
        setCalendar()
        setCalendarText()
        layer.addBorder([.bottom], color: .nottodoGray2!, width: 0.5)
    }
    
    private func setCalendarText() {
        for i in 0...I18N.startMonday.count-1 {
            calendar.calendarWeekdayView.weekdayLabels[i].text = I18N.startMonday[i]
        }
    }
    
    private func setCalendar() {
        calendar.do {
            
            /* */
            $0.dataSource = self
            $0.delegate = self
            $0.register(MissionCalendarDayCell.self, forCellReuseIdentifier: String(describing: MissionCalendarDayCell.self))
            
            $0.appearance.titleTodayColor = .nottodoBlack
            $0.appearance.todayColor = .none
            $0.appearance.todaySelectionColor = .none
            $0.appearance.selectionColor = .none
            
            $0.appearance.weekdayTextColor = .nottodoBlack
            $0.appearance.titleSelectionColor = .nottodoBlack
            $0.appearance.borderRadius = 0.4.adjusted
            $0.appearance.titleFont = .PretendardMedium(size: 14.adjusted)
            $0.appearance.weekdayFont = .PretendardMedium(size: 14.adjusted)
            $0.appearance.headerMinimumDissolvedAlpha = 0
            $0.appearance.borderRadius = 9.adjusted
            $0.weekdayHeight = 17.adjusted
            $0.calendarWeekdayView.fs_height = 0
            $0.headerHeight = 0
            $0.scope = .week
            $0.firstWeekday = 2
            $0.locale = Locale(identifier: "ko_KR")
            $0.placeholderType = .fillHeadTail
            $0.collectionView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    private func setLayout() {
        addSubviews(calendar)
        
        calendar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(350.adjusted)
            $0.width.equalTo(364.adjusted)
            $0.top.equalToSuperview().inset(23.adjusted)
        }
    }
}

extension HomeCalendarCollectionViewCell: FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: String(describing: MissionCalendarDayCell.self), for: date, at: position) as! MissionCalendarDayCell
        cell.configure(.bordered)
        return cell
    }
}

extension HomeCalendarCollectionViewCell: FSCalendarDelegate {
    
}
