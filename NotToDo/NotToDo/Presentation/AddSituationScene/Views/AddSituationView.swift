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
    
    var situationList: [AddSituationModel] = [
        AddSituationModel(keyword: "출근 시간"),
        AddSituationModel(keyword: "아침"),
        AddSituationModel(keyword: "업무"),
        AddSituationModel(keyword: "아이엘츠"),
        AddSituationModel(keyword: "밥 먹을 때"),
        AddSituationModel(keyword: "치팅데이"),
        AddSituationModel(keyword: "휴식시간")
    ]
    
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
            $0.backgroundColor = .gray
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
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(300.adjusted)
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 20.adjusted, left: 20.adjusted, bottom: 38.adjusted, right: 20.adjusted)
        return layout
    }
    
    private func register() {
        addSituationCollectionView.register(AddSituationCollectionViewCell.self, forCellWithReuseIdentifier: AddSituationCollectionViewCell.identifier)
    }
}

extension AddSituationView: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return situationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddSituationCollectionViewCell.identifier, for: indexPath)
                as? AddSituationCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(model: situationList[indexPath.row])
        return cell
    }
}

extension AddSituationView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch indexPath.section {
//        case 0:
//
//        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSituationCollectionViewCell", for: indexPath) as? AddSituationCollectionViewCell else {
            return .zero
        }
        
        cell.addSituationLabel.text = situationList[indexPath.row].keyword
        cell.addSituationLabel.sizeToFit()
        let cellWidth = cell.addSituationLabel.frame.width + 42
        
        return CGSize(width: cellWidth, height: 31)
    }
}
