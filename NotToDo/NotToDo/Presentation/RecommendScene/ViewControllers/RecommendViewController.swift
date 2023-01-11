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
    
    var navigationBarView = NavigationBarView(frame: CGRect(), mode: .recommend) // .leftRecommend
    var itemList: [SortedItemModel] = SortedItemModel.sampleData
    enum Section: Int, Hashable {
        case sub, main
    }
    typealias Item = AnyHashable
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    
    // MARK: - UI Components
    
    private var underLineView = UIView()
    private var headerView = RecommendHeaderView()
    private lazy var contentsCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: recommendlayout())
    private lazy var customTabBar = CustomTabBarView()
    private lazy var customTabBarCollectionView = CustomTabBarView().collectionview
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        register()
        setLayout()
        setupDataSource()
        reloadData()
    }
}

// MARK: - Methods

extension RecommendViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        navigationBarView.createButton.do {
            $0.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
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
            $0.top.equalTo(navigationBarView.snp.bottom).offset(19.adjusted)
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
        fetchCategoryItems(index) { [weak self] itemList in
            self?.itemList = itemList
            self?.contentsCollectionView.reloadData()
        }
    }
    
    // MARK: - Network
    
    private func fetchCategoryItems(_ index: Int, completion: @escaping ([SortedItemModel]) -> ()) {
        // FIXME : - 나중에 인덱스별로 서버에서 데이터를 들고 와야 함.
        
        // 아래 코드는 서버 없이 임의로 작성한 예시
        switch index {
        case 0: completion(SortedItemModel.sampleData)
        case 1: completion(SortedItemModel.sampleData1)
        case 2: completion(SortedItemModel.sampleData2)
        case 3: completion(SortedItemModel.sampleData3)
        case 4: completion(SortedItemModel.sampleData4)
        default: completion(SortedItemModel.sampleData)
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
        snapShot.appendItems(itemList, toSection: .main)
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
    
    // MARK: - @objc Methods
    
    @objc func btnTapped(_ sender: UIButton) {
        print("tapped")
    }
}
