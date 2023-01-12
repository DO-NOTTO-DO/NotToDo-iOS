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
    weak var delegate: MissionHistoryViewDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        missionHistoryView = MissionHistoryView()
        view = missionHistoryView
    }
}

extension MissionHistoryViewController {
    private func setAddTarget() {
        missionHistoryView.backButton.addTarget(self, action: #selector(popToAddMissionViewController), for: .touchUpInside)
    }

    @objc private func popToAddMissionViewController() {
        delegate?.sendMissionHistoryData(data: missionHistoryView.inputTextField.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
}
