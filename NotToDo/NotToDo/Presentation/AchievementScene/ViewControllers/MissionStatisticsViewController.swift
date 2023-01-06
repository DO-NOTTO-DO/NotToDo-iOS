//
//  NotToDoViewController.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class MissionStatisticsViewController: UIViewController {
    let missionList: [MissionList] = MissionList.titles

    enum Section: Int, Hashable {
        case main, empty
    }
    typealias Item = AnyHashable
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    lazy var collectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setUI()
        registerSubViews()
        setLayout()
        setupDataSource()
        reloadData()
    }
    private func setUI() {
        collectionview.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
            $0.bounces = false
            $0.isScrollEnabled = false
        }
    }
    private func registerSubViews() {
        collectionview.register(MissionCollectionViewCell.self, forCellWithReuseIdentifier: MissionCollectionViewCell.reusedId)
        collectionview.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.reuseId)
        collectionview.register(AchievementHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AchievementHeaderView.reuseId)
    }
    private func setLayout() {
        view.addSubviews(collectionview)
        collectionview.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionview, cellProvider: { (_, indexPath, item ) -> UICollectionViewCell? in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .main:
                let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: MissionCollectionViewCell.reusedId, for: indexPath) as! MissionCollectionViewCell
                cell.config(item as! MissionList)
                switch indexPath.row {
                case 0:
                    cell.image.image = UIImage.rank1
                    return cell
                case 1:
                    cell.image.image = UIImage.rank2
                    return cell
                case 2:
                    cell.image.image = UIImage.rank3
                    return cell
                case 3:
                    cell.image.image = UIImage.rank4
                    return cell
                default:
                    cell.image.image = UIImage.rank5
                    return cell
                }
            case .empty:
                let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.reuseId, for: indexPath) as! EmptyCollectionViewCell
                return cell
            }
        })
    }
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        defer {
            dataSource.apply(snapshot, animatingDifferences: false)
        }
        snapshot.appendSections([.empty])
        snapshot.appendItems(Array(0..<1), toSection: .empty)
//                snapshot.appendSections([.main])
//                snapshot.appendItems(missionList,toSection: .main)
        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AchievementHeaderView.reuseId, for: indexPath) as? AchievementHeaderView else {return UICollectionReusableView()}
                header.HeaderTitle(title: "내가 달성한 낫투두의 순위는?")
            return header
            }
        }
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {sectionIndex, _ in
            let section = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            switch section {
            case .main:
                return self.MainSection()
            case .empty:
                return self.EmptySection()
            }
        })
        layout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background")
        return layout
    }
    func MainSection() -> NSCollectionLayoutSection {
        return Layout.compositional_vertical(itemW: .fractionalWidth(1), itemH: .absolute(45), gWidth: .fractionalWidth(1), gHeight: .estimated(800), count: nil)
    }
    func EmptySection() -> NSCollectionLayoutSection {
            return   Layout.compositional_vertical(itemW: .fractionalWidth(1), itemH: .fractionalHeight(1), gWidth: .fractionalWidth(1), gHeight: .absolute(250), count: 1)
    }
}
extension MissionStatisticsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("notToDo VC : \(indexPath)")
    }
}
