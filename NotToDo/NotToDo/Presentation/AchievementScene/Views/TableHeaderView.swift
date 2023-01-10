//
//  TableHeaderView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/08.
//
import UIKit

import SnapKit
import Then

class TableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static var identifier = "TableHeaderVIew"
    
    // MARK: - UI Components
    
    var headerButton = UIButton()
    var headerImage = UIImageView()
    var headerLabel = UILabel()
    var numberLabel = UILabel()
    var iconImageView = UIImageView()
    var isSelected: Bool = false
    var isClickedClosure: ((_ result: Bool) -> Void)?
    
    // MARK: - View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
        numberLabel.textColor = isSelected ? UIColor.yellow_basic : UIColor.nottodoGray1
        headerImage.image = nil
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension TableHeaderView {
    func setUI() {
        contentView.addSubviews(headerButton, numberLabel)
        headerButton.addSubviews(headerImage, headerLabel)
        
        headerButton.do {
            $0.addTarget(self, action: #selector(headerButtonTapped), for: .touchUpInside)
        }
        headerLabel.do {
            $0.textColor = UIColor.nottodoBlack
            $0.font = .PretendardBold(size: 14)
        }
        numberLabel.do {
            $0.text = "n 회"
            $0.font = .PretendardRegular(size: 14.adjusted)
        }
    }
    
    func setLayout() {
        headerButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6.adjusted)
            $0.height.equalTo(45.adjusted)
        }
        headerImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        headerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(50.adjusted)
        }
        numberLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30.adjusted)
            $0.centerY.equalTo(headerLabel.snp.centerY)
        }
    }
    
    func config(_ title: TitleButtonList) {
        headerLabel.text = title.title
    }
    
    @objc func headerButtonTapped(_ sender: UIButton) {
        isClickedClosure?(true)
    }
}
