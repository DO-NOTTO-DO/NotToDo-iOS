//
//  ActionSheetView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/03.
//

import UIKit

import FSCalendar
import SnapKit
import Then

public enum ActionSheetType {
    case meatball
    case calendar
    
    var viewHeight: CGFloat {
        switch self {
        case .meatball:
            return 306.adjusted
        case .calendar:
            return 443.adjusted
        }
    }
}

final class ActionSheetView: UIView {
    
    // MARK: - Properties
    
    var mode: ActionSheetType {
        didSet {
            setupMode(mode: mode)
        }
    }
    
    // MARK: - UI Components
    
    private let labelStackView = UIStackView()
    private let situationLabel = UILabel()
    private let missionLabel = UILabel()
    private let deleteView = UIView()
    private let deleteIcon = UIImageView()
    private let deleteLabel = UILabel()
    private let editView = UIView()
    private let editIcon = UIImageView()
    private let editLabel = UILabel()
    let duplicateView = UIView()
    private let duplicateIcon = UIImageView()
    private let duplicateLabel = UILabel()
    private let subDuplicateLabel = UILabel()
    private let divisionLine1 = UIView()
    private let divisionLine2 = UIView()
    
    var calendar: FSCalendar! = FSCalendar(frame: .zero)
    private lazy var hStack = UIStackView(arrangedSubviews: [leftButton, rightButton])
    var headerLabel = UILabel()
    private var leftButton = UIButton()
    private var rightButton = UIButton()
    private var currentPage: Date?
    private lazy var today: Date = { return Date() }()
    lazy var dateFormatter = DateFormatter()
    
    var selectButton = NotTodoButton(frame: CGRect(), mode: .plain, text: I18N.select, image: nil, font: .bold, size: 18.adjusted)

    // MARK: - View Life Cycle
    
