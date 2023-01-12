//
//  NestedView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import UIKit

import SnapKit
import Then

class NestedView: UIView {
    
    // MARK: - Properties

    var item: RecommendElementResponse?
    
    enum Section: Int, Hashable {
        case main
    }
    typealias Item = AnyHashable
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    
    // MARK: - UI Components
    
    lazy var collectionview = UICollectionView(frame: self.bounds, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension NestedView {
    func config() {
        setUI()
        register()
        setLayout()
        setupDataSource()
        reloadData()
    }
    
    private func setUI() {
        collectionview.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
            $0.isScrollEnabled = false
            $0.bounces = false
        }
    }
    
    private func register() {
        collectionview.register(NestedCollectionViewCell.self, forCellWithReuseIdentifier: NestedCollectionViewCell.identifier)
        collectionview.register(RecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendHeaderView.reuseId)
    }
    
    private func setLayout() {
        addSubview(collectionview)
        
        collectionview.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Data
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionview, cellProvider: { (_, indexPath, item) -> UICollectionViewCell? in
            guard let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.identifier, for: indexPath) as? NestedCollectionViewCell else { return UICollectionViewCell()}
            let item = item as! RecommendAction
            cell.configure(item)
            switch indexPath.row {
            case 0:
                cell.layer.addBorder([.top, .bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
            default:
                cell.layer.addBorder([.bottom, .left, .right], color: .nottodoGray2!, width: 0.5.adjusted)
            }
            cell.colorView.frame = .init(x: 0, y: 0, width: 11.adjusted, height: 60.adjusted)
            cell.colorView.layer.addBorder([.right], color: .nottodoGray2!, width: 0.5.adjusted)
            return cell
        })
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        defer {
            dataSource.apply(snapShot, animatingDifferences: true)
        }
        snapShot.appendSections([.main])
        guard let item = item else { return }
        snapShot.appendItems(item.recommendActions, toSection: .main)
        
        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendHeaderView.reuseId, for: indexPath) as? RecommendHeaderView else {return UICollectionReusableView()}
            header.titleLabel.text = item.title
            return header
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60.adjusted)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)), subitems: [item])
        group.interItemSpacing = .fixed(20)
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(34))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background")
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 25.adjusted
        layout.configuration = config
        return layout
    }
}
extension NestedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
