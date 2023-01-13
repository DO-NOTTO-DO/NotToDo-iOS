//
//  MissionCalendarDayCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/13.
//

import UIKit

import FSCalendar
import SnapKit
import Then

enum ToDoState {
    case none
    case step1
    case step2
    case step3
    case bordered
}

extension ToDoState {
    var bgColor: UIColor? {
        switch self {
        case .none:
            return .clear
        case .step1:
            return .yellow_mild
        case .step2:
            return .yellow_basic
        case .step3:
            return .yellow_deep
        case .bordered:
            return .brown
        }
    }
}

final class MissionCalendarDayCell: FSCalendarCell {
    
    // MARK: - Properties
    
    var state: ToDoState = .none {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI Components
    
    private let stateView = UIView().then {
        $0.layer.cornerRadius = 8
    }
    private var padding = 8
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        contentView.insertSubview(stateView, at: 0)
        stateView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(padding)
        }
    }
    
    private func updateUI() {
        stateView.backgroundColor = state.bgColor
    }
}

extension MissionCalendarDayCell {
    func configure(_ state: ToDoState) {
        self.state = state
        updateUI()
    }
}
