//
//  SituationStatisticsViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/10.
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
