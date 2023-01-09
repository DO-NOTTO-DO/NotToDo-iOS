//
//  HomeViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var homeView: HomeView!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        homeView = HomeView(frame: CGRect())
        view = homeView
    }
}
