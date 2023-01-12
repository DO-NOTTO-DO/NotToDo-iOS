//
//  AddSituationViewController.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

final class AddSituationViewController: UIViewController {
    
    // MARK: - Properties
    
    var checkSituationButton: ((String) -> Void)?
    var addSituationResponse: AddSituationResponse?
    var recommendList: [AddSituationModel] = []
    var recentList: [AddSituationModel] = []
    weak var delegate: AddSituationViewDelegate?
    
    // MARK: - UI Components
    
    private var addSituationView: AddSituationView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setAddTarget()
        requestAddSituationAPI()
    }
    
    override func loadView() {
        super.loadView()
        addSituationView = AddSituationView()
        view = addSituationView
    }
}
 
extension AddSituationViewController {
    private func setAddTarget() {
        addSituationView.navigationBarView.backButton.addTarget(self, action: #selector(popToAddMissionController), for: .touchUpInside)
        addSituationView.navigationBarView.successButton.addTarget(self, action: #selector(popToAddMissionController), for: .touchUpInside)
    }
    
    private func requestAddSituationAPI() {
        AddSituationAPI.shared.getAddSituation { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            
            guard let data = response.data else { return }
            self?.recommendList = data.recommends
            self?.recentList = data.recents
            self?.addSituationView.recommendList = data.recommends
            self?.addSituationView.recentList = data.recents
            self?.addSituationView.addSituationCollectionView.reloadData()
    
            dump(response)
        }
    }
    
    // MARK: - @objc Methods
    
    @objc private func popToAddMissionController() {
        delegate?.sendSituationData(data: addSituationView.getChangedText())
        self.checkSituationButton?(addSituationView.getChangedText())
        self.navigationController?.popViewController(animated: true)
    }
}
