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
    private var shapeLayer: CALayer?
    
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

// MARK: - Methods

extension TabBarController {
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
        addShape()

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
    
    private func createPath() -> CGPath {
        let height: CGFloat = UIScreen.main.bounds.height
        let dy: CGFloat = 11
        let width: CGFloat = UIScreen.main.bounds.width
        let dx: CGFloat = 14
        let path = UIBezierPath()
  
        path.move(to: CGPoint(x: dx, y: 0))
        path.addLine(to: CGPoint(x: width - dx, y: 0))
        path.addLine(to: CGPoint(x: width, y: dy))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: dy))
        path.close()
        return path.cgPath
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.nottodoGray2?.cgColor
        shapeLayer.shadowOpacity = 0.08
        
        if let oldShapeLayer = self.shapeLayer {
            self.tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
}
