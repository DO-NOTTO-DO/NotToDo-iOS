//
//  MissionTableViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

import SnapKit
import Then

class MissionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier = "MissionTableViewCell"
    
    // MARK: - UI Components
    
    private var label = CustomAchieveLabel(color: .nottodoBlack!, font: .PretendardSemiBold(size: 14.adjusted))
    var missionImage = UIImageView()
    let numberLabel = UILabel()
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10.adjusted, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension MissionTableViewCell {
    private func setUI() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10.adjusted, left: 0, bottom: 0, right: 0))
        backgroundColor = .clear
        missionImage.do {
            $0.image = UIImage.rank1
        }
        numberLabel.do {
            $0.textColor = .nottodoGray2
            $0.font = .PretendardRegular(size: 14.adjusted)
            $0.text = "n회"
        }
    }
    
    private func setLayout() {
        contentView.addSubview(missionImage)
        missionImage.addSubviews(label, numberLabel)
        
        missionImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(41.adjusted)
        }
        numberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(17.adjusted)
        }
    }
    
    func configure(_ item: MissionStatistcsResponse) {
        label.text = item.title
        numberLabel.text = "\(item.count)회"
    }
}
