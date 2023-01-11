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
        hideKeyboardWhenTappedAround()
        setAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        addMissionView = AddMissionView()
        view = addMissionView
    }
}

extension AddMissionViewController {
    private func setAddTarget() {
        addMissionView.navigationBarView.backButton.addTarget(self, action: #selector(dismissAddMissionViewController), for: .touchUpInside)
        addMissionView.missionTextField.addTarget(self, action: #selector(pushToMissionHistoryViewController), for: .touchUpInside)
        addMissionView.behaviorTitleView.AddMissionButton.addTarget(self, action: #selector(pushToRecommendViewController), for: .touchUpInside)
        addMissionView.situationView.AddMissionButton.addTarget(self, action: #selector(pushToAddSituationViewController), for: .touchUpInside)
        addMissionView.addMissionButton.addTarget(self, action: #selector(dismissAddMissionViewController), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func dismissAddMissionViewController() {
        dismiss(animated: true)
    }
    
    @objc private func pushToRecommendViewController() {
        let recommendViewController = RecommendViewController()
        self.navigationController?.pushViewController(recommendViewController, animated: true)
    }
    
    @objc private func pushToAddSituationViewController() {
        let addSituationViewController = AddSituationViewController()
        addSituationViewController.delegate = self
        self.navigationController?.pushViewController(addSituationViewController, animated: true)
    }
    
    @objc private func pushToMissionHistoryViewController() {
        let missionHistoryViewController = MissionHistoryViewController()
        self.navigationController?.pushViewController(missionHistoryViewController, animated: true)
    }
    
    @objc private func dismissToHomeViewController() {
        dismiss(animated: true)
    }
}

extension AddMissionViewController: AddSituationViewDelegate {
    func sendData(data: String) {
        // pop된 뷰컨에서 넘겨 받은 데이터를 원하는 곳에 넣어주기
        addMissionView.situationView.AddMissionButton.setTitle(data, for: .normal)
    }
}
