//
//  ActionSheetViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/03.
//

import UIKit

import FSCalendar
import SnapKit
import Then

final class ActionSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private var mode: ActionSheetType! = .meatball
    
    // MARK: - UI Components

    private var actionSheetView = ActionSheetView(frame: CGRect(), mode: .meatball, situation: "9시 이후", mission: "밥 먹기")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setCalendarDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showActionSheetWithAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first,
           touch.view != actionSheetView {
            dismissActionSheetWithAnimation()
        }
    }
}

extension ActionSheetViewController {
    
    // MARK: - Methods
    
    private func setUI() {
        view.backgroundColor = .nottodoBlack?.withAlphaComponent(0.7)
    }
    
    private func setLayout() {
        view.addSubviews(actionSheetView)
        
        actionSheetView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Numbers.height)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func showActionSheetWithAnimation() {
        let actionSheetViewHeight = mode.viewHeight
        self.actionSheetView.snp.updateConstraints {
            $0.top.equalToSuperview().inset(Numbers.height - actionSheetViewHeight)
        }
        UIView.animate(withDuration: 0.3) {
            self.actionSheetView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.backgroundColor = .nottodoBlack?.withAlphaComponent(0.7)
            self.view.layoutIfNeeded()
        }
    }
    
    private func dismissActionSheetWithAnimation() {
        self.actionSheetView.snp.updateConstraints {
            $0.top.equalToSuperview().inset(Numbers.height)
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) {
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
    
    private func setCalendarDelegate() {
        actionSheetView.calendar.delegate = self
    }
}

extension ActionSheetViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let currentDate = Date().addingTimeInterval(-24 * 60 * 60)
        if date < currentDate || date.compare(Date()) == .orderedAscending {
            return false
        } else {
            return true
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        actionSheetView.calendar.reloadData()
        actionSheetView.headerLabel.text = actionSheetView.dateFormatter.string(from: calendar.currentPage)
    }
}
