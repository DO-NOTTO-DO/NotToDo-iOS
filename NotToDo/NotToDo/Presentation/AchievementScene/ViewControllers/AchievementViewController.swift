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
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .nottodoBlack
        setAttributes()
        setViews()
        setConstraints()
    }
    
    
    private func setAttributes(){
        scrollView.do {
            $0.backgroundColor = .yellow
        }
        calendarView.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.nottodoGray2?.cgColor
        }
    }
    private func setViews(){
        view.addSubviews(scrollView)
        scrollView.addSubviews(calendarView)
    }
    private func setConstraints(){
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(118.adjusted)
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(20.adjusted)
            $0.height.equalTo(380)
        }
    }
}

