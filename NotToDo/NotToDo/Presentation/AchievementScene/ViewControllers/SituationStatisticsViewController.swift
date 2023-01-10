//
//  SituationStatisticsViewController.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import Then
import SnapKit

class Section {
    let title: String
    let options: [String]
    
    init(title: String,
         options: [String]
         ) {
        self.title = title
        self.options = options
    }
}

class SituationStatisticsViewController: UIViewController {

    private let tableView = UITableView()
    private var sections = [Section]()
    var isExpanded = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setViews()
        setConstraints()
        registerSubViews()
        sections = [
            Section(title: "section1", options: [1,2,3].compactMap({ return "Cell \($0)"})),
            Section(title: "section2", options: [1,2,3].compactMap({ return "Cell \($0)"})),
            Section(title: "section3", options: [1,2,3].compactMap({ return "Cell \($0)"})),
            Section(title: "section4", options: [1,2,3].compactMap({ return "Cell \($0)"}))
        ]
    }
    private func registerSubViews(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private func setAttributes(){

    }
    private func setCellState() {
            for _ in 0..<sections.count {
                isExpanded[sections]
            }
        }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.reloadData()
        }
    private func setViews() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    private func setConstraints(){

    }
}
extension SituationStatisticsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text =  sections[indexPath.section].title
        }else{
            cell.textLabel?.text =  sections[indexPath.section].options[indexPath.row - 1]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // let section = sections[section]
        if isExpanded[section] {
            return section.options.count + 1
        }else {
            return 1
        }
//        return isExpanded[section] ? (1 + sections[section].options.count) : 1
       
//        if section.isOpened {
//            return section.options.count + 1
//        }else {
//            return 1
//        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
        isExpanded[indexPath.section] = !isExpanded[indexPath.section]
        tableView.reloadSections([indexPath.section], with: .none)
    }
}
