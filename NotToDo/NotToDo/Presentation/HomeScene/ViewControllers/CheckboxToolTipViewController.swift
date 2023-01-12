//
//  CheckboxToolTipViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/12.
//

import UIKit

import SnapKit
import Then

protocol CheckboxToolTipDelegate: AnyObject {
    func setMissionStatus(status: String, indexPath: IndexPath)
}

final class CheckboxToolTipViewController: UIViewController {
    
    // MARK: - Properties
    
    var id: Int = 0
    weak var delegate: CheckboxToolTipDelegate?
    var indexPath: IndexPath?
    
    // MARK: - UI Components
    
    private let missionStateButtonBackView = UIView()
    private let missionChoiceImageView = UIImageView()
    private let missionSuccessButton = UIButton()
    private let missionAmbiguousButton = UIButton()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        addTapGesture()
        setButtonAction()
    }
}

extension CheckboxToolTipViewController {
    private func setUI() {
        view.backgroundColor = .clear
        missionChoiceImageView.do {
            $0.image = .checkStatusBox
        }
    }
    
    private func setLayout() {
        view.addSubview(missionStateButtonBackView)
        missionStateButtonBackView.addSubviews(missionChoiceImageView, missionSuccessButton, missionAmbiguousButton)
        
        missionChoiceImageView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        missionStateButtonBackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(94.adjusted)
        }
        
        missionSuccessButton.snp.makeConstraints {
            $0.directionalVerticalEdges.leading.equalToSuperview()
            $0.trailing.equalTo(missionStateButtonBackView.snp.centerX)
        }
        
        missionAmbiguousButton.snp.makeConstraints {
            $0.directionalVerticalEdges.trailing.equalToSuperview()
            $0.leading.equalTo(missionStateButtonBackView.snp.centerX)
        }
    }
    
    private func addTapGesture() {
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(backgroundGesture)
    }
    
    private func setButtonAction() {
        missionSuccessButton.addTarget(self, action: #selector(successMission), for: .touchUpInside)
        missionAmbiguousButton.addTarget(self, action: #selector(ambiguousMission), for: .touchUpInside)
    }
    
    private func requestPatchUpdateMissionAPI(id: Int, status: String) {
        HomeAPI.shared.patchUpdateMissionStatus(id: id, status: status) { [weak self] result in
            guard let self = self else { return }
            guard let response = result else { return }
            
        }
    }
    
    @objc private func successMission(_ sender: UIButton) {
        requestPatchUpdateMissionAPI(id: self.id, status: "FINISH")
        guard let indexPath = indexPath else { return }
        delegate?.setMissionStatus(status: "FINISH", indexPath: indexPath)
        self.dismiss(animated: true)
    }
    
    @objc private func ambiguousMission(_ sender: UIButton) {
        requestPatchUpdateMissionAPI(id: self.id, status: "AMBIGUOUS")
        guard let indexPath = indexPath else { return }
        delegate?.setMissionStatus(status: "AMBIGUOUS", indexPath: indexPath)
        self.dismiss(animated: true)
    }
    
    @objc private func dismissViewController() {
        self.dismiss(animated: true)
    }
    
    func setUpdateLayout(_ cellTop: CGFloat) {
        view.addSubview(missionStateButtonBackView)
        missionStateButtonBackView.snp.remakeConstraints {
            $0.leading.equalToSuperview().inset(4.adjusted)
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(94.adjusted)
            $0.top.equalToSuperview().offset(cellTop.adjusted)
        }
    }
}
