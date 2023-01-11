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
        requestBannerAPI()
    }
}

extension HomeViewController {
    private func setAddTarget() {
        homeView.addMissionButton.addTarget(self, action: #selector(addMission), for: .touchUpInside)
    }
    
    private func requestBannerAPI() {
        HomeAPI.shared.getBanner { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            
            dump(response)
        }
    }
    
    // MARK: - @objc Methods
    
    @objc private func addMission() {
        let addMissionViewController = AddMissionViewController()
        addMissionViewController.modalPresentationStyle = .overFullScreen
        present(addMissionViewController, animated: true)
    }
}
