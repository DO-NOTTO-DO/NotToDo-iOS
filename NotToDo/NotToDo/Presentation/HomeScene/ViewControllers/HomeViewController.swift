//
//  HomeViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    var missionList: [DailyMission] = DailyMission.DailyMissionModel
    
    // MARK: - UI Components
    
    private var homeView: HomeView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        homeView = HomeView(frame: CGRect(), motivationText: "초기화 값입니다.")
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setDelegate()
        requestBannerAPI()
    }
}

extension HomeViewController {
    private func setDelegate() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
    }
    
    private func setAddTarget() {
        homeView.addMissionButton.addTarget(self, action: #selector(addMission), for: .touchUpInside)
    }
    
    private func requestBannerAPI() {
        HomeAPI.shared.getBanner { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            
            dump(response)
        }
    }
    
    // MARK: - @objc Methods
    
    @objc private func addMission() {
        let addMissionViewController = AddMissionViewController()
        let navigationController = UINavigationController(rootViewController: addMissionViewController)
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.isNavigationBarHidden = true
        present(navigationController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCalendarCollectionViewCell.identifier, for: indexPath) as? HomeCalendarCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default:
            if missionList.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEmptyCollectionViewCell.identifier, for: indexPath) as? HomeEmptyCollectionViewCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMissionCollectionViewCell.identifier, for: indexPath) as? HomeMissionCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(missionList[indexPath.row])
                cell.meatballClickedEvent = { result in
                    if result {
                        let actionSheetViewController = ActionSheetViewController()
                        actionSheetViewController.modalPresentationStyle = .overFullScreen
                        actionSheetViewController.modalTransitionStyle = .crossDissolve
                        self.present(actionSheetViewController, animated: true)
                        actionSheetViewController.dismissClicked = {
                            // action sheet
                            let calendarActionSheetViewController = ActionSheetViewController()
                            calendarActionSheetViewController.mode = .calendar
                            calendarActionSheetViewController.modalPresentationStyle = .overFullScreen
                            calendarActionSheetViewController.modalTransitionStyle = .crossDissolve
                            self.present(calendarActionSheetViewController, animated: true)
                        }
                    }
                }
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return missionList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeCollectionReusableView.identifier,
                for: indexPath
              ) as? HomeCollectionReusableView else { return UICollectionReusableView() }
        header.setRandomData()
        return header
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: Numbers.width, height: 183.adjusted)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = missionList[indexPath.row].actions.count < 2 ? 144.adjusted : 183.adjusted
        switch indexPath.section {
        case 0:
            return CGSize(width: Numbers.width, height: 106.adjusted)
        default:
            if missionList.isEmpty {
                return CGSize(width: Numbers.width, height: (collectionView.frame.height - 105).adjusted)            // 수정 필요
            } else {
                return CGSize(width: Numbers.width, height: cellHeight)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets()
        default:
            return UIEdgeInsets(top: 7.adjusted, left: 0, bottom: 17.adjusted, right: 0)
        }
    }
}
