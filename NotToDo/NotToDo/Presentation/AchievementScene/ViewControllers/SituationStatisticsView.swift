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
    
    var hiddenSections = Set<Int>()
    let tableViewData = [
        ["야", "호", "3"],
        ["1", "2", "3"],
        ["1", "2"]    ]
    
    let titleLists: [TitleButtonList] = TitleButtonList.titles
    
    // MARK: - ui
    
    private lazy var expangindTableView =  UITableView(frame: .zero, style: .grouped)
    private var emptyView = EmptyView(frame: .zero)
    let sectionButton = UIButton()
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

        expangindTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.sectionHeaderTopPadding = 10
            $0.sectionFooterHeight = 0
            emptyView.do {
                if self.tableViewData.count == 0 {
                    $0.isHidden = false
                } else {
                    $0.isHidden = true
                }
            }
        }
        situationTitleView.do {
            $0.HeaderTitle(title: "언제 낫투두를 가장 많이 시도했을까요?")
        }
    }
    
    func setLayout() {
        addSubviews(situationTitleView, expangindTableView, emptyView)
        expangindTableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.identifier)
        
        situationTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(30.adjusted)
        }
        expangindTableView.snp.makeConstraints {
            $0.top.equalTo(situationTitleView.snp.bottom).offset(20.adjusted)
            $0.bottom.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(40.adjusted)
        }
        emptyView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    func register() {
        expangindTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
}
extension SituationStatisticsView: UITableViewDataSource, UITableViewDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
   
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            
            return self.tableViewData[section].count
        }
         return 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath)
         switch indexPath.row {
         case 0:
             cell.layer.addBorder([.top, .left, .right, .bottom], color: .nottodoGray2!, width: 0.5)
         default:
             cell.layer.addBorder([.bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
         }
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
     func config(_ title: TitleButtonList) {
        sectionButton.setTitle(title.title, for: .normal)
    }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let customHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as? TableHeaderView else { return UIView() }
        customHeaderView.headerButton.tag = section
        customHeaderView.headerButton.addTarget(self,
                                       action: #selector(self.hideSection(sender:)),
                                       for: .touchUpInside)
        customHeaderView.config(titleLists[section])
         switch section {
         case 0:
             customHeaderView.headerButton.setImage(.situation_Rank1_off, for: .normal)
             customHeaderView.headerButton.setImage(.situation_Rank1, for: .selected)
         case 1:
             customHeaderView.headerButton.setImage(.situation_Rank2_off, for: .normal)
             customHeaderView.headerButton.setImage(.situation_Rank2, for: .selected)
         case 2:
             customHeaderView.headerButton.setImage(.situation_Rank3_off, for: .normal)
             customHeaderView.headerButton.setImage(.situation_Rank3, for: .selected)
         default:
             break
         }
         return customHeaderView
    }
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()

            for row in 0..<self.tableViewData[section].count {
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
