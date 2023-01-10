//
//  NotTodoAddViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

final class AddMissionViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var addMissionView: AddMissionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }
    
    override func loadView() {
        super.loadView()
        addMissionView = AddMissionView()
        view = addMissionView
    }
}
