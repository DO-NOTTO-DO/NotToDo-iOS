//
//  MissionView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import Then
import SnapKit

class AddMissionView: UIView {
    
    // MARK: - Properties

    // MARK: - UI Components
    
    var navigationBarView = NavigationBarView(frame: CGRect(), mode: .plain)
    private lazy var scrollView = UIScrollView()
    private lazy var vStack = UIStackView(arrangedSubviews: [situationView, goalView, dateView])
    
    private let maxMissionLabelView = UIView()
    private let maxMissionLabel = UILabel()
    
    private let missionView = UIView()
    private let missionTitleView = AddMissionTitleView(frame: .zero, titleLabel: I18N.missionTitle, buttonLabel: nil, icon: nil)
    let missionTextField = UIView()
    let missionText = UILabel()
    
    private let behaviorView = UIView()
    let behaviorTitleView = AddMissionTitleView(frame: .zero, titleLabel: I18N.behaviorTitle, buttonLabel: I18N.recommend, icon: .rightArrow)
    private let behaviorTextField = AddMissionTextField(frame: .zero, placeHolder: I18N.behaviorPlaceHolder)
    let addBehaviorButton = UIButton()
    let unavailableAddBehaviorButton = UIButton()
    private let maxBehaviorLabel = UILabel()
    
    lazy var addBehaviorCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout())
    
    let situationView = AddMissionTitleView(frame: .zero, titleLabel: I18N.situationTitle, buttonLabel: I18N.input, icon: .rightArrow)
    
    private let goalView = UIView()
    private let goalTitleView = AddMissionTitleView(frame: .zero, titleLabel: I18N.goalTitle, buttonLabel: nil, icon: nil)
    let goalTextField = AddMissionTextField(frame: .zero, placeHolder: I18N.goalPlaceHolder)
    
    private let dateView = UIView()
    private let dateLabel = UILabel()
    let dateButton = UIButton(configuration: .filled())
    var date = Date()
    let nowDate = Date()
    let dateFormatter = DateFormatter()
    
    let addMissionButton = UIButton()
    
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

extension AddMissionView {
    private func setUI() {
        vStack.do {
            $0.axis = .vertical
            $0.spacing = 35.adjusted
        }
        
        maxMissionLabelView.do {
            $0.backgroundColor = .BG
        }
        
        maxMissionLabel.do {
            $0.text = I18N.maxMission
            $0.font = .PretendardRegular(size: 14.adjusted)
            $0.textColor = .nottodoGray2
        }
        
        missionTextField.do {
            $0.layer.borderWidth = 1.adjusted
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.isUserInteractionEnabled = true
        }
        
        missionText.do {
            $0.text = I18N.missionPlaceHolder
            $0.font = .PretendardMedium(size: 16.adjusted)
            $0.textColor = .nottodoGray3
        }
        
        addBehaviorButton.do {
            $0.setImage(.plusBtn, for: .normal)
            $0.addTarget(self, action: #selector(addBehaviorCell), for: .touchUpInside)
        }
        
        unavailableAddBehaviorButton.do {
            $0.setImage(.unavailablePlusBtn, for: .normal)
            $0.isHidden = true
        }
        
        maxBehaviorLabel.do {
            $0.text = I18N.maxBehavior
            $0.font = .PretendardRegular(size: 12.adjusted)
            $0.textColor = .nottodoGray2
        }
        
        addBehaviorCollectionView.do {
            $0.isScrollEnabled = false
            $0.collectionViewLayout = layout()
        }
        
        dateLabel.do {
            $0.text = I18N.actionDate
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16.adjusted)
        }
        
        dateFormatter.do {
            $0.dateFormat = "yyyy.MM.dd"
        }
        
        dateButton.do {
            let str = dateFormatter.string(from: nowDate)
            $0.configuration?.title = str
            $0.configuration?.image = .addCalendar
            $0.configuration?.imagePadding = 10.adjusted
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.trailing
            $0.configuration?.baseBackgroundColor = .BG
            $0.configuration?.baseForegroundColor = .nottodoGray1
            $0.configuration?.cornerStyle = .medium
            $0.layer.borderWidth = 0.5.adjusted
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.layer.cornerRadius = 5.adjusted
            $0.titleLabel?.font = .PretendardMedium(size: 16.adjusted)
        }
        
        addMissionButton.do {
            $0.setTitle(I18N.add, for: .normal)
            $0.setTitleColor(.nottodoWhite, for: .normal)
            $0.titleLabel?.font = .PretendardBold(size: 18.adjusted)
            $0.backgroundColor = .nottodoGray2
        }
    }
    
