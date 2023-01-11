//
//  CustomTabBarView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/06.
//

import UIKit

import SnapKit
import Then

protocol CustomTabBarDelegate: AnyObject {
    func scrollToIndex(to index: Int)
}

class CustomTabBarView: UIView {
    
    // MARK: - Properties

    var defaultIndex: Int = 0
    weak var delegate: CustomTabBarDelegate?
    let titleList: [CustomTabBarItem] = CustomTabBarItem.items
    
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
        setUI()
        register()
        setLayout()
        setupDataSource()
        reloadData()
        collectionview.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CustomTabBarView {
    private func setUI() {
        backgroundColor = .white
        setupCollectioView()
        
        collectionview.do {
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.showsHorizontalScrollIndicator = true
            $0.isScrollEnabled = false
        }
    }
    
    private func register() {
        collectionview.register(CustomTabBarCell.self, forCellWithReuseIdentifier: CustomTabBarCell.identifier)
    }
    
    private func setLayout() {
        addSubviews(collectionview)
        
        collectionview.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.top.equalToSuperview()
        }
    }
    
    private func setupCollectioView() {
        let indexPath = IndexPath(item: 0, section: 0)
        collectionview.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
    // MARK: - Data
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionview, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabBarCell.identifier, for: indexPath) as? CustomTabBarCell else { return UICollectionViewCell()}
            cell.config(item as! CustomTabBarItem, isSelected: indexPath.item == self.defaultIndex)
            return cell
        })
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        defer {
            dataSource.apply(snapShot, animatingDifferences: true)
        }
        snapShot.appendSections([.main])
        snapShot.appendItems(titleList, toSection: .main)
    }
    
    // MARK: - Layout
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(69), heightDimension: .absolute(82)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(642), heightDimension: .absolute(104)), subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
extension CustomTabBarView: UICollectionViewDelegate {
    // 셀을 클릭했을 때, 콘텐츠 뷰를 해당 index로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defaultIndex = indexPath.item
        delegate?.scrollToIndex(to: indexPath.item)
        collectionview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
}
