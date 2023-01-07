//
//  MissionHistoryView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

class MissionHistoryView: UIView, UITextFieldDelegate {
    
    // MARK: - UI Components
    
    private var inputTextField = UITextField()
    private var backButton = UIButton()
    private lazy var missionHistoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let historyInset: UIEdgeInsets = UIEdgeInsets(top: 15.adjusted, left: 20.adjusted, bottom: 15.adjusted, right: 20.adjusted)
    let cellHeight: CGFloat = 49.adjusted
    let width: CGFloat = UIScreen.main.bounds.width
    
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

extension MissionHistoryView {
    private func setUI() {
        inputTextField.do {
            $0.backgroundColor = .nottodoWhite
            $0.layer.borderWidth = 1.adjusted
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.font = .PretendardMedium(size: 16.adjusted)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.adjusted, height: 0.0))
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: I18N.historyPlaceHolder,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.nottodoGray3!])
            $0.delegate = self
        }
        
        backButton.do {
            $0.setTitle(I18N.cancel, for: .normal)
            $0.setTitleColor(.nottodoBlack, for: .normal)
            $0.titleLabel?.font = .PretendardMedium(size: 16)
        }
        
        missionHistoryCollectionView.do {
            $0.isScrollEnabled = true
            $0.collectionViewLayout = layout()
            // $0.showsVerticalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private func setLayout() {
        backgroundColor = .nottodoWhite
        
        addSubviews(inputTextField, backButton, missionHistoryCollectionView)
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(31)
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.trailing.equalToSuperview().offset(-66.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalTo(inputTextField.snp.centerY)
            $0.trailing.equalToSuperview().offset(-22.adjusted)
        }
        
        missionHistoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(25.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        return layout
    }
    
    private func calculateCellHeight() -> CGFloat {
        let count = CGFloat(historyList.count)
        return count * cellHeight + (count-1) * historyInset.top + historyInset.bottom
    }
    
    private func register() {
        missionHistoryCollectionView.register(MissionHistoryHeaderView.self,
                                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                            withReuseIdentifier: MissionHistoryHeaderView.identifier)
        missionHistoryCollectionView.register(MissionHistoryCollectionViewCell.self,
                                            forCellWithReuseIdentifier: MissionHistoryCollectionViewCell.identifier)
    }
}

extension MissionHistoryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MissionHistoryCollectionViewCell.identifier, for: indexPath)
                as? MissionHistoryCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(model: historyList[indexPath.row])
        cell.setBorder(indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MissionHistoryHeaderView.identifier, for: indexPath) as? MissionHistoryHeaderView
        else { return UICollectionReusableView() }
        return headerView
    }
}

extension MissionHistoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: width, height: 30.adjusted)
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return historyInset
    }
}
