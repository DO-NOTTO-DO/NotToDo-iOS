//
//  AddSituationViewController.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/06.
//

import UIKit

final class AddSituationViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var addSituationView: AddSituationView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        addSituationView = AddSituationView()
        view = addSituationView
    }
}
