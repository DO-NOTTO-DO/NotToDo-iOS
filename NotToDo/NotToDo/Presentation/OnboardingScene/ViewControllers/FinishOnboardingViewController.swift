//
//  FinishOnboardingViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

final class FinishOnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingView: FinishOnboardingView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        onboardingView = FinishOnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
}

extension FinishOnboardingViewController {
    private func setAddTarget() {
        onboardingView.enrollButton.addTarget(self, action: #selector(enrollButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func enrollButtonDidTap() {
        
        if let window = view.window?.windowScene?.keyWindow {
            let TabBarController = TabBarController()
            let navigationController = UINavigationController(rootViewController: TabBarController)
            navigationController.isNavigationBarHidden = true
            window.rootViewController = navigationController
        }
    }
}
