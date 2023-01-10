//
//  AddSituationView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

class AddSituationView: UIView {
    
    // MARK: - UI Components
    
    var navigationBarView = NavigationBarView(frame: CGRect(), mode: .addSituation)
    lazy var addSituationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var chagedText: String? {
        didSet {
            addSituationCollectionView.reloadData()
        }
    }
    
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
        backgroundColor = .nottodoWhite
        
        addSituationCollectionView.do {
            $0.isScrollEnabled = false
            $0.collectionViewLayout = layout()
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private func setLayout() {
        addSubviews(navigationBarView, addSituationCollectionView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(72.adjusted)
        }
        
        addSituationCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(32.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10.adjusted
        layout.minimumInteritemSpacing = 6.adjusted
        layout.sectionInset = UIEdgeInsets(top: 15.adjusted, left: 20.adjusted, bottom: 32.adjusted, right: 20.adjusted)
        return layout
    }
    
    private func register() {
        addSituationCollectionView.register(AddSituationHeaderView.self,
                                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                            withReuseIdentifier: AddSituationHeaderView.identifier)
        addSituationCollectionView.register(AddSituationCollectionViewCell.self,
                                            forCellWithReuseIdentifier: AddSituationCollectionViewCell.identifier)
        addSituationCollectionView.register(EmptyRecentCollectionViewCell.self,
                                            forCellWithReuseIdentifier: EmptyRecentCollectionViewCell.identifier)
        addSituationCollectionView.register(AddSituationFooterView.self,
                                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                            withReuseIdentifier: AddSituationFooterView.identifier)
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
            if recentList.isEmpty {
                return 1
            } else {
                return recentList.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddSituationCollectionViewCell.identifier, for: indexPath)
                    as? AddSituationCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(model: recommendList[indexPath.row])
            return cell
        case 1:
            if recentList.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: EmptyRecentCollectionViewCell.identifier, for: indexPath)
                        as? EmptyRecentCollectionViewCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddSituationCollectionViewCell.identifier, for: indexPath)
                        as? AddSituationCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(model: recentList[indexPath.row])
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddSituationHeaderView.identifier, for: indexPath) as? AddSituationHeaderView else { return UICollectionReusableView() }
                headerView.HeaderTitle(title: I18N.recommendKeyword)
                headerView.Icon(icon: .icRecommend)
                return headerView
            case 1:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddSituationHeaderView.identifier, for: indexPath) as? AddSituationHeaderView else { return UICollectionReusableView() }
                headerView.HeaderTitle(title: I18N.recentKeyword)
                headerView.Icon(icon: .recentUse)
                return headerView
            default:
                return UICollectionReusableView()
            }
        } else {
            switch indexPath.section {
            case 1:
                guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddSituationFooterView.identifier, for: indexPath) as? AddSituationFooterView else { return UICollectionReusableView() }
                footerView.setTextField(chagedText ?? "")
                return footerView
            default:
                return UICollectionReusableView()
            }
        }
    }
}

extension AddSituationView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddSituationCollectionViewCell.identifier, for: indexPath) as? AddSituationCollectionViewCell else { return .zero }
        switch indexPath.section {
        case 0:
            cell.addSituationLabel.text = recommendList[indexPath.row].keyword
        case 1:
            if recentList.isEmpty {
                return CGSize(width: addSituationCollectionView.frame.width, height: 35.adjusted)
            } else {
                cell.addSituationLabel.text = recentList[indexPath.row].keyword
            }
        default:
            cell.addSituationLabel.text = recommendList[indexPath.row].keyword
        }
        
        cell.addSituationLabel.sizeToFit()
        let cellWidth = cell.addSituationLabel.frame.width + 42.adjusted

        return CGSize(width: cellWidth, height: 31.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 31.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        switch section {
        case 1:
            return CGSize(width: width, height: 74.adjusted)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

extension AddSituationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension AddSituationView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.reloadData()
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddSituationCollectionViewCell.identifier, for: indexPath)
                as? AddSituationCollectionViewCell
        cell!.backgroundColor = .blue
        
        switch indexPath.section {
        case 0:
            chagedText = recommendList[indexPath.row].keyword
        case 1:
            if !recentList.isEmpty {
                chagedText = recentList[indexPath.row].keyword
            }
        default:
            return
        }
    }
}
