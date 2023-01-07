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
    private var inputTextField = UITextField()
    private var textCountLabel = UILabel()
    let maxLength = 15
    
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
        
        inputTextField.do {
            $0.backgroundColor = .nottodoWhite
            $0.layer.borderWidth = 1.adjusted
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.font = .PretendardMedium(size: 16.adjusted)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.adjusted, height: 0.0))
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: I18N.inputPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.nottodoGray3!])
            $0.delegate = self
        }
        
        textCountLabel.do {
            $0.text = "0/15"
            $0.font = .PretendardRegular(size: 16.adjusted)
            $0.textColor = .nottodoGray2
        }
    }
    
    private func setLayout() {
        backgroundColor = .nottodoWhite
        
        addSubviews(navigationBarView, addSituationCollectionView, inputTextField, textCountLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(72.adjusted)
        }
        
        addSituationCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(32.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(270.adjusted)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(addSituationCollectionView.snp.bottom).offset(38.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(9.adjusted)
            $0.trailing.equalToSuperview().inset(20.adjusted)
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

extension AddSituationView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count ?? 0 > maxLength {
            textField.deleteBackward()
        }
        textCountLabel.text = "\(textField.text!.count)/15"
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.borderColor = .nottodoGray2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .nottodoGray4
    }
}

extension AddSituationView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        
        switch indexPath.section {
        case 0:
            inputTextField.text = recommendList[indexPath.row].keyword
            textCountLabel.text = "\(inputTextField.text!.count)/15"
        case 1:
            inputTextField.text = recentList[indexPath.row].keyword
            textCountLabel.text = "\(inputTextField.text!.count)/15"
        default:
            return
        }
    }
}
