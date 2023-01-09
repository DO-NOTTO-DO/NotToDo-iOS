//
//  SituationTableViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

import SnapKit
import Then

protocol SituationButtonDelegate {
    func buttonTapped(cell: UITableViewCell)
}

class StatisticsTableViewCell: UITableViewCell {
    
    var delegate: SituationButtonDelegate?
    
    static var identifier = "StatisticsTableViewCell"
    
     lazy var segmentedControl = CustomSegmentedControl(items: [" 낫투두 통계보기 ", " 상황별 통계보기 "])
    private lazy var missionView = MissionStatisticsView(frame: bounds)
    
    private lazy var situationView = SituationStatisticsView(frame: bounds)
    private var bottomLabel = UILabel()

    var shouldHideMissionView: Bool? {
      didSet {
        guard let shouldHideMissionView = self.shouldHideMissionView else { return }
        self.missionView.isHidden = shouldHideMissionView
        self.situationView.isHidden = !self.missionView.isHidden
      }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension StatisticsTableViewCell {
    func setUI() {
        bottomLabel.do {
            $0.text = "* 올해의 낫투두가 누적된 통계예요!"
            $0.font = .PretendardMedium(size: 12)
            $0.textColor = .nottodoGray2
        }
    }
    
    func setLayout() {
        contentView.addSubviews(segmentedControl, missionView, situationView, bottomLabel)
        
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.top.equalToSuperview().offset(30.adjusted)
            $0.height.equalTo(20.adjusted)
        }
        missionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
            $0.height.equalTo(missionView.missionList.count * 55 + 88 )
            $0.bottom.equalToSuperview().offset(-78.adjusted)
        }
        situationView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20.adjusted)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.adjusted)
          //  $0.height.equalTo(situationView.titleLists.count * 55 + 88 )
            $0.height.equalTo(missionView.snp.height)
            $0.bottom.equalToSuperview().offset(-78.adjusted)
        }
        
      
        bottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.adjusted)
            if missionView.isHidden {
            $0.top.equalTo(situationView.snp.bottom).offset(12.adjusted)
            }
            $0.top.equalTo(missionView.snp.bottom).offset(12.adjusted)
        }
        
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideMissionView = segment.selectedSegmentIndex != 0
        delegate?.buttonTapped(cell: self)
    }
}
