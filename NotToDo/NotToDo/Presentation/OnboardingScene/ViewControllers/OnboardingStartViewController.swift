//
//  OnboardingStartViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

final class OnboardingStartViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingView: StartOnboardingView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        onboardingView = StartOnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
}

extension OnboardingStartViewController {
    private func setAddTarget() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func startButtonDidTap() {
        let nextViewController = FirstOnboardingViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
