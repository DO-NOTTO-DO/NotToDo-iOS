//
//  NotToDoViewController.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import SnapKit
import Then

class MissionStatisticsView: UIView {
    
    // MARK: - Properties
    
    var missionList: [MissionStatistcsResponse] = []
    
    // MARK: - UI Components
    
    lazy var missionTableView =  UITableView(frame: .zero, style: .grouped)
    let situationTitleView = SituationTitleView()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        register()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension MissionStatisticsView {
    func setUI() {
        if missionList.isEmpty {
            backgroundColor = .clear
            situationTitleView.isHidden = true
            missionTableView.isScrollEnabled = false
        } else {
            backgroundColor = .nottodoWhite
            layer.borderWidth = 0.5
            layer.borderColor = UIColor.nottodoGray2?.cgColor
        }
        
        missionTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.sectionHeaderTopPadding = 0
            $0.sectionFooterHeight = 0
        }
        situationTitleView.do {
            $0.HeaderTitle(title: I18N.missionStatisticsTitle)
        }
    }
    
    func register() {
        missionTableView.register(MissionTableViewCell.self, forCellReuseIdentifier: MissionTableViewCell.identifier)
        missionTableView.register(StatisticsEmptyTableViewCell.self, forCellReuseIdentifier: StatisticsEmptyTableViewCell.identifier)
    }
    
    func setLayout() {
        addSubviews(situationTitleView, missionTableView)
        
        situationTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(30.adjusted)
        }
        missionTableView.snp.makeConstraints {
            $0.top.equalTo(situationTitleView.snp.bottom).offset(-30.adjusted)
            $0.bottom.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
        }
        
    }
}
extension MissionStatisticsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if missionList.isEmpty {
            return 300
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if missionList.isEmpty {
            return 1
        } else {
            return self.missionList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if missionList.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsEmptyTableViewCell.identifier, for: indexPath) as? StatisticsEmptyTableViewCell else {return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath) as? MissionTableViewCell else { return UITableViewCell() }
            let item = missionList[indexPath.row]
            cell.selectionStyle = .none
            cell.configure(item)
            switch indexPath.row {
            case 0:
                cell.missionImage.image = UIImage.rank1
                cell.numberLabel.textColor = .yellow_basic
                return cell
            case 1:
                cell.missionImage.image = UIImage.rank2
                cell.numberLabel.textColor = .yellow_basic
                return cell
            case 2:
                cell.missionImage.image = UIImage.rank3
                cell.numberLabel.textColor = .yellow_basic
                return cell
            case 3:
                cell.missionImage.image = UIImage.rank4
                cell.numberLabel.textColor = .nottodoGray2
                return cell
            default:
                cell.missionImage.image = UIImage.rank5
                cell.numberLabel.textColor = .nottodoGray2
                return cell
            }
        }
    }
}
