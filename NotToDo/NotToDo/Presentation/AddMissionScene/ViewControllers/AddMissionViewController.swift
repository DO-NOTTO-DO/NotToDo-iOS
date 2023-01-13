//
//  NotTodoAddViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

final class AddMissionViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var checkButtonEnable: Bool = addMissionView.missionText.text!.count > 0 && behaviorList.count > 0
    && (addMissionView.situationView.AddMissionButton.titleLabel?.text)! != I18N.input && addMissionView.goalTextField.text!.count > 0 {
        didSet {
            addMissionView.availableAddMission(checkButtonEnable)
        }
    }
    var addMissionRequest: AddMissionRequest?
    
    var behavior: String?
    
    // MARK: - UI Components
    
    var addMissionView: AddMissionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setAddTarget()
        resetBehaviorModel()
    }
    
    override func loadView() {
        super.loadView()
        addMissionView = AddMissionView()
        if let behavior = behavior {
            addMissionView.dataBind(behavior: behavior)
        }
        view = addMissionView
    }
}

extension AddMissionViewController {
    private func setAddTarget() {
        let missionHistoryRecognizer = UITapGestureRecognizer(target: self, action: #selector(pushToMissionHistoryViewController))
        
        addMissionView.addBehaviorCollectionView.dataSource = self
        addMissionView.navigationBarView.backButton.addTarget(self, action: #selector(dismissAddMissionViewController), for: .touchUpInside)
        addMissionView.missionTextField.addGestureRecognizer(missionHistoryRecognizer)
        addMissionView.behaviorTitleView.AddMissionButton.addTarget(self, action: #selector(pushToRecommendViewController), for: .touchUpInside)
        addMissionView.situationView.AddMissionButton.addTarget(self, action: #selector(pushToAddSituationViewController), for: .touchUpInside)
        addMissionView.addMissionButton.addTarget(self, action: #selector(dismissAddMissionViewController), for: .touchUpInside)
        addMissionView.goalTextField.addTarget(self, action: #selector(checkEnable), for: .editingChanged)
        addMissionView.situationView.AddMissionButton.addTarget(self, action: #selector(checkEnable), for: .touchUpInside)
        addMissionView.addBehaviorButton.addTarget(self, action: #selector(checkEnable), for: .touchUpInside)
        addMissionView.addMissionButton.addTarget(self, action: #selector(requestAddMissionAPI), for: .touchUpInside)
    }
    
    func resetBehaviorModel() {
        behaviorList.removeAll()
    }
    
    // MARK: - @objc Methods
    
    @objc private func requestAddMissionAPI() {
        print(addMissionView.addMissionButton.titleLabel?.text)
        AddMissionAPI.shared.postAddMission(newMission: AddMissionRequest(title: addMissionView.missionText.text!, situation: (addMissionView.situationView.AddMissionButton.titleLabel?.text)!, actions: behaviorList.map { $0.behavior }, goal: addMissionView.goalTextField.text!, actionDate: "2023.01.25")) { [weak self] request in
            guard self != nil else { return }
            // behaviorList.removeAll()
        } // (addMissionView.dateButton.titleLabel?.text)!
    }
    
    @objc func checkEnable() {
        checkButtonEnable = addMissionView.missionText.text!.count > 0 && behaviorList.count > 0
        && (addMissionView.situationView.AddMissionButton.titleLabel?.text)! != I18N.input && addMissionView.goalTextField.text!.count > 0
    }

    @objc private func dismissAddMissionViewController() {
        // behaviorList.removeAll()
        dismiss(animated: true)
    }
    
    @objc private func pushToRecommendViewController() {
        let recommendViewController = RecommendViewController()
        recommendViewController.navigationBarView = NavigationBarView(frame: CGRect(), mode: .recommend)
        recommendViewController.recommendTextFieldClosure = { [weak self] result in
            self?.behavior = result
            self?.addMissionView.dataBind(behavior: result)
        }
            
        navigationController?.pushViewController(recommendViewController, animated: true)
    }
    
    @objc private func pushToAddSituationViewController() {
        let addSituationViewController = AddSituationViewController()
        addSituationViewController.delegate = self
        addSituationViewController.checkSituationButton = { [weak self] response in
            self?.checkButtonEnable = self?.addMissionView.missionText.text!.count ?? 0 > 0 && behaviorList.count > 0
            && response != I18N.input && self?.addMissionView.goalTextField.text!.count ?? 0 > 0
        }
        self.navigationController?.pushViewController(addSituationViewController, animated: true)
    }
    
    @objc private func pushToMissionHistoryViewController() {
        let missionHistoryViewController = MissionHistoryViewController()
        missionHistoryViewController.delegate = self
        self.navigationController?.pushViewController(missionHistoryViewController, animated: true)
        
        checkButtonEnable = addMissionView.missionText.text!.count > 0 && behaviorList.count > 0
        && (addMissionView.situationView.AddMissionButton.titleLabel?.text)! != I18N.input && addMissionView.goalTextField.text!.count > 0
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
        } else {
            addMissionView.situationView.AddMissionButton.setTitle(I18N.input, for: .normal)
        }
    }
}

extension AddMissionViewController: MissionHistoryViewDelegate {
    func sendMissionHistoryData(data: String) {
        if data != "" {
            print(data)
            addMissionView.missionText.text = data
            addMissionView.missionText.textColor = .nottodoGray1
            addMissionView.missionTextField.layer.borderColor = UIColor.nottodoGray2?.cgColor
        } else {
            addMissionView.missionText.text = I18N.missionPlaceHolder
            addMissionView.missionText.textColor = .nottodoGray3
            addMissionView.missionTextField.layer.borderColor = UIColor.nottodoGray4?.cgColor
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
