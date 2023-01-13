//
//  customCalendar.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class CustomCalendar: UIView {
    
    // MARK: - UI Components
    
    var calendar: FSCalendar! = FSCalendar(frame: .zero)
    private lazy var hStack = UIStackView(arrangedSubviews: [leftBtn, rightBtn])
    lazy var headerLabel = UILabel()
    private lazy var leftBtn = UIButton()
    private lazy var rightBtn = UIButton()
    private lazy var headerImage = UIImageView()
    var currentPage: Date? 
    private lazy var today: Date = { return Date() }()
    lazy var dateFormatter = DateFormatter()
    var monthData: [AchieveCalendarResponseDTO] = []
    var monthCalendarClosure: ((_ month: String) -> Void)?
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        calendarText()
        calendarColor()
        setUpCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CustomCalendar {
    private func setUI() {
        backgroundColor = .nottodoWhite
        hStack.do {
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
            $0.spacing = 14.adjusted
        }
        headerLabel.do {
            $0.text = self.dateFormatter.string(from: calendar.currentPage)
            $0.textColor = .black
        }
        headerImage.do {
            $0.image = .headerImage
        }
        leftBtn.do {
            $0.setImage(.calendarLeftArrow, for: .normal)
            $0.addTarget(self, action: #selector(prevBtnTapped), for: .touchUpInside)
        }
        rightBtn.do {
            $0.setImage(.calendarRightArrow, for: .normal)
            $0.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        }
        dateFormatter.do {
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "yyyy년 M월"
        }
        calendar.locale = Locale(identifier: "ko_KR")
    }
    
    private func setLayout() {
        addSubviews(hStack, headerImage, calendar)
        headerImage.addSubview(headerLabel)
        
        headerImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(23.adjusted)
            $0.top.equalToSuperview().offset(22.adjusted)
            $0.width.equalTo(138.adjusted)
            $0.height.equalTo(35.adjusted)
        }
        headerLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(64.adjusted)
        }
        calendar.snp.makeConstraints {
            $0.top.equalTo(headerImage.snp.bottom).offset(25.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(23.adjusted)
            $0.bottom.equalToSuperview().inset(26.adjusted) 
        }
    }
    
    private func calendarText() {
        calendar.calendarHeaderView.isHidden = true
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
    }
    private func calendarColor() {
        calendar.appearance.weekdayTextColor = .nottodoGray2
        calendar.appearance.titleWeekendColor = .nottodoBlack
        calendar.appearance.titleSelectionColor = .nottodoBlack
        calendar.appearance.selectionColor = .yellow_basic
        calendar.appearance.borderRadius = 0.4
        calendar.appearance.titleWeekendColor = .nottodoBlack
        calendar.appearance.titleTodayColor = .blue
        calendar.appearance.todayColor = .clear
    }
    
    private func setUpCalendar() {
        self.calendar.placeholderType = .fillHeadTail
        calendar.headerHeight = 0
        calendar.scope = .month
        headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
        self.dateFormatter.dateFormat = "yyyy-MM"
        let stringDate = self.dateFormatter.string(from: calendar.currentPage)
        monthCalendarClosure?(stringDate)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendar.reloadData()
        self.headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
        self.dateFormatter.dateFormat = "yyyy-MM"
        let stringDate = self.dateFormatter.string(from: calendar.currentPage)
        monthCalendarClosure?(stringDate)
    }
    
    @objc func prevBtnTapped(_sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    @objc func nextBtnTapped(_sender: UIButton) {
        scrollCurrentPage(isPrev: false)
    }
}
