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
    
    // MARK: - Properties
    
    private var isLogin: Bool {
        return true
    }
    
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
        myInfoCollectionView.register(myInfoFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: myInfoFooterCollectionReusableView.identifier)
    }
    
    private func setCollectionView() {
        myInfoCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .BG
        }
    }
    
    private func setUI() {
        backgroundColor = .BG
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
        let cellWidth = 353.adjusted
        let menuCellHeight = 61.adjusted
        let userCellHeight = 96.adjusted
        switch indexPath.section {
        case 0:
            return CGSize(width: cellWidth, height: userCellHeight)
        default:
            return CGSize(width: cellWidth, height: menuCellHeight)
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
            cell.setLayout(isLogin: isLogin)
            cell.layer.addBorder([.top, .bottom, .left, .right], color: .nottodoGray2!, width: 0.5)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myInfoMenuCollectionViewCell.identifier, for: indexPath) as? myInfoMenuCollectionViewCell else { return UICollectionViewCell() }
            let model = myInfoFirstMenuList[indexPath.row]
            cell.configure(model.title, menuIcon: model.icon, rightButton: model.goToButton, indexPath: indexPath)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myInfoMenuCollectionViewCell.identifier, for: indexPath) as? myInfoMenuCollectionViewCell else { return UICollectionViewCell() }
            let model = myInfoSecondMenuList[indexPath.row]
            cell.configure(model.title, menuIcon: model.icon, rightButton: model.goToButton, indexPath: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 18.adjusted, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 16.adjusted, right: 0)
        default:
            return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: myInfoFooterCollectionReusableView.identifier,
                for: indexPath
              ) as? myInfoFooterCollectionReusableView else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 2:
            return CGSize(width: 150.adjusted, height: 57.adjusted)
        default:
            return CGSize()
        }
    }
}
