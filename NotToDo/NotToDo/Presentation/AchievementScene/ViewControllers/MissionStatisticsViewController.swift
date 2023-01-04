//
//  NotToDoViewController.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class MissionStatisticsViewController: UIViewController {
        let missionList : [MissionList] = MissionList.titles
        //data
        enum Section : Int,Hashable {
            case main, empty
        }
        typealias Item = AnyHashable
        var dataSource : UICollectionViewDiffableDataSource<Section,Item>! = nil
        lazy var collectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout()).then {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
        }
        lazy var subLabel = customLabel(color: .black).then {
            $0.text = "✅ 내가 달성한 낫투두의 순위는?"
        }
           override func viewDidLoad() {
            super.viewDidLoad()
               setViews()
               registerSubViews()
               setConstraints()
               setupDataSource()
               reloadData()
        }
        private func setViews(){
            self.view.addSubview(subLabel)
            self.view.addSubview(collectionview)
        }
        private func registerSubViews(){
            collectionview.register(MissionCollectionViewCell.self, forCellWithReuseIdentifier: MissionCollectionViewCell.reusedId)
            collectionview.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.reuseId)
            
        }
        private func setConstraints(){
            subLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(25)
                $0.leading.equalToSuperview().inset(40)
            }
            collectionview.snp.makeConstraints {
                $0.directionalHorizontalEdges.equalToSuperview()
                $0.top.equalTo(subLabel.snp.bottom).offset(9)
                $0.bottom.equalToSuperview()
            }
        }
        private func setupDataSource(){
            dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionview, cellProvider: { (collectionView, indexPath, item ) -> UICollectionViewCell? in
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                switch section {
                case .main:
                    let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: MissionCollectionViewCell.reusedId, for: indexPath) as! MissionCollectionViewCell
                    cell.config(item as! MissionList)
                    return cell
                case .empty:
                    let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.reuseId, for: indexPath) as! EmptyCollectionViewCell
                    self.subLabel.isHidden = true
                    return cell
                }
            })
        }
        private func reloadData(){
            //data
//            var snapShot = NSDiffableDataSourceSnapshot<Section,Item>()
//                  defer{
//                      dataSource.apply(snapShot,animatingDifferences: true)
//                  }
//                  snapShot.appendSections([.main])
//                  snapShot.appendItems(missionList,toSection: .main)
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            defer {
                dataSource.apply(snapshot, animatingDifferences: false)
            }
                snapshot.appendSections([.empty])
                snapshot.appendItems(Array(0..<1), toSection: .empty)
            }
        
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, env in
            let section = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            switch section {
            case .main:
               return self.MainSection()
            case .empty:
                return self.EmptySection()
            default :
                break
            }
        })
                return layout
    }
    func MainSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(1)), subitems: [item])
        group.interItemSpacing = .fixed(18)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        return section
   }
    func EmptySection() -> NSCollectionLayoutSection {
       let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem : item ,count: 1)
       let section = NSCollectionLayoutSection(group: group)
       section.supplementariesFollowContentInsets = false
       return section
   }
    }
extension MissionStatisticsViewController : UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("notToDo VC : \(indexPath)")
        }
    }
