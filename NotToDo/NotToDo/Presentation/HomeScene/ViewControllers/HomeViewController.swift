//
//  HomeViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var homeView: HomeView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        homeView = HomeView(frame: CGRect(), motivationText: "초기화 값입니다.")
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
}

extension HomeViewController {
    private func setAddTarget() {
        homeView.addMissionButton.addTarget(self, action: #selector(addMission), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func addMission() {
        let addMissionViewController = AddMissionViewController()
        let navigationController = UINavigationController(rootViewController: addMissionViewController)
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.isNavigationBarHidden = true
        present(navigationController, animated: true)
    }
}
