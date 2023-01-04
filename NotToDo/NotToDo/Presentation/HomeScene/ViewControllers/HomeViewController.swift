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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .nottodoWhite
//        setLayout()
        addAction()
    }
    
    override func loadView() {
        super.loadView()
        homeView = HomeView()
        self.view = homeView
    }
}

extension HomeViewController {
    private func setLayout() {
        view.addSubview(homeView)
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func addAction() {
        homeView.button.addAction(UIAction(handler: { _ in
            let nextViewController = ActionSheetViewController()
            nextViewController.modalPresentationStyle = .overFullScreen
            self.present(nextViewController, animated: false)
        }), for: .touchUpInside)
    }
}