    init(frame: CGRect, mode: ActionSheetType, situation: String, mission: String) {
        self.mode = mode
        super.init(frame: frame)
        addShape()
        setupMode(mode: mode)
        setLabel(situation, mission)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionSheetView {
    
    // MARK: - UI Methods
    
    private func setupMode(mode: ActionSheetType) {
        switch mode {
        case .meatball:
            setUI(mode: .meatball)
            setLayout(mode: .meatball)
        case .calendar:
            setUI(mode: .calendar)
            setLayout(mode: .calendar)
        }
    }
    
    private func setUI(mode: ActionSheetType) {
        backgroundColor = .clear
        switch mode {
        case .meatball:
            setMeatballUI()
        case .calendar:
            setCalendarUI()
        }
    }
    
    private func setLabel(_ situation: String, _ mission: String) {
        situationLabel.text = situation
        missionLabel.text = mission
    }
    
    private func setMeatballUI() {
        [deleteLabel, editLabel, duplicateLabel].forEach {
            $0.font = .PretendardMedium(size: 16.adjusted)
            $0.textColor = .nottodoGray1
        }
        situationLabel.do {
            $0.text = "9시 이전"
            $0.font = .PretendardRegular(size: 16.adjusted)
            $0.textColor = .nottodoGray2
        }
        
        missionLabel.do {
            $0.text = "유튜브 보지 않기"
            $0.font = .PretendardRegular(size: 16.adjusted)
            $0.textColor = .nottodoBlack
        }
        
        deleteLabel.text = I18N.delete
        editLabel.text = I18N.edit
        duplicateLabel.text = I18N.duplicate
        subDuplicateLabel.do {
            $0.text = I18N.subDuplicate
            $0.font = .PretendardRegular(size: 12.adjusted)
            $0.textColor = .nottodoGray2
        }
        
        deleteIcon.image = .trash
        editIcon.image = .edit
        duplicateIcon.image = .anotherDay
        [divisionLine1, divisionLine2].forEach {
            $0.backgroundColor = .nottodoGray4
        }
        
        labelStackView.do {
            $0.distribution = .fill
            $0.spacing = 5.adjusted
            $0.axis = .horizontal
            $0.addArrangedSubviews(situationLabel, missionLabel)
        }
        
        [deleteView, editView, duplicateView].forEach {
            $0.backgroundColor = .clear
        }
    }
    
    private func setCalendarUI() {
        setCalendarText()
        setCalendarColor()
        
        hStack.do {
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
            $0.spacing = 14.adjusted
        }
        
        leftButton.do {
            $0.setImage(.calendarLeftArrow, for: .normal)
            $0.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        }
        
        rightButton.do {
            $0.setImage(.calendarRightArrow, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
        
        dateFormatter.do {
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "yyyy년 M월"
        }
        
        calendar.do {
            $0.calendarHeaderView.isHidden = true
            $0.appearance.headerMinimumDissolvedAlpha = 0
            $0.placeholderType = .fillHeadTail
            $0.headerHeight = 0
            $0.scope = .month
            $0.allowsMultipleSelection = true
            $0.locale = Locale(identifier: "ko_KR")

        }
        
        headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    private func setCalendarText() {
        for i in 0...I18N.startSunday.count-1 {
            calendar.calendarWeekdayView.weekdayLabels[i].text = I18N.startSunday[i]
        }
    }
    
    private func setCalendarColor() {
        calendar.do {
            $0.appearance.weekdayTextColor = .nottodoGray2
            $0.appearance.titleSelectionColor = .nottodoBlack
            $0.appearance.selectionColor = .yellow_basic
            $0.appearance.borderRadius = 0.4.adjusted
            $0.today = nil
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendar.reloadData()
        self.headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    // MARK: - Layout Methods
    
    private func setLayout(mode: ActionSheetType) {
        switch mode {
        case .meatball:
            setMeatballLayout()
        case .calendar:
            setCalendarLayout()
        }
    }
    
    private func setMeatballLayout() {
        deleteView.addSubviews(deleteIcon, deleteLabel)
        editView.addSubviews(editIcon, editLabel)
        duplicateView.addSubviews(duplicateIcon, duplicateLabel, subDuplicateLabel)
        addSubviews(labelStackView, deleteView, editView,
                    duplicateView, divisionLine1, divisionLine2)
        
        missionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalTo(situationLabel.snp.trailing).offset(5.adjusted)
        }
        
        situationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        deleteView.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(16.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(58.adjusted)
        }

        deleteIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(34.adjusted)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(30.adjusted)
        }

        deleteLabel.snp.makeConstraints {
            $0.centerY.equalTo(deleteIcon.snp.centerY)
            $0.leading.equalTo(deleteIcon.snp.trailing).offset(11.adjusted)
        }

        divisionLine1.snp.makeConstraints {
            $0.top.equalTo(deleteView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5.adjusted)
        }
        
        editView.snp.makeConstraints {
            $0.top.equalTo(divisionLine1.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(60.adjusted)
        }
        
        editIcon.snp.makeConstraints {
            $0.leading.equalTo(deleteIcon.snp.leading)
            $0.size.equalTo(30.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        editLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(editIcon.snp.trailing).offset(11.adjusted)
        }
        
        divisionLine2.snp.makeConstraints {
            $0.top.equalTo(editView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5.adjusted)
        }
        
        duplicateView.snp.makeConstraints {
            $0.top.equalTo(divisionLine2.snp.bottom)
            $0.height.equalTo(60.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview()
        }

        duplicateIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14.adjusted)
            $0.leading.equalTo(deleteIcon.snp.leading)
            $0.size.equalTo(30.adjusted)
        }

        duplicateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19.adjusted)
            $0.leading.equalTo(duplicateIcon.snp.trailing).offset(10.adjusted)
        }

        subDuplicateLabel.snp.makeConstraints {
            $0.top.equalTo(duplicateLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(duplicateIcon.snp.trailing).offset(10.adjusted)
        }
    }
    
    private func setCalendarLayout() {
        addSubviews(hStack, headerLabel, calendar, selectButton)
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38.adjusted)
            $0.leading.equalToSuperview().offset(50.adjusted)
        }
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34.adjusted)
            $0.trailing.equalTo(headerLabel.snp.trailing).offset(133.adjusted)
            $0.trailing.equalToSuperview().offset(-47.adjusted)
        }
        calendar.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(30.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(44.adjusted)
            $0.height.equalTo(242.adjusted)
        }
        selectButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.top.equalTo(calendar.snp.bottom).offset(21.adjusted)
            $0.height.equalTo(48.adjusted)
        }
    }
    
    // MARK: - UIView Custom Methods
    
    private func createPath() -> CGPath {
        let dn: CGFloat = 15.adjusted
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: dn, y: 0))
        path.addLine(to: CGPoint(x: Numbers.width - dn, y: 0))
        path.addLine(to: CGPoint(x: Numbers.width, y: dn))
        path.addLine(to: CGPoint(x: Numbers.width, y: Numbers.height))
        path.addLine(to: CGPoint(x: 0, y: Numbers.height))
        path.addLine(to: CGPoint(x: 0, y: dn))
        path.close()
        return path.cgPath
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.nottodoWhite?.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : +1
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc func prevButtonTapped(_sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    
    @objc func nextButtonTapped(_sender: UIButton) {
        scrollCurrentPage(isPrev: false)
    }
}
