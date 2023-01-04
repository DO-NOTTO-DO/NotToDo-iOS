//
//  customCalendar.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import SnapKit
import Then
import FSCalendar

class customCalendar: UIView {

    fileprivate weak var calendar: FSCalendar!
    private lazy var hStack = UIStackView(arrangedSubviews: [leftBtn,rightBtn])
    lazy var headerLabel = UILabel()
    private lazy var leftBtn = UIButton()
    private lazy var rightBtn = UIButton()
    private lazy var headerImage = UIImageView()
    private var currentPage: Date?
    private lazy var today: Date = { return Date() }()
    private lazy var dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.nottodoWhite
        let calendar = FSCalendar(frame: .zero)
        self.calendar = calendar
        setAttributes()
        setViews()
        setConstraints()
        calendarText()
        calendarColor()
        setUpCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setAttributes(){
        hStack.do {
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
            $0.spacing = 14
        }
        headerLabel.do {
            $0.text = self.dateFormatter.string(from: calendar.currentPage)
            $0.textColor = .black
        }
        headerImage.do {
            $0.image = UIImage.headerImage
        }
        leftBtn.do {
            $0.setImage(UIImage.calendarLeftArrow, for: .normal)//에셋 변경
            $0.addTarget(self, action: #selector(prevBtnTapped), for: .touchUpInside)
        }
        rightBtn.do {
            $0.setImage(UIImage.calendarRightArrow, for: .normal) //에셋 변경
            $0.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        }
        dateFormatter.do {
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "yyyy년 M월"
        }
    }
    private func setViews(){
        self.addSubviews(hStack,headerImage,calendar)
        headerImage.addSubview(headerLabel)
    }
    private func setConstraints(){
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
            $0.width.equalTo(64)
        }
        calendar.snp.makeConstraints {
            $0.top.equalTo(headerImage.snp.bottom).offset(25.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(23.adjusted)
            $0.bottom.equalToSuperview().inset(26.adjusted) // 버튼이랑 다시 맞추기
        }
    }
    private func calendarText(){
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
    private func calendarColor(){
        calendar.appearance.weekdayTextColor = UIColor.nottodoGray2 // 달력의 요일 글자 색상
        calendar.appearance.titleSelectionColor = UIColor.nottodoBlack //선택한 날짜 글자 색상
        calendar.appearance.selectionColor = UIColor.nottodoBlack // 선택한 날짜 색상
        calendar.appearance.borderRadius = 0.4 //radius 0(사각형) ~ 1(원)
        calendar.appearance.titleWeekendColor = .black
        calendar.today = nil // today 날짜에 색상 없앰

        }
    private func setUpCalendar(){
        self.calendar.placeholderType = .fillHeadTail  //달력 필요한 부분만 보이게
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
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendar.reloadData()
        self.headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    @objc func prevBtnTapped(_sender : UIButton){
        scrollCurrentPage(isPrev: true)
    }
    @objc func nextBtnTapped(_sender : UIButton){
        scrollCurrentPage(isPrev: false)
    }
}
