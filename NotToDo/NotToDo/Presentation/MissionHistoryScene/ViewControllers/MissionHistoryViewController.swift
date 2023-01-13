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
    let historyInset: UIEdgeInsets = UIEdgeInsets(top: 15.adjusted, left: 20.adjusted, bottom: 15.adjusted, right: 20.adjusted)
    let cellHeight: CGFloat = 49.adjusted
    
    // MARK: - UI Components
    
    private var missionHistoryView: MissionHistoryView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setAddTarget()
        requestMissionHistoryAPI()
        setDelegate()
    }
    
    override func loadView() {
        super.loadView()
        missionHistoryView = MissionHistoryView()
        view = missionHistoryView
    }
}

extension MissionHistoryViewController {
    private func setDelegate() {
        missionHistoryView.missionHistoryCollectionView.delegate = self
        missionHistoryView.missionHistoryCollectionView.dataSource = self
    }
    
    private func setAddTarget() {
        missionHistoryView.inputTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(popToAddMissionViewController))
        missionHistoryView.backButton.addTarget(self, action: #selector(cancelMissionHistory), for: .touchUpInside)
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
        sendData()
    }
    
    @objc private func cancelMissionHistory() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sendData() {
        delegate?.sendMissionHistoryData(data: missionHistoryView.inputTextField.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
}

extension MissionHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Numbers.width, height: cellHeight)
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return historyInset
    }
}

extension MissionHistoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        missionHistoryView.changedText = historyList[indexPath.row].title
        missionHistoryView.inputTextField.text = historyList[indexPath.row].title
        sendData()
        self.navigationController?.popViewController(animated: true)
    }
}

extension MissionHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MissionHistoryCollectionViewCell.identifier, for: indexPath)
                as? MissionHistoryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(model: historyList[indexPath.row])
        cell.setBorder(indexPath)
        return cell
    }
}
