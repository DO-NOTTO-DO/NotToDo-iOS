//
//  RecommendViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class RecommendViewController: UIViewController , CustomTabBarDelegate{

    var itemList: [SortedItemModel] = SortedItemModel.sampleData

    enum Section : Int , Hashable{
        case sub,main
    }
    typealias Item = AnyHashable
    var dataSource : UICollectionViewDiffableDataSource<Section,Item>! = nil
    private lazy var pageCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: recommendlayout()).then {
        $0.backgroundColor = .systemGray6
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        }
    //TabBar CollectionView
    var customTabBar = CustomTabBarView()
    var customTabBarCollectionView = CustomTabBarView().collectionview
    private lazy var safeArea = self.view.safeAreaLayoutGuide

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setViews()
        setupCustomTabBar()
        setupPageCollectionView()
        registerSubViews()
        setupDataSource() // presentation
        reloadData()

    }
    // MARK: setView
    private func setViews(){
        view.addSubviews(customTabBar,pageCollectionView)
    }
    private func setupCustomTabBar(){
        //탭바에서 탭을 클릭했을 때, 콘텐츠 뷰 이동의 이벤트를 전달하기 위한 선언
        customTabBar.delegate = self
        customTabBar.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(safeArea).offset(50)
            $0.height.equalTo(104)
        }
    }
    // 탭바를 클릭했을 때, 콘텐츠 뷰 이동
    func scrollToIndex(to index: Int) {
            let indexPath = IndexPath(row: 0, section: 0)
        print(indexPath.item)
            self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        reloadData()
        print(reloadData())
    }
    private func registerSubViews(){
        pageCollectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: LabelCollectionViewCell.reuseId)
        pageCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.reusedId)
    }
    private func setupPageCollectionView(){
        pageCollectionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(customTabBar.snp.bottom)
            $0.bottom.equalTo(safeArea)
        }
    }
    // MARK: data
    private func setupDataSource(){
        //presentation
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: pageCollectionView, cellProvider: { collectionView, indexPath, item in
            let section = Section(rawValue: indexPath.section)!
            switch section {
            case .sub:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.reuseId, for: indexPath) as! LabelCollectionViewCell
                return cell
                
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.reusedId, for: indexPath) as! RecommendCollectionViewCell
                cell.item = self.itemList[indexPath.item]
                cell.config()
                return cell
            }
        })
    }
    private func reloadData(){
        //data
        var snapShot = NSDiffableDataSourceSnapshot<Section,Item>()
              defer{
                  dataSource.apply(snapShot,animatingDifferences: false)
              }
        snapShot.appendSections([.sub,.main])
        snapShot.appendItems(Array(0..<1),toSection: .sub)
        snapShot.appendItems(itemList,toSection: .main)
    }
    // MARK: layout
    func recommendlayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            let section = Section(rawValue: sectionIndex)!
            switch section {
            case .sub :
                return self.subTitleSection()
            case .main :
                return self.mainSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
        }
    private func subTitleSection() -> NSCollectionLayoutSection {
        //item
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(15)))
        //group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:   .estimated(15)), subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0)
            return section
        }
    private func mainSection() -> NSCollectionLayoutSection{
        //item
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
        //group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:   .estimated(200)), subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

