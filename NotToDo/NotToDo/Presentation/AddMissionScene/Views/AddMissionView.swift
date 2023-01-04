//
//  MissionView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/03.
//

import UIKit

import Then
import SnapKit

// MARK: - AddMissionView

class AddMissionView: UIView {

    // MARK: - UI Components
    
    private var navigationBarView = NavigationBarView(frame: CGRect(), mode: .recommend)
    private lazy var addMissionTableView = UITableView()
    
    // MARK: - Variables
    
    var missionList: [MissionModel] = [
        MissionModel(label: "하지 않을 일을 적어주세요", textField: "ex) 유튜브 2시간 이상 보지 않기"),
        MissionModel(label: "이루고자 하는 목표는 무엇인가요?", textField: "ex) 책 1권 완독하기")
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

// MARK: - Extensions

extension AddMissionView {
    
    // MARK: - UI Helpers
    
    private func setUI() {
        addMissionTableView.do {
            $0.backgroundColor = .nottodoBlue
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.separatorStyle = .singleLine
            $0.separatorColor = .black.withAlphaComponent(0.1)
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        backgroundColor = .nottodoGreen
        [navigationBarView, addMissionTableView].forEach {
            addSubview($0)
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(68)
        }
        
        addMissionTableView.snp.makeConstraints {
            $0.top.equalTo(self.navigationBarView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(80 * missionList.count)
        }
    }
    
    private func register() {
        addMissionTableView.register(MissionTableViewCell.self,
                                     forCellReuseIdentifier: MissionTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension AddMissionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            guard let missionCell = tableView.dequeueReusableCell(
                withIdentifier: MissionTableViewCell.identifier, for: indexPath)
                    as? MissionTableViewCell else { return UITableViewCell() }
            
            missionCell.dataBind(model: missionList[indexPath.row])
            return missionCell
    }
}

// MARK: - UITableViewDelegate

extension AddMissionView: UITableViewDelegate {
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


