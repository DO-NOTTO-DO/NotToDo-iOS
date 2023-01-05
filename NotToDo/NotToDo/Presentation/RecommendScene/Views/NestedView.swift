//
//  NestedView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

class NestedView: UIView {
    let itemList: [SortedItemModel] = SortedItemModel.sampleData
  //  var itemArray : Array(SortedItemModel) = []
    struct CategorizedList: Hashable {
        let itemArray: SortedItemModel
        let category: Section
    }

    //data
    enum Section: Int,Hashable {
        case main, main2
    }
    typealias Item = CategorizedList
     var dataSource: UICollectionViewDiffableDataSource<Section,Item>! = nil
     lazy var collectionview = UICollectionView(frame: self.bounds, collectionViewLayout: layout()).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        setViews()
        setupCustomTabBar()
        registerSubViews()
        setupCollectioView()
        setupDataSource()
        reloadData()
    }
    
    private func setViews(){
        self.addSubview(collectionview)
    }
    private func registerSubViews(){
        collectionview.register(NestedCollectionViewCell.self, forCellWithReuseIdentifier: NestedCollectionViewCell.reusedId)
        collectionview.register(RecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendHeaderView.reuseId)
    }
    private func setupCollectioView(){
      //  초기 tapBar selectedItem 설정
    }
    private func setupCustomTabBar(){
        collectionview.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    private func setupDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionview, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = Section(rawValue: indexPath.section)!
            switch section{
            case .main:
                let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.reusedId, for: indexPath) as! NestedCollectionViewCell
                let item = item as! ItemModel
                cell.config(item)
                print(item)
                return cell
            case .main2 :
                let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.reusedId, for: indexPath) as! NestedCollectionViewCell
                let item = item as! ItemModel
                cell.config(item)
                print(item)
                return cell
            }
        })
    }
    private func reloadData() {
        //data
        var snapShot = NSDiffableDataSourceSnapshot<Section,Item>()
        defer{
            dataSource.apply(snapShot,animatingDifferences: true)
        }
        snapShot.appendSections([.main,.main2])
        let list = itemList[0]
        let list1 = itemList[1]
        print("list : \(list)")
        print("list 1: \(list1)")

        
//        snapShot.appendItems(,toSection: .main)
//        snapShot.appendItems(itemList[1],toSection: .main2)

//        snapShot.appendItems(Array(0..<4),toSection: .main2)
        snapShot.appendItems([Item(itemArray: list.itemsList.hashValue., category: .main)])
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendHeaderView.reuseId, for: indexPath) as? RecommendHeaderView else {return UICollectionReusableView()}
            if (indexPath.section == 0) {
                header.HeaderTitle(title: "유튜브 보지 않기")
            }else if (indexPath.section == 1){
                header.HeaderTitle(title: "인스타그램 스토리 보지않기")
            }
                return header
            }
        }
    
    
    
    private func layout() -> UICollectionViewCompositionalLayout{
        //layout
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(60)), subitems: [item])
         group.interItemSpacing = .fixed(20)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(34))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background")
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 25
        layout.configuration = config
        return layout
    }
    
}
extension NestedView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

