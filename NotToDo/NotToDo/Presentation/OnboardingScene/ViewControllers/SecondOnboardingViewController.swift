//
//  SecondOnboardingViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

final class SecondOnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingView: SecondOnboardingView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        onboardingView = SecondOnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
}

extension SecondOnboardingViewController {
    private func setAddTarget() {
        onboardingView.jumpButton.addTarget(self, action: #selector(jumpButtonDidTap), for: .touchUpInside)
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        onboardingView.beforeButton.addTarget(self, action: #selector(beforeButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func jumpButtonDidTap() {
        let nextViewController = FinishOnboardingViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc private func nextButtonDidTap() {
        let nextViewController = ThirdOnboardingViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc private func beforeButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
