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
  
    // TODO: 해당 데이터 가지고 셀 각각에 데이터 뿌려주면 될듯
    // 딕셔너리나 배열 적절하게 선택해서 사용하기 -> 배열이 더 익숙하니까 배열 사용하는 것이 더 편할 것임
    // 아마 서버에서 [날짜(String), Int] 값을 배열 형태로 같이 넘겨줄 것 같은데 그거 가지고 사용하면 됨
    var dataSource: [String: Int] = [:]
    
    // TODO: 해당 데이터 가지고 셀 각각에 데이터 뿌려주면 될듯
    // 딕셔너리나 배열 적절하게 선택해서 사용하기 -> 배열이 더 익숙하니까 배열 사용하는 것이 더 편할 것임
    // 아마 서버에서 [날짜(String), Int] 값을 배열 형태로 같이 넘겨줄 것 같은데 그거 가지고 사용하면 됨
    var dataSource: [String: Int] = [:]
    
    // MARK: - Properties
    
    static let identifier = "HomeCalendarCollectionViewCell"
    
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
            $0.register(MissionCalendarCell.self, forCellReuseIdentifier: String(describing: MissionCalendarCell.self))
            
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
    
    // 서버에서 넘어온 dateString이랑 이 메서드의 date를 잘 매칭시켜줘야 함
    // date 매칭된 것에 맞게 데이터를 넘겨줘야 함
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: String(describing: MissionCalendarCell.self), for: date, at: position) as! MissionCalendarCell
        
        // MARK: 서버에서 넘어온 값에 따라 셀 상태 변화시켜주기
        // Date : Int(Enum)
        /*
         NotToDoCalendarCell에 가보면 Enum이 보일 것임
         프로젝트 상황에 따라 적절하게 바꿔서 사용하기
         
         현재는 5개의 case가 있음
         - none, step1, step2, step3, bordered
         
         case에 따라서 backgroundColor 변화시키는 식으로 구현되어 있는데 UI 디테일을 살리고 싶으면
         그냥 case에 따라 이미지를 넣는 것이 더 쉬움
         */
        
        // 캘린더 셀 설정해주는 코드 : CollectionViewCell이랑 동일하게 생각하면 됨
        cell.configure(.bordered)
        return cell
    }
}

extension HomeCalendarCollectionViewCell: FSCalendarDelegate {
    
}