    private func setLayout() {
        backgroundColor = .nottodoWhite
        
        addSubviews(navigationBarView, scrollView, addMissionButton)
        scrollView.addSubviews(maxMissionLabelView, missionView, behaviorView, addBehaviorCollectionView, vStack)
        missionView.addSubviews(missionTitleView, missionTextField)
        missionTextField.addSubview(missionText)
        behaviorView.addSubviews(behaviorTitleView, behaviorTextField, addBehaviorButton, unavailableAddBehaviorButton, maxBehaviorLabel)
        goalView.addSubviews(goalTitleView, goalTextField)
        dateView.addSubviews(dateLabel, dateButton)
        maxMissionLabelView.addSubview(maxMissionLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(68.adjusted)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-75.adjusted)
        }
        
        addMissionButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(74.adjusted)
        }
        
        maxMissionLabelView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(37.adjusted)
        }
        
        missionView.snp.makeConstraints {
            $0.top.equalTo(maxMissionLabelView.snp.bottom).offset(17.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(83.adjusted)
        }
        
        behaviorView.snp.makeConstraints {
            $0.top.equalTo(missionView.snp.bottom).offset(35.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(107.adjusted)
        }
        
        addBehaviorCollectionView.snp.makeConstraints {
            $0.top.equalTo(behaviorView.snp.bottom).offset(6.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(0)
        }
        
        vStack.snp.makeConstraints {
            $0.top.equalTo(addBehaviorCollectionView.snp.bottom).offset(27.adjusted)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(212.adjusted)
            $0.bottom.equalToSuperview().offset(-35.adjusted)
        }
        
        situationView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(24.adjusted)
        }
        
        goalView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(83.adjusted)
        }
        
        dateView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(37.adjusted)
        }
        
        maxMissionLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        missionTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        missionTextField.snp.makeConstraints {
            $0.top.equalTo(missionTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        missionText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        behaviorTitleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        behaviorTextField.snp.makeConstraints {
            $0.top.equalTo(behaviorTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.trailing.equalToSuperview().offset(-73.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        addBehaviorButton.snp.makeConstraints {
            $0.centerY.equalTo(behaviorTextField.snp.centerY)
            $0.leading.equalTo(behaviorTextField.snp.trailing).offset(7.adjusted)
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        unavailableAddBehaviorButton.snp.makeConstraints {
            $0.centerY.equalTo(behaviorTextField.snp.centerY)
            $0.leading.equalTo(behaviorTextField.snp.trailing).offset(7.adjusted)
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        maxBehaviorLabel.snp.makeConstraints {
            $0.top.equalTo(behaviorTextField.snp.bottom).offset(9.adjusted)
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
        
        goalTitleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
        
        goalTextField.snp.makeConstraints {
            $0.top.equalTo(goalTitleView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        dateButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.height.equalTo(35.adjusted)
            $0.width.equalTo(150.adjusted)
        }
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 8
        let itemLayout = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40.adjusted)))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(88.adjusted)), subitem: itemLayout, count: 2)
        groupLayout.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20.adjusted, bottom: 0, trailing: 20.adjusted)
        section.interGroupSpacing = spacing
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func register() {
        addBehaviorCollectionView.register(AddBehaviorCollectionViewCell.self,
                                           forCellWithReuseIdentifier: AddBehaviorCollectionViewCell.identifier)
    }
    
    func updateData(date: String) {
        dateButton.setTitle(date, for: .normal)
    }
    
    func dataBind(behavior: String) {
        behaviorTextField.text = behavior
    }
    
    // MARK: - @objc Methods
    
    func availableAddMission(_ enable: Bool) {
        addMissionButton.isUserInteractionEnabled = enable
        addMissionButton.backgroundColor = enable ? .nottodoBlack : .nottodoGray2
    }
    
    @objc func addBehaviorCell(_ sender: UIButton) {
        
        if behaviorTextField.text!.count > 0 && behaviorList.count < 2 {
            behaviorList.append(AddBehaviorModel(behavior: behaviorTextField.text!))
            behaviorTextField.text = ""
            behaviorTextField.layer.borderColor = UIColor.nottodoGray4?.cgColor
            addBehaviorCollectionView.reloadData()
        }
        
        addBehaviorCollectionView.snp.updateConstraints {
            $0.height.equalTo(behaviorList.count * 48)
        }
        
        if behaviorList.count >= 2 {
            unavailableAddBehaviorButton.isHidden = false
            addBehaviorButton.isHidden = true
        }
    }
}
