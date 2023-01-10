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
        addMissionView.behaviorTitleView.AddMissionButton.do {
            $0.addTarget(self, action: #selector(touchupRecommendButton), for: .touchUpInside)
        }
        addMissionView.situationView.AddMissionButton.do {
            $0.addTarget(self, action: #selector(touchupSituationButton), for: .touchUpInside)
        }
    }
    
    /// 페이지 이동
    
    private func presentToRecommendViewController() {
        let RecommendViewController = RecommendViewController()
        self.navigationController?.pushViewController(RecommendViewController, animated: true)
    }
    
    private func presentToAddSituationViewController() {
        let AddSituationViewController = AddSituationViewController()
        AddSituationViewController.modalPresentationStyle = .formSheet
        
        // WelcomeVC.name = idTextField.text
        // WelcomeVC.dataBind()
        
        //        if let situationKeyword = idTextField.text {
        //            WelcomeVC.dataBind(name:id)
        //        }
        self.navigationController?.pushViewController(AddSituationViewController, animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func touchupRecommendButton() {
        presentToRecommendViewController()
    }

    @objc
    private func touchupSituationButton() {
        presentToAddSituationViewController()
    }
}
