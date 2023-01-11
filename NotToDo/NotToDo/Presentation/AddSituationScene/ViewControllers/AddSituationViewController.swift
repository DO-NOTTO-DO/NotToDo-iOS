//
//  AddSituationViewController.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

final class AddSituationViewController: UIViewController {
    
    // MARK: - Properties
    
    var checkSituationButton: ((String) -> Void)?
    
    // MARK: - UI Components
    
    private var addSituationView: AddSituationView!
    var delegate: AddSituationViewDelegate?
    
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
        addSituationView.navigationBarView.backButton.addTarget(self, action: #selector(popToAddMissionController), for: .touchUpInside)
        addSituationView.navigationBarView.successButton.addTarget(self, action: #selector(popToAddMissionController), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func popToAddMissionController() {
        delegate?.sendSituationData(data: addSituationView.getChangedText())
        self.checkSituationButton?(addSituationView.getChangedText())
        self.navigationController?.popViewController(animated: true)
    }
}
