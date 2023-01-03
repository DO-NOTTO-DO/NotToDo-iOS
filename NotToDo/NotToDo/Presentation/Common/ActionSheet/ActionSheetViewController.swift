//
//  ActionSheetViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

class ActionSheetViewController: UIViewController {
    
    // MARK: - UI Components

    private var actionSheetView = ActionSheetView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showActionSheetWithAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first,
           touch.view != actionSheetView {
            dismissActionSheetWithAnimation()
        }
    }
}

extension ActionSheetViewController {
    private func setUI() {
        view.backgroundColor = .nottodoBlack?.withAlphaComponent(0.7)
    }
    
    private func setLayout() {
        view.addSubviews(actionSheetView)
        
        actionSheetView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Numbers.height)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func showActionSheetWithAnimation() {
        let actionSheetViewHeight = Numbers.height * 0.36.adjusted
        self.actionSheetView.snp.updateConstraints {
            $0.top.equalToSuperview().inset(actionSheetViewHeight)
        }
        UIView.animate(withDuration: 0.3) {
            self.actionSheetView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.backgroundColor = .nottodoBlack?.withAlphaComponent(0.7)
            self.view.layoutIfNeeded()
        }
    }
    
    private func dismissActionSheetWithAnimation() {
        self.actionSheetView.snp.updateConstraints {
            $0.top.equalToSuperview().inset(Numbers.height)
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) {
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }

}
