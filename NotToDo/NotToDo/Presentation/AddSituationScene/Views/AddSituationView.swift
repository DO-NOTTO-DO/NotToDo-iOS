//
//  AddSituationView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/06.
//

import UIKit

class AddSituationView: UIView {
    
    // MARK: - UI Components
    
    private var navigationBarView = NavigationBarView(frame: CGRect(), mode: .addSituation)
    private lazy var addSituationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // variables
    
    var recommendList: [AddSituationModel] = [
        AddSituationModel(keyword: "출근 시간"),
        AddSituationModel(keyword: "아침"),
        AddSituationModel(keyword: "업무"),
        AddSituationModel(keyword: "아이엘츠"),
        AddSituationModel(keyword: "밥 먹을 때"),
        AddSituationModel(keyword: "치팅데이"),
        AddSituationModel(keyword: "휴식시간")
    ]
    
    var recentList: [AddSituationModel] = [
        AddSituationModel(keyword: "흠냐흠냐"),
        AddSituationModel(keyword: "아침"),
        AddSituationModel(keyword: "떡볶이"),
        AddSituationModel(keyword: "낫투두"),
        AddSituationModel(keyword: "최고"),
        AddSituationModel(keyword: "짱이얌")    ]
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        register()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension AddSituationView {
    private func setUI() {
        addSituationCollectionView.do {
            $0.isScrollEnabled = false
            $0.collectionViewLayout = layout()
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private func setLayout() {
        backgroundColor = .nottodoWhite
        
        addSubviews(navigationBarView, addSituationCollectionView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(72.adjusted)
        }
        
        addSituationCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(266)
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 15.adjusted, left: 20.adjusted, bottom: 32.adjusted, right: 20.adjusted)
        return layout
    }
    
    private func register() {
        addSituationCollectionView.register(AddSituationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AddSituationHeaderView.identifier)
        addSituationCollectionView.register(AddSituationCollectionViewCell.self, forCellWithReuseIdentifier: AddSituationCollectionViewCell.identifier)
    }
}

extension AddSituationView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return recommendList.count
        case 1:
            return recentList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AddSituationCollectionViewCell.identifier, for: indexPath)
                    as? AddSituationCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(model: recommendList[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AddSituationCollectionViewCell.identifier, for: indexPath)
                    as? AddSituationCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(model: recentList[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddSituationHeaderView.identifier, for: indexPath) as? AddSituationHeaderView else { return UICollectionReusableView() }
            headerView.HeaderTitle(title: "낫투두가 추천하는 상황 키워드")
            headerView.Icon(icon: .icRecommend)
            return headerView
        case 1:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddSituationHeaderView.identifier, for: indexPath) as? AddSituationHeaderView else { return UICollectionReusableView() }
            headerView.HeaderTitle(title: "최근 사용한 키워드")
            headerView.Icon(icon: .recentUse)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

extension AddSituationView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSituationCollectionViewCell", for: indexPath) as? AddSituationCollectionViewCell else {
            return .zero
        }
        
        switch indexPath.section {
        case 0:
            cell.addSituationLabel.text = recommendList[indexPath.row].keyword
        case 1:
            cell.addSituationLabel.text = recentList[indexPath.row].keyword
        default:
            cell.addSituationLabel.text = recommendList[indexPath.row].keyword
        }
        
        cell.addSituationLabel.sizeToFit()
        let cellWidth = cell.addSituationLabel.frame.width + 42.adjusted
        
        return CGSize(width: cellWidth, height: 31.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 31.adjusted)
    }
}
