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
    
    var missionList: [DailyMissionResponseDTO] = []
    var banner: BannerResponse?
    
    // MARK: - UI Components
    
    private var homeView: HomeView!
    private(set) lazy var refreshControl = UIRefreshControl()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        homeView = HomeView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setCalendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestBannerAPI()
        requestDailyMissionDTO(date: "2023-01-24")
    }
    
}

extension HomeViewController {
    private func setCalendar() {
        homeView.homeCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.refreshControl = refreshControl
            $0.refreshControl?.addTarget(self, action: #selector(handleRefreshControl),
                                          for: .valueChanged)
        }
    }
    
    private func setAddTarget() {
        homeView.addMissionButton.addTarget(self, action: #selector(addMission), for: .touchUpInside)
    }
    
    private func requestBannerAPI() {
        HomeAPI.shared.getBanner { [weak self] result in
            switch result {
            case let .success(data):
                guard let data = data as? BannerResponse else { return }
                self?.banner = data
                self?.homeView.homeCollectionView.reloadData()
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    private func requestDailyMissionDTO(date: String) {
        HomeAPI.shared.getDailyMission(date: "2023-01-24") { [weak self] result in
            switch result {
            case let .success(data):
                guard let data = data as? [DailyMissionResponseDTO] else { return }
                self?.missionList = data
                self?.homeView.homeCollectionView.reloadData()
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .requestErr(_):
                print("networkFail")
            }
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
    
    @objc func handleRefreshControl() {
        // 컨텐츠를 업데이트하세요.
        requestBannerAPI()
        requestDailyMissionDTO(date: "2023-01-24")
        homeView.homeCollectionView.reloadData()
        
        // Refresh control을 제거하세요.
        DispatchQueue.main.async {
            self.homeView.homeCollectionView.refreshControl?.endRefreshing()
        }
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
                cell.clickedStatusButton = {[weak self] in
                    let checkboxViewController = CheckboxToolTipViewController()
                    checkboxViewController.modalPresentationStyle = .overFullScreen
                    checkboxViewController.modalTransitionStyle = .crossDissolve
                    checkboxViewController.setUpdateLayout(cell.frame.minY - collectionView.contentOffset.y)
                    self?.present(checkboxViewController, animated: true)
                }
                cell.meatballClickedEvent = { result in
                    if result {
                        let actionSheetViewController = ActionSheetViewController()
                        actionSheetViewController.modalPresentationStyle = .overFullScreen
                        actionSheetViewController.modalTransitionStyle = .crossDissolve
                        self.present(actionSheetViewController, animated: true)
                        actionSheetViewController.dismissClicked = {
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
            if missionList.isEmpty {
                return 1
            } else {
                return missionList.count ?? 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeCollectionReusableView.identifier,
                for: indexPath
              ) as? HomeCollectionReusableView else { return UICollectionReusableView() }
        if let banner = banner {
            header.setRandomData(banner: banner)
        }
        
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
        var cellHeight = 144.adjusted
        if !missionList.isEmpty {
            cellHeight = missionList[indexPath.row].actions.count < 2 ? 144.adjusted : 183.adjusted
        }
        switch indexPath.section {
        case 0:
            return CGSize(width: Numbers.width, height: 106.adjusted)
        default:
            if missionList.count == 0 {
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
