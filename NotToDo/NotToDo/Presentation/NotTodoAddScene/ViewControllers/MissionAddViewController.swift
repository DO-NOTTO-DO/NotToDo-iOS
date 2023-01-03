//
//  NotTodoAddViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class MissionAddViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var missionAddView: MissionAddView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .nottodoGray1
    }
    
    override func loadView() {
        super.loadView()
        missionAddView = MissionAddView(frame: self.view.frame)
        self.view = missionAddView
    }
}
