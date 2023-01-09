//
//  SituationTableViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    static var identifier = "StatisticsTableViewCell"
    
    private lazy var segmentedControl = CustomSegmentedControl(items: [" 낫투두 통계보기 ", " 상황별 통계보기 "])
    private lazy var missionView = MissionStatisticsView(frame: bounds)
    private lazy var situationView = SituationStatisticsView(frame: bounds)

    var shouldHideMissionView: Bool? {
      didSet {
        guard let shouldHideMissionView = self.shouldHideMissionView else { return }
        self.missionView.isHidden = shouldHideMissionView
        self.situationView.isHidden = !self.missionView.isHidden
      }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //  setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension StatisticsTableViewCell {
    func setLayout() {
        contentView.addSubviews(segmentedControl, missionView, situationView)
        
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.top.equalToSuperview().offset(30.adjusted)
            $0.height.equalTo(20.adjusted)
        }
        missionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            $0.height.equalTo(800)
            $0.bottom.equalToSuperview()
        }
        situationView.snp.makeConstraints {
            $0.leading.equalTo(missionView.snp.leading)
            $0.trailing.equalTo(missionView.snp.trailing)
            $0.top.equalTo(missionView.snp.top)
            $0.height.equalTo(800)

            $0.bottom.equalTo(missionView.snp.bottom)
        }
        
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)

        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
      }

      @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideMissionView = segment.selectedSegmentIndex != 0
      }
}
