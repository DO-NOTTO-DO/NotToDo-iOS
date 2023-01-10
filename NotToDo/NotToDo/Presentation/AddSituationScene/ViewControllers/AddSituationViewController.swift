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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        addSituationView = AddSituationView()
        view = addSituationView
    }
}
 
extension AddSituationViewController {
    private func setAddTarget() {
        addSituationView.navigationBarView.backButton.addTarget(self, action: #selector(dismissToHomeViewController), for: .touchUpInside)
        addSituationView.navigationBarView.successButton.addTarget(self, action: #selector(dismissToHomeViewController), for: .touchUpInside)
    }
    
    /// 페이지 이동
    
    @objc private func dismissToHomeViewController() {
        dismiss(animated: true)
    }

}
