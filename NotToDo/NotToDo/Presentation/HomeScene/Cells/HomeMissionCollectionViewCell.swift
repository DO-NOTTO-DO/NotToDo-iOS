//
//  HomeMissionCollectionViewCell.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class HomeMissionCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "HomeMissionCollectionViewCell"

    // MARK: - UI Components

    private let backView = UIView()
    private let yellowView = UIView()
    private let behaviorLabel = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        prepare()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        prepare()
    }
}

extension HomeMissionCollectionViewCell {
    private func setUI() {
        backgroundColor = .BG
        setBorder()
        backView.backgroundColor = .nottodoWhite
        yellowView.backgroundColor = .yellow_basic

        behaviorLabel.do {
            $0.textColor = .nottodoGray1
            $0.font = .PretendardRegular(size: 14.adjusted)
        }
    }

    private func setLayout() {
        backView.addSubviews(yellowView, behaviorLabel)
        contentView.addSubview(backView)

        backView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.adjusted)
            $0.leading.equalToSuperview().inset(51.adjusted)
            $0.top.bottom.trailing.equalToSuperview()
        }

        yellowView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(11.adjusted)
        }

        behaviorLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(yellowView.snp.trailing).offset(11.adjusted)
        }
    }

    func prepare() {
        setBorder()
    }

    func setBorder() {
        print("추가됨")
        backView.layer.addBorder([.top, .left, .right, .bottom], color: .nottodoGray2!, width: 0.5)
        yellowView.layer.addBorder([.top, .right], color: .nottodoGray2!, width: 0.5)
//        if index.row == 0 {
//            print("함수실행")
//
//        } else {
//            backView.layer.addBorder([.top, .left, .right, .bottom], color: .nottodoGray2!, width: 0.5)
//            yellowView.layer.addBorder([.top, .left, .right, .bottom], color: .nottodoGray2!, width: 0.5)
//        }
    }

    func configure(_ text: String) {
        behaviorLabel.text = text
    }
}
