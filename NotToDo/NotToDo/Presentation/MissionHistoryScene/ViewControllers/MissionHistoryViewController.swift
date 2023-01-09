//
//  MissionHistoryViewControllers.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/07.
//

import UIKit

final class MissionHistoryViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var missionHistoryView: MissionHistoryView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        missionHistoryView = MissionHistoryView()
        view = missionHistoryView
    }
}
