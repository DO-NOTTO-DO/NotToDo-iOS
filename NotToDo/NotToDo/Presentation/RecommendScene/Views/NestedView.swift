//
//  NestedView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

class NestedView: UIView {
    let itemList: [SortedItemModel] = SortedItemModel.sampleData
    var item : SortedItemModel?

    //data
    enum Section: Int,Hashable {
        case main
    }
    typealias Item = AnyHashable
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
        collectionview.isScrollEnabled = false
        collectionview.bounces = false
        collectionview.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    private func setupDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionview, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.reusedId, for: indexPath) as? NestedCollectionViewCell else { return UICollectionViewCell()}
                let item = item as! ItemModel
                cell.config(item)
                print(item)
                return cell
        })
    }
    private func reloadData() {
        //data
        var snapShot = NSDiffableDataSourceSnapshot<Section,Item>()
        defer{
            dataSource.apply(snapShot,animatingDifferences: true)
        }
        snapShot.appendSections([.main])
        guard let item = item else { return }
        snapShot.appendItems(item.itemsList,toSection: .main)
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendHeaderView.reuseId, for: indexPath) as? RecommendHeaderView else {return UICollectionReusableView()}
                header.titleLabel.text = item.title
                return header
            }
        }
    
    private func layout() -> UICollectionViewCompositionalLayout{
        //layout
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60.adjusted)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.estimated(300)), subitems: [item])
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

