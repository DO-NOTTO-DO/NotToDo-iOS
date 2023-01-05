//
//  MyInfoViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class MyInfoViewController: UIViewController {
    
    // MARK: - UI Components
    
    var myInfoView: MyInfoView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        myInfoView = MyInfoView(frame: self.view.frame)
        view = myInfoView
    }
}
