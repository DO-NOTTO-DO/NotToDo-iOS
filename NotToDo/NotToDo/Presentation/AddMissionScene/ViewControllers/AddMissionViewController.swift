//
//  NotTodoAddViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

final class AddMissionViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var checkButtonEnable: Bool = addMissionView.missionTextField.text!.count > 0 && behaviorList.count > 0
    && (addMissionView.situationView.AddMissionButton.titleLabel?.text)! != I18N.input && addMissionView.goalTextField.text!.count > 0 {
        didSet {
            addMissionView.availableAddMission(checkButtonEnable)
        }
    }
    
    // MARK: - UI Components
    
    private var addMissionView: AddMissionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setAddTarget()
    }
    
    override func loadView() {
        super.loadView()
        addMissionView = AddMissionView()
        view = addMissionView
    }
}

extension AddMissionViewController {
    private func setAddTarget() {
        addMissionView.addBehaviorCollectionView.dataSource = self
        addMissionView.navigationBarView.backButton.addTarget(self, action: #selector(dismissAddMissionViewController), for: .touchUpInside)
        addMissionView.missionTextField.addTarget(self, action: #selector(pushToMissionHistoryViewController), for: .touchUpInside)
        addMissionView.behaviorTitleView.AddMissionButton.addTarget(self, action: #selector(pushToRecommendViewController), for: .touchUpInside)
        addMissionView.situationView.AddMissionButton.addTarget(self, action: #selector(pushToAddSituationViewController), for: .touchUpInside)
        addMissionView.addMissionButton.addTarget(self, action: #selector(dismissAddMissionViewController), for: .touchUpInside)
        
        addMissionView.missionTextField.addTarget(self, action: #selector(checkEnable), for: .editingChanged)
        addMissionView.goalTextField.addTarget(self, action: #selector(checkEnable), for: .editingChanged)
        addMissionView.situationView.AddMissionButton.addTarget(self, action: #selector(checkEnable), for: .touchUpInside)
        addMissionView.addBehaviorButton.addTarget(self, action: #selector(checkEnable), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc func checkEnable() {
        self.checkButtonEnable = addMissionView.missionTextField.text!.count > 0 && behaviorList.count > 0
        && (addMissionView.situationView.AddMissionButton.titleLabel?.text)! != I18N.input && addMissionView.goalTextField.text!.count > 0
    }

    @objc private func dismissAddMissionViewController() {
        dismiss(animated: true)
    }
    
    @objc private func pushToRecommendViewController() {
        let recommendViewController = RecommendViewController()
        self.navigationController?.pushViewController(recommendViewController, animated: true)
    }
    
    @objc private func pushToAddSituationViewController() {
        let addSituationViewController = AddSituationViewController()
        addSituationViewController.delegate = self
        addSituationViewController.checkSituationButton = { [weak self] response in
            print(response, "ddddddd")
            self?.checkButtonEnable = self?.addMissionView.missionTextField.text!.count ?? 0 > 0 && behaviorList.count > 0
            && response != I18N.input && self?.addMissionView.goalTextField.text!.count ?? 0 > 0
        }
        self.navigationController?.pushViewController(addSituationViewController, animated: true)
    }
    
    @objc private func pushToMissionHistoryViewController() {
        let missionHistoryViewController = MissionHistoryViewController()
        self.navigationController?.pushViewController(missionHistoryViewController, animated: true)
    }
    
    @objc private func dismissToHomeViewController() {
        dismiss(animated: true)
    }
    
    @objc func deleteBehaviorButton(_ sender: UIButton) {
        addMissionView.addBehaviorCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        behaviorList.remove(at: sender.tag)
        
        addMissionView.addBehaviorCollectionView.snp.updateConstraints {
            $0.height.equalTo(CGFloat(behaviorList.count) * 48.adjusted)
        }
        
        if behaviorList.count < 2 {
            addMissionView.unavailableAddBehaviorButton.isHidden = true
            addMissionView.addBehaviorButton.isHidden = false
        }
    }
}

extension AddMissionViewController: AddSituationViewDelegate {
    func sendSituationData(data: String) {
        // pop된 뷰컨에서 넘겨 받은 데이터를 원하는 곳에 넣어주기
        if data != "" {
            addMissionView.situationView.AddMissionButton.setTitle(data, for: .normal)
            addMissionView.situationAvailable = 1
        } else {
            addMissionView.situationView.AddMissionButton.setTitle(I18N.input, for: .normal)
            addMissionView.situationAvailable = 0
        }
    }
}

extension AddMissionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return behaviorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddBehaviorCollectionViewCell.identifier, for: indexPath) as? AddBehaviorCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        print(cell.configure(model: behaviorList[indexPath.row]))
        cell.deleteBehaviorButton.tag = indexPath.row
        cell.deleteBehaviorButton.addTarget(self, action: #selector(deleteBehaviorButton), for: .touchUpInside)
        cell.deleteBehaviorButton.addTarget(self, action: #selector(checkEnable), for: .touchUpInside)
        return cell
    }

}
