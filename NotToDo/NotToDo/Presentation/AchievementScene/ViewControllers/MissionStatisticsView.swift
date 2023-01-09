//
//  NotToDoViewController.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class MissionStatisticsView: UIView {
    
    let missionList: [MissionList] = MissionList.titles
    
    // MARK: - ui
    private lazy var missionTableView =  UITableView(frame: .zero, style: .grouped)
    private var emptyView = EmptyView(frame: .zero)
    let situationTitleView = SituationTitleView()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        register()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI() {
        backgroundColor = .nottodoWhite
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.nottodoGray2?.cgColor
        
        missionTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            $0.sectionHeaderTopPadding = 0
            $0.sectionFooterHeight = 0
            emptyView.do {
                if self.missionList.count == 0 {
                    $0.isHidden = false
                } else {
                    $0.isHidden = true
                }
            }
        }
        situationTitleView.do {
            $0.HeaderTitle(title: "내가 달성한 낫투두의 순위는?")
        }
    }
    
    func setLayout() {
        addSubviews(situationTitleView, missionTableView, emptyView)
        
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
        emptyView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    func register() {
        missionTableView.register(MissionTableViewCell.self, forCellReuseIdentifier: MissionTableViewCell.identifier)
    }
}
extension MissionStatisticsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.missionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath) as! MissionTableViewCell
        let item = missionList[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.missionImage.image = UIImage.rank1
            cell.selectionStyle = .none
            cell.config(item)
            return cell
        case 1:
            cell.missionImage.image = UIImage.rank2
            cell.selectionStyle = .none
            cell.config(item)
            return cell
        case 2:
            cell.missionImage.image = UIImage.rank3
            cell.selectionStyle = .none
            cell.config(item)
            return cell
        case 3:
            cell.missionImage.image = UIImage.rank4
            cell.selectionStyle = .none
            cell.config(item)
            return cell
        default:
            cell.missionImage.image = UIImage.rank5
            cell.selectionStyle = .none
            cell.config(item)
            return cell
        }
    }
}
