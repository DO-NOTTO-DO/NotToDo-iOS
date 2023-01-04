//
//  AuthViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/04.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - UI Components
    
    var authView: AuthView!

    // MARK: - Life View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        authView = AuthView(frame: self.view.frame)
        view = authView
    }
}
