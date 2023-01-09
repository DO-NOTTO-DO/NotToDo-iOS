//
//  CalendarTableViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class CalendarTableViewCell: UITableViewCell {
    
    static var identifier = "CalendarTableViewCell"
    
    private lazy var calendarView = CustomCalendar(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        calendarView.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
            $0.calendar.delegate = self
        }
    }
    func setLayout() {
        contentView.addSubview(calendarView)
        
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(380.adjusted)
        }
    }
}
extension CalendarTableViewCell: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendarView.calendar.reloadData()
        calendarView.headerLabel.text = calendarView.dateFormatter.string(from: calendar.currentPage)
    }
}
