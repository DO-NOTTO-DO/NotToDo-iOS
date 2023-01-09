//
//  ThirdOnboardingViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/09.
//

import UIKit

final class ThirdOnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var onboardingView: ThirdOnboardingView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        onboardingView = ThirdOnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
}

extension ThirdOnboardingViewController {
    private func setAddTarget() {
        onboardingView.jumpButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        onboardingView.nextButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        onboardingView.beforeButton.addTarget(self, action: #selector(beforeButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc private func buttonDidTap() {
        let nextViewController = FinishOnboardingViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc private func beforeButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
