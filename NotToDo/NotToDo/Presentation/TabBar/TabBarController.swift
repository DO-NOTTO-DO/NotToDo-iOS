//
//  TabBarController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
        setTabBarUI()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomTabBar.self)
      }
      
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        object_setClass(self.tabBar, CustomTabBar.self)
      }
}

extension TabBarController {
    
    // MARK: - Methods
    
    private func setTabBarItems() {
        tabs = [
            HomeViewController(),
            RecommendViewController(),
            AchievementViewController(),
            MyInfoViewController()
        ]
        
        TabBarItemType.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.setTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: false)
    }
    
    private func setTabBarUI() {
        UITabBar.clearShadow()
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.nottodoGray2?.cgColor
        tabBar.layer.shadowOpacity = 0.08
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 20.0 / UIScreen.main.scale
        super.tabBar.sizeToFit()
        let selectedfontAttributes = [
            NSAttributedString.Key.font: UIFont.PretendardBold(size: 14),
            NSAttributedString.Key.foregroundColor: UIColor.nottodoBlack
        ]
        let fontAttributes = [
            NSAttributedString.Key.font: UIFont.PretendardMedium(size: 14),
            NSAttributedString.Key.foregroundColor: UIColor.nottodoGray2
        ]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key: Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedfontAttributes as [NSAttributedString.Key: Any], for: .selected)
    }
}
