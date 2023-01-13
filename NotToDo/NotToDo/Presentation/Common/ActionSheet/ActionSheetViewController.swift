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

protocol ActionSheetViewDelegate: AnyObject {
    func reloadMissionData()
}

final class ActionSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    var mode: ActionSheetType! = .meatball {
        didSet {
            actionSheetView.mode = mode
        }
    }
    var dismissClicked: (() -> Void)?
    var id: Int = 0
    lazy var situation: String = ""
    lazy var mission: String = ""
    weak var delegate: ActionSheetViewDelegate?
    
    // MARK: - UI Components

    lazy var actionSheetView = ActionSheetView(frame: CGRect(), mode: mode, situation: self.situation, mission: self.mission)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setCalendarDelegate()
        setRecognizer()
        setAddTarget()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self.view)
            if position.y < Numbers.height - actionSheetView.frame.height {
                dismissActionSheetWithAnimation()
            }
        }
    }
}

extension ActionSheetViewController {
    
    // MARK: - Methods
    
    private func setUI() {
        view.backgroundColor = .nottodoBlack?.withAlphaComponent(0.7)
    }
    
    private func setLayout() {
        let actionSheetViewHeight = mode.viewHeight
        view.addSubviews(actionSheetView)
        
        actionSheetView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Numbers.height - actionSheetViewHeight)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setRecognizer() {
        let duplicationTapGesture = UITapGestureRecognizer(target: self, action: #selector(anotherButtonDidTap))
        let deleteTapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteButtonDidTap))
        actionSheetView.duplicateView.addGestureRecognizer(duplicationTapGesture)
        actionSheetView.deleteView.addGestureRecognizer(deleteTapGesture)
    }
    
    private func setAddTarget() {
        actionSheetView.selectButton.addTarget(self, action: #selector(choiceFinishButtonDidTap), for: .touchUpInside)
    }
    
    private func dismissActionSheetWithAnimation() {
        self.actionSheetView.snp.updateConstraints {
            $0.top.equalToSuperview().inset(Numbers.height)
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
    
    private func setCalendarDelegate() {
        actionSheetView.calendar.delegate = self
    }
    
    private func requestDeleteMission(id: Int) {
        HomeAPI.shared.deleteMission(id: id) { [weak self] response in
            guard self != nil else { return }
            guard response != nil else { return }
        }
    }
    
    private func requestAddAnotherDay(id: Int, dates: [String]) {
        HomeAPI.shared.postAnotherDay(id: id, dates: dates) { [weak self] response in
            guard self != nil else { return }
            guard response != nil else { return }
        }
    }
    
    // MARK: - @objc
    
    @objc private func anotherButtonDidTap() {
        dismiss(animated: true) { [weak self] in
            self?.dismissClicked?()
        }
    }
    
    @objc private func deleteButtonDidTap() {
        requestDeleteMission(id: id)
        delegate?.reloadMissionData()
        self.dismiss(animated: true)
    }
    
    @objc private func choiceFinishButtonDidTap() {
        requestAddAnotherDay(id: id, dates: ["2023.01.26", "2032.01.26"])
        dismissActionSheetWithAnimation()
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
