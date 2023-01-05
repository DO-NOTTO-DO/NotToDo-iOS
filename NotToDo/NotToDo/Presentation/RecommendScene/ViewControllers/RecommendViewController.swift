//
//  RecommendViewController.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

import SnapKit
import Then

final class RecommendViewController: UIViewController {
}
//    var itemList: [SortedItemModel] = SortedItemModel.sampleData
//
//    enum Section : Int , Hashable{
//        case main
//    }
//    typealias Item = AnyHashable
//    var dataSource : UICollectionViewDiffableDataSource<Section,Item>! = nil
//    private lazy var pageCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout()).then {
//        $0.backgroundColor = .systemGray6
//        $0.showsHorizontalScrollIndicator = false
//        $0.isPagingEnabled = true
//        }
//    //TabBar CollectionView
//    var customTabBar = CustomTabBarView()
//    var customTabBarCollectionView = CustomTabBarView().collectionview
//    private lazy var safeArea = self.view.safeAreaLayoutGuide
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .white
//        setViews()
//        setupCustomTabBar()
//        setupPageCollectionView()
//        registerSubViews()
//        setupDataSource() // presentation
//        reloadData()
//
//    }
//    // MARK: setView
//    private func setViews(){
//        view.addSubviews(customTabBar,pageCollectionView)
//    }
//    private func setupCustomTabBar(){
//        //탭바에서 탭을 클릭했을 때, 콘텐츠 뷰 이동의 이벤트를 전달하기 위한 선언
//        customTabBar.delegate = self
//        customTabBar.snp.makeConstraints {
//            $0.directionalHorizontalEdges.equalToSuperview()
//            $0.top.equalTo(safeArea).offset(50)
//            $0.height.equalTo(104)
//        }
//    }
//    // 탭바를 클릭했을 때, 콘텐츠 뷰 이동
//    func scrollToIndex(to index: Int) {
//            let indexPath = IndexPath(row: index, section: 0)
//        print(indexPath.item)
//            self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
//    private func registerSubViews(){
//        pageCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.reusedId)
//        pageCollectionView.isScrollEnabled = false
//    }
//    private func setupPageCollectionView(){
//        pageCollectionView.snp.makeConstraints {
//            $0.directionalHorizontalEdges.equalToSuperview()
//            $0.top.equalTo(customTabBar.snp.bottom)
//            $0.bottom.equalTo(safeArea)
//        }
//    }
//    // MARK: data
//    private func setupDataSource(){
//        //presentation
//        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: pageCollectionView, cellProvider: { collectionView, indexPath, item in
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.reusedId, for: indexPath) as? RecommendCollectionViewCell else {return UICollectionViewCell()}
//            cell.item = self.itemList[indexPath.item]
//            cell.config()
//            return cell
//        })
//    }
//    private func reloadData(){
//        //data
//        var snapShot = NSDiffableDataSourceSnapshot<Section,Item>()
//              defer{
//                  dataSource.apply(snapShot,animatingDifferences: false)
//              }
//            snapShot.appendSections([.main])
//        snapShot.appendItems(itemList,toSection: .main)
//    }
//    // MARK: layout
//    private func createLayout() -> UICollectionViewCompositionalLayout{
//        //item
//        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//        //group
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
//        //section
//        let section = NSCollectionLayoutSection(group: group)
//        //page scroll
//        section.visibleItemsInvalidationHandler = { [self] (items, offset, env) in
//            let index = Int((offset.x / env.container.contentSize.width).rounded(.up))
//            let indexPath = IndexPath(item: index, section: 0)
//            print(indexPath)
//            self.customTabBar.collectionview.selectItem(at: indexPath, animated: true, scrollPosition: [])
//                }
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.scrollDirection = .horizontal
//        layout.configuration = config
//        return layout
//    }
//}
//
