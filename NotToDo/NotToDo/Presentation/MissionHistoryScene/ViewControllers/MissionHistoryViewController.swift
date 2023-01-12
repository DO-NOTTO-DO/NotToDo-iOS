//
//  MissionHistoryViewControllers.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/07.
//

import UIKit

final class MissionHistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    var missionHistoryResponse: MissionHistoryResponse?
    var historyList: [MissionHistoryModel] = []
    weak var delegate: MissionHistoryViewDelegate?
    
    // MARK: - UI Components
    
    private var missionHistoryView: MissionHistoryView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setAddTarget()
        requestMissionHistoryAPI()
    }
    
    override func loadView() {
        super.loadView()
        missionHistoryView = MissionHistoryView()
        view = missionHistoryView
    }
}

extension MissionHistoryViewController {
    private func setAddTarget() {
        missionHistoryView.backButton.addTarget(self, action: #selector(popToAddMissionViewController), for: .touchUpInside)
    }
    
    private func requestMissionHistoryAPI() {
        MissionHistoryAPI.shared.getMissionHistory { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            
            guard let data = response.data else { return }
            self?.historyList = data
            self?.missionHistoryView.historyList = data
            self?.missionHistoryView.missionHistoryCollectionView.reloadData()
    
            dump(response)
        }
    }

    @objc private func popToAddMissionViewController() {
        delegate?.sendMissionHistoryData(data: missionHistoryView.inputTextField.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
}
