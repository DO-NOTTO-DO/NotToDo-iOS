//
//  SituationCollectionViewCell.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

class AddSituationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "AddSituationCollectionViewCell"
    
    // MARK: - UI Components
    
    let addSituationLabel = UILabel()
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .blue
            } else {
                backgroundColor = .orange
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension AddSituationCollectionViewCell {
    private func setUI() {
        // backgroundColor = .nottodoWhite
        layer.borderColor = UIColor.nottodoGray1?.cgColor
        layer.borderWidth = 0.5.adjusted
        layer.cornerRadius = self.frame.height / 2
        
        addSituationLabel.do {
            $0.font = .PretendardMedium(size: 14.adjusted)
            $0.textColor = .nottodoGray1
        }
    }
    
    private func setLayout() {
        addSubview(addSituationLabel)
        
        addSituationLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func dataBind(model: AddSituationModel) {
        addSituationLabel.text = model.keyword
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard self.isHighlighted else { return }
            
            UIView.animate(
                withDuration: 0.05,
                animations: {
                    self.backgroundColor = .nottodoGray1
                    self.addSituationLabel.textColor = .nottodoWhite
                }
            )
        }
    }
}
