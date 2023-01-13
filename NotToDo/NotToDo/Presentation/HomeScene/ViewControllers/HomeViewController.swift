//
//  HomeViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then
import FSCalendar

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var missionList: [DailyMissionResponseDTO] = []
    var banner: BannerResponseDTO?
    var missionId: Int?
    private var clickedDay: String?
    private let todayDateFormatter = DateFormatter()
    private let mothlyDateFormatter = DateFormatter()
    private var currentPage: Date? = Date()
    
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
        requestWeeklyMissoinAPI(startDate: "2023-01-23")
        requestDailyMissionAPI(date: clickedDay ?? "")
    }
}

extension HomeViewController: CheckboxToolTipDelegate {
    func setMissionStatus(status: String, indexPath: IndexPath) {
        missionList[indexPath.row].completionStatus = status
        homeView.homeCollectionView.reloadData()
    }
}

extension HomeViewController: ActionSheetViewDelegate {
    func reloadMissionData() {
        requestWeeklyMissoinAPI(startDate: "2023-01-23")
        requestDailyMissionAPI(date: clickedDay ?? "")
        
    }
}

extension HomeViewController: UICollectionViewDelegate {
    private func setCalendar() {
        homeView.homeCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.refreshControl = refreshControl
            $0.refreshControl?.addTarget(self, action: #selector(handleRefreshControl),
                                          for: .valueChanged)
        }
        
        todayDateFormatter.do {
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "yyyy-MM-dd"
        }
        
        mothlyDateFormatter.do {
            $0.locale = Locale(identifier: "ko_KR")
            $0.dateFormat = "yyyy년 M월"
        }
    }
    
    private func setAddTarget() {
        homeView.addMissionButton.addTarget(self, action: #selector(addMission), for: .touchUpInside)
    }
    
    private func requestBannerAPI() {
        HomeAPI.shared.getBanner { [weak self] result in
            switch result {
            case let .success(data):
                guard let data = data as? BannerResponseDTO else { return }
                self?.banner = data
                self?.homeView.homeCollectionView.reloadData()
            case .requestErr:
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
    
    private func requestDailyMissionAPI(date: String) {
        HomeAPI.shared.getDailyMission(date: date) { [weak self] result in
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
            case .requestErr:
                print("networkFail")
            }
        }
    }
    
    private func requestWeeklyMissoinAPI(startDate: String) {
        HomeAPI.shared.getWeeklyMissoin(startDate: startDate) { result in
            switch result {
            case let .success(data):
                guard data is [WeekMissionResponseDTO] else { return }
                
            case .requestErr:
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
        requestDailyMissionAPI(date: clickedDay ?? "")
        homeView.homeCollectionView.reloadData()
        
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
            cell.calendar.delegate = self
            self.currentPage = cell.calendar.currentPage
            return cell
        default:
            if missionList.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEmptyCollectionViewCell.identifier, for: indexPath) as? HomeEmptyCollectionViewCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMissionCollectionViewCell.identifier, for: indexPath) as? HomeMissionCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(missionList[indexPath.row])
                cell.indexPath = indexPath
                cell.clickedStatusButton = {[weak self] missionId in
                    let checkboxViewController = CheckboxToolTipViewController()
                    checkboxViewController.modalPresentationStyle = .overFullScreen
                    checkboxViewController.modalTransitionStyle = .crossDissolve
                    checkboxViewController.setUpdateLayout(cell.frame.minY - collectionView.contentOffset.y)
                    checkboxViewController.id = missionId
                    checkboxViewController.delegate = self
                    checkboxViewController.indexPath = indexPath
                    self?.present(checkboxViewController, animated: true)
                }
                cell.meatballClickedEvent = {[weak self] missionId in
                    let actionSheetViewController = ActionSheetViewController()
                    actionSheetViewController.modalPresentationStyle = .overFullScreen
                    actionSheetViewController.modalTransitionStyle = .crossDissolve
                    actionSheetViewController.id = missionId
                    actionSheetViewController.delegate = self
                    actionSheetViewController.situation = self?.missionList[indexPath.row].situation ?? ""
                    actionSheetViewController.mission = self?.missionList[indexPath.row].title ?? ""
                    self?.present(actionSheetViewController, animated: true)
                    actionSheetViewController.dismissClicked = {
                        let calendarActionSheetViewController = ActionSheetViewController()
                        calendarActionSheetViewController.mode = .calendar
                        calendarActionSheetViewController.id = missionId
                        calendarActionSheetViewController.modalPresentationStyle = .overFullScreen
                        calendarActionSheetViewController.modalTransitionStyle = .crossDissolve
                        self?.present(calendarActionSheetViewController, animated: true)
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
                return missionList.count 
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
        header.dateLabel.text = mothlyDateFormatter.string(from: self.currentPage ?? Date())
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

extension HomeViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        clickedDay = todayDateFormatter.string(from: date)
        requestDailyMissionAPI(date: clickedDay ?? "")
    }
}
