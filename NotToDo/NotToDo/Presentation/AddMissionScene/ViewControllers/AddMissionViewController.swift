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
        addMissionView.behaviorTitleView.AddMissionButton.addTarget(self, action: #selector(touchupRecommendButton), for: .touchUpInside)
        addMissionView.situationView.AddMissionButton.addTarget(self, action: #selector(presentToAddSituationViewController), for: .touchUpInside)
        addMissionView.addMissionButton.addTarget(self, action: #selector(touchupAddMissionButton), for: .touchUpInside)
    }
    
    /// 페이지 이동
    
    private func presentToRecommendViewController() {
        let RecommendViewController = RecommendViewController()
        self.navigationController?.pushViewController(RecommendViewController, animated: true)
        print("추천뷰 가기")
    }
    
    private func dismissToHomeViewController() {
        dismiss(animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc private func dismissAddMissionViewController() {
        dismiss(animated: true)
    }
    
    @objc private func touchupRecommendButton() {
        presentToRecommendViewController()
    }
    
    @objc private func presentToAddSituationViewController() {
        print("ASDFA")
        let addSituationViewController = AddSituationViewController()
        dismiss(animated: true)
        navigationController?.pushViewController(addSituationViewController, animated: true)
    }
    
    @objc private func touchupAddMissionButton() {
        dismissToHomeViewController()
    }
}
