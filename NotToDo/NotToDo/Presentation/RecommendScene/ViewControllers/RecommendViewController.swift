//
//  RecommendViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

class RecommendViewController: UIViewController, CustomTabBarDelegate {
    
    // MARK: - Properties
    
    var navigationBarView = NavigationBarView(frame: CGRect(), mode: .leftRecommend) 
    var itemList: [RecommendElementResponse] = []
    var selectedIndex: Int = 0
    
    enum Section: Int, Hashable {
        case sub, main
    }
    typealias Item = AnyHashable
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    
    var isClickedClosure: ((_ section: Int, _ index: Int) -> Void)?
  
    // MARK: - UI Components
    
    private var underLineView = UIView()
    private var headerView = RecommendHeaderView()
    private lazy var contentsCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: recommendlayout())
    private lazy var customTabBar = CustomTabBarView()
    private lazy var customTabBarCollectionView = CustomTabBarView().collectionview
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    private var nestedView = NestedView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        register()
        setLayout()
        requestRecommendAPI()
    }
}

// MARK: - Methods

extension RecommendViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        navigationBarView.createButton.do {
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        contentsCollectionView.do {
            $0.backgroundColor = .systemGray6
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
        }
        
        underLineView.do {
            $0.backgroundColor = .nottodoGray2
        }
        customTabBar.delegate = self
        
        navigationBarView.backButton.addTarget(self, action: #selector(popToAddMissionController), for: .touchUpInside)
    }
    
    private func register() {
        contentsCollectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: LabelCollectionViewCell.identifier)
        contentsCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
    }
    
    private func setLayout() {
        view.addSubviews(navigationBarView, customTabBar, underLineView, contentsCollectionView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(68.adjusted)
        }
        
        customTabBar.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.height.equalTo(104.adjusted)
        }
        
        underLineView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(customTabBar.snp.bottom)
            $0.height.equalTo(0.5.adjusted)
        }
        contentsCollectionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(underLineView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    // 탭바를 클릭했을 때, 콘텐츠 뷰 이동
    func scrollToIndex(to index: Int) {
        selectedIndex = index
        requestRecommendAPI()
        contentsCollectionView.reloadData()
    }
    
    // MARK: - Network
    
    private func requestRecommendAPI() {
        RecommendAPI.shared.getRecommend(index: selectedIndex + 1) { [weak self] response in
            guard self != nil else { return }
            guard let response = response else { return }
            self?.itemList = response.data!
            self?.setupDataSource()
            self?.reloadData()
            self?.updateData(item: response.data!)
            dump(response)
        }
    }
    
    // MARK: - Data
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: contentsCollectionView, cellProvider: { collectionView, indexPath, _ in
            let section = Section(rawValue: indexPath.section)!
            switch section {
            case .sub:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as! LabelCollectionViewCell
                return cell
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
                cell.item = self.itemList[indexPath.item]
                cell.dataBind(section: indexPath.item)
                cell.isClickedClosure = { [weak self] section, index in
                    self?.pushToAdd(section: section, index: index)
                }
                cell.config()
                return cell
            }
        })
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        defer {
            dataSource.apply(snapShot, animatingDifferences: false)
        }
        snapShot.appendSections([.sub, .main])
        snapShot.appendItems(Array(0..<1), toSection: .sub)
        snapShot.appendItems([], toSection: .main)
    }
    
    private func updateData(item: [RecommendElementResponse]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    // MARK: - Layout
    
    func recommendlayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let section = Section(rawValue: sectionIndex)!
            switch section {
            case .sub:
                return self.subTitleSection()
            case .main:
                return self.mainSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20.adjusted
        layout.configuration = config
        return layout
    }
    
    private func subTitleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(15)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(15)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 14.adjusted, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    private func mainSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func pushToAdd(section: Int, index: Int) {
        let addMissionViewController = AddMissionViewController()
        addMissionViewController.behavior = itemList[section].recommendActions[index].name
        addMissionViewController.addMissionView?.navigationBarView = NavigationBarView(frame: CGRect(), mode: .addSituation)
        let navigationController = UINavigationController(rootViewController: addMissionViewController)
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.isNavigationBarHidden = true
        self.present(navigationController, animated: false)
    }
    
    // MARK: - @objc Methods
    
    @objc func buttonTapped(_ sender: UIButton) {
        let addMissionViewController = AddMissionViewController()
        addMissionViewController.modalPresentationStyle = .fullScreen
        self.present(addMissionViewController, animated: false, completion: nil)
    }
    
    @objc private func popToAddMissionController() {
        self.navigationController?.popViewController(animated: true)
    }
}
