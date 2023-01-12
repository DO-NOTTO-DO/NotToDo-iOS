//
//  SituationViewController.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//
import UIKit

import SnapKit
import Then

class SituationStatisticsView: UIView {
    
    // MARK: - Properties
    
    var hiddenSections = Set<Int>()
    var situationList: [SituationStatistcsResponse] = []
    var isSelected: [Bool] = []
    
    // MARK: - UI Components
    
    lazy var expangindTableView =  UITableView(frame: .zero, style: .grouped)
    private let sectionButton = UIButton()
    private let situationTitleView = SituationTitleView()
    
    // MARK: - View Life Cycle
    
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

extension SituationStatisticsView {
    func setUI() {
        if situationList.isEmpty {
            backgroundColor = .clear
            situationTitleView.isHidden = true
            expangindTableView.isScrollEnabled = false
        } else {
            backgroundColor = .nottodoWhite
            layer.borderWidth = 0.5
            layer.borderColor = UIColor.nottodoGray2?.cgColor
        }
        
        expangindTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.sectionHeaderTopPadding = 10.adjusted
            $0.sectionFooterHeight = 0
        }
        situationTitleView.do {
            $0.HeaderTitle(title: I18N.situationStatisticsTitle)
        }
    }
    
    func register() {
        expangindTableView.register(SituationTableViewCell.self, forCellReuseIdentifier: SituationTableViewCell.identifier)
        expangindTableView.register(StatisticsEmptyTableViewCell.self, forCellReuseIdentifier: StatisticsEmptyTableViewCell.identifier)
    }
    
    func setLayout() {
        addSubviews(situationTitleView, expangindTableView)
        expangindTableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.identifier)
        
        situationTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(30.adjusted)
        }
        expangindTableView.snp.makeConstraints {
            $0.top.equalTo(situationTitleView.snp.bottom).offset(5.adjusted)
            $0.bottom.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
        }
    }
}
extension SituationStatisticsView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if situationList.isEmpty {
            return 1
        } else {
            return self.situationList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if situationList.isEmpty {
            return 300
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.hiddenSections.contains(section) {
            return situationList[section].missions.count
        } else if situationList.isEmpty {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if situationList.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsEmptyTableViewCell.identifier, for: indexPath) as? StatisticsEmptyTableViewCell else {return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SituationTableViewCell.identifier, for: indexPath) as? SituationTableViewCell else { return UITableViewCell() }
            switch indexPath.row {
            case 0:
                cell.layer.addBorder([.top, .left, .right, .bottom], color: .nottodoGray2!, width: 0.5)
                cell.backGroundImage.image = UIImage.situation1
            case 1:
                cell.backGroundImage.layer.addBorder([.bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
                cell.backGroundImage.image = UIImage.situation2
            case 2:
                cell.backGroundImage.layer.addBorder([.bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
                cell.backGroundImage.image = UIImage.situation3
            default:
                cell.backGroundImage.layer.addBorder([.bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
            }
            cell.titleLabel.text = (situationList[indexPath.section].missions[indexPath.row].title as! String)
            cell.numberLabel.text = "\(situationList[indexPath.section].missions[indexPath.row].count)회"
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func config(_ title: String) {
        sectionButton.setTitle(title, for: .normal)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if situationList.isEmpty {
            return UIView()
        } else {
            guard let customHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as? TableHeaderView else { return UIView() }
            customHeaderView.headerButton.tag = section
            customHeaderView.headerButton.addTarget(self,
                                                    action: #selector(self.hideSection(sender:)),
                                                    for: .touchUpInside)
            customHeaderView.config(situationList[section].name, situationList[section].count)
            customHeaderView.isClickedClosure = { [weak self] result in
                if result {
                    self?.isSelected[section].toggle()
                    tableView.reloadData()
                }
            }
            customHeaderView.numberLabel.textColor = isSelected[section] ? UIColor.yellow_basic : UIColor.nottodoGray1
            switch section {
            case 0:
                customHeaderView.headerImage.image = isSelected[section] ?  .situationRank1 : .situationRank1off
            case 1:
                customHeaderView.headerImage.image = isSelected[section] ?  .situationRank2 : .situationRank2off
            case 2:
                customHeaderView.headerImage.image = isSelected[section] ?  .situationRank3 : .situationRank3off
            default:
                break
            }
            return customHeaderView
        }
    }
    
    @objc private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.situationList[section].missions.count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            
        } else {
            self.hiddenSections.insert(section)
            
        }
        expangindTableView.reloadData()
    }
}
