//
//  MyInfoView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class MyInfoView: UIView {
    
    // MARK: - UI Components
    
    private var myInfoLabel = UILabel()
    private var myInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        register()
        setLayout()
        setCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyInfoView {
    private func register() {
        myInfoCollectionView.register(myInfoUserCollectionViewCell.self, forCellWithReuseIdentifier: myInfoUserCollectionViewCell.identifier)
        myInfoCollectionView.register(myInfoMenuCollectionViewCell.self, forCellWithReuseIdentifier: myInfoMenuCollectionViewCell.identifier)
    }
    
    private func setCollectionView() {
        myInfoCollectionView.delegate = self
        myInfoCollectionView.dataSource = self
    }
    
    private func setUI() {
        backgroundColor = .nottodoWhite
        myInfoLabel.do {
            $0.text = I18N.myInfo
            $0.font = .PretendardSemiBold(size: 22)
            $0.textColor = .nottodoGray1
        }
    }
    
    private func setLayout() {
        addSubviews(myInfoLabel, myInfoCollectionView)
        
        myInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(17.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        myInfoCollectionView.snp.makeConstraints {
            $0.top.equalTo(myInfoLabel.snp.bottom).offset(22.adjusted)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MyInfoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width - 40
        switch indexPath.section {
        case 0:
            return CGSize(width: cellWidth.adjusted, height: 96.adjusted)
        default:
            return CGSize(width: cellWidth.adjusted, height: 61.adjusted)
        }
    }
}

extension MyInfoView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myInfoUserCollectionViewCell.identifier, for: indexPath) as? myInfoUserCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myInfoMenuCollectionViewCell.identifier, for: indexPath) as? myInfoMenuCollectionViewCell else { return UICollectionViewCell() }
            var model = myInfoFirstMenuList[indexPath.row]
            cell.configure(model.title, menuIcon: model.icon, rightButton: model.goToButton)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myInfoMenuCollectionViewCell.identifier, for: indexPath) as? myInfoMenuCollectionViewCell else { return UICollectionViewCell() }
            var model = myInfoSecondMenuList[indexPath.row]
            cell.configure(model.title, menuIcon: model.icon, rightButton: model.goToButton)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
