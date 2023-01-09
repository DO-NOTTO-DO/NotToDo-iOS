//
//  SituationViewController.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import SnapKit
import Then

class SituationStatisticsViewController: UIViewController {
    
    var hiddenSections = Set<Int>()
    let tableViewData = [
        ["야", "호", "3"],
        ["1", "2", "3"],
        ["1", "2"]    ]
    let titleLists: [TitleButton] = TitleButton.titles
    let sectionButton = UIButton()
    
    // MARK: - ui
    private lazy var expangindTableView =  UITableView(frame: .zero, style: .grouped)
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        register()
        setLayout()
    }
    func setUI() {
        self.view.backgroundColor = .white
        expangindTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.sectionHeaderTopPadding = 10
            $0.sectionFooterHeight = 0
          //  $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        }
    }
    
    func setLayout() {
        view.addSubview(expangindTableView)
        expangindTableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.identifier)
        
        expangindTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(40)
        }
    }
    func register() {
        expangindTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
}
extension SituationStatisticsViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        return cell
    }
    
    func config(_ title: TitleButton) {
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
//            self.expangindTableView.insertRows(at: indexPathsForSection(),
//                                      with: .fade)
        } else {
            self.hiddenSections.insert(section)
//            self.expangindTableView.deleteRows(at: indexPathsForSection(),
//                                      with: .fade)
        }
        expangindTableView.reloadData()
    }
}

struct TitleButton {
    let title: String
}
extension TitleButton {
    static var titles: [TitleButton] = [TitleButton(title: "딸기"),
                                     TitleButton(title: "바나나"),
                                     TitleButton(title: "망고")

    ]
}
