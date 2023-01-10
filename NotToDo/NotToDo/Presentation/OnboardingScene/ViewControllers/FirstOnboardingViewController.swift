//
//  FirstOnboardingViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

final class FirstOnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingView: FirstOnboardingView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        onboardingView = FirstOnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
}

extension FirstOnboardingViewController {
    private func setAddTarget() {
        onboardingView.jumpButton.addTarget(self, action: #selector(jumpButtonDidTap), for: .touchUpInside)
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func jumpButtonDidTap() {
        let nextViewController = FinishOnboardingViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc private func nextButtonDidTap() {
        let nextViewController = SecondOnboardingViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
