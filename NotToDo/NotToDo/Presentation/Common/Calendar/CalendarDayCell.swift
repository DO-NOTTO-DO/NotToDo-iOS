//
//  CalendarDayCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/13.
//

import UIKit

import FSCalendar

enum BackgroundType: Int {
    case today
    case none
}

final class CalendarDayCell: FSCalendarCell {
    
    // MARK: - Properties
    
    weak var dayBackView: UIView!
    var backgroundType: BackgroundType = .today {
        didSet {
            setUI()
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension CalendarDayCell {
    private func setUI() {
        switch self.backgroundType {
        case .today:
            dayBackView.backgroundColor = .yellow_mild
        case .none:
            dayBackView.backgroundColor = .nottodoGray1
        }
    }
}
