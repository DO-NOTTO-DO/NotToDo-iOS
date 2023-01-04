//
//  MissionView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import Then
import SnapKit

// MARK: - AddMissionView

class AddMissionView: UIView {

    // MARK: - UI Components
    
    private var navigationBarView = NavigationBarView(frame: CGRect(), mode: .plain)
    private lazy var addMissionTableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Variables
    
//    var missionList: [MissionModel] = [
//        MissionModel(textField: "ex) 유튜브 2시간 이상 보지 않기"),
//        MissionModel(textField: "ex) 책 1권 완독하기")
//    ]
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
        setUI()
        setLayout()
        register()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension AddMissionView {
    
    // MARK: - UI Helpers
    
    private func setUI() {
        addMissionTableView.do {
            $0.backgroundColor = .nottodoWhite
            $0.separatorStyle = .none
            $0.rowHeight = UITableView.automaticDimension
        }
    }
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        [navigationBarView, addMissionTableView].forEach {
            addSubview($0)
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(68)
        }
        
        addMissionTableView.snp.makeConstraints {
            $0.top.equalTo(self.navigationBarView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setTableView() {
        addMissionTableView.delegate = self
        addMissionTableView.dataSource = self
    }
    
    private func register() {
        addMissionTableView.register(AddMissionTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "AddMissionTableHeaderView")
        addMissionTableView.register(MissionTableViewCell.self,
                                     forCellReuseIdentifier: MissionTableViewCell.identifier)
        addMissionTableView.register(BehaviorTableViewCell.self,
                                     forCellReuseIdentifier: BehaviorTableViewCell.identifier)
        addMissionTableView.register(DateTableViewCell.self,
                                     forCellReuseIdentifier: DateTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension AddMissionView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath)
                    as? MissionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setPlaceholder("ex) 유튜브 2시간 이상 보지 않기")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BehaviorTableViewCell.identifier, for: indexPath)
                    as? BehaviorTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath)
                    as? MissionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setPlaceholder("ex) 책 1권 완독하기")
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath)
                    as? DateTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddMissionTableHeaderView") as? AddMissionTableHeaderView else { return UITableViewHeaderFooterView() }
            headerView.HeaderTitle(title: "하지 않을 일을 적어주세요")
            return headerView
        case 1:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddMissionTableHeaderView") as? AddMissionTableHeaderView else { return
                UITableViewHeaderFooterView() }
            headerView.HeaderTitle(title: "구체적인 실천 행동은 무엇인가요?")
            headerView.ButtonWithIcon(title: "추천받기", icon: .rightArrow)
            return headerView
        case 2:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddMissionTableHeaderView") as? AddMissionTableHeaderView else { return UITableViewHeaderFooterView() }
            headerView.HeaderTitle(title: "어떤 상황인가요?")
            headerView.ButtonWithIcon(title: "입력하기", icon: .rightArrow)
            return headerView
        case 3:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddMissionTableHeaderView") as? AddMissionTableHeaderView else { return UITableViewHeaderFooterView() }
            headerView.HeaderTitle(title: "이루고자 하는 목표는 무엇인가요?")
            return headerView
        default:
            return UIView()
        }
    }
}

// MARK: - UITableViewDelegate

extension AddMissionView: UITableViewDelegate {
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 35.adjusted
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 19.adjusted
        case 4:
            return 0
        default:
            return 30.adjusted
        }
    }
}

