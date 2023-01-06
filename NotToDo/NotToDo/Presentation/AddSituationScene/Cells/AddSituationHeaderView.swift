////
////  AddSituationHeaderView.swift
////  NotToDo
////
////  Created by 김민서 on 2023/01/06.
////
//
//import UIKit
//
//import SnapKit
//import Then
//
//class AddSituationHeaderView: UICollectionReusableView {
//
//    // MARK: - Identifier
//
//    static let identifier: String = "AddSituationHeaderView"
//
//    // MARK: - UI Components
//
//    private lazy var icon = UIImageView()
//    private lazy var titleLabel = UILabel()
//
//    // MARK: - View Life Cycles
//
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        setUI()
//        setLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    public func Icon(icon: UIImage?) {
//        self.icon.image = icon
//    }
//
//    public func HeaderTitle(title: String?) {
//        self.titleLabel.text = title
//    }
//}
//
//// MARK: - Extensions
//
//extension AddSituationHeaderView {
//
//    // MARK: - UI Helpers
//
//    private func setUI() {
//        titleLabel.do {
//            $0.textColor = .nottodoGray1
//            $0.font = .PretendardMedium(size: 16)
//        }
//    }
//
//    // MARK: - Layout Helpers
//
//    private func setLayout() {
//        [titleLabel, icon].forEach {
//            addSubview($0)
//        }
//
//        icon.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.equalToSuperview().offset(13)
//            $0.height.width.equalTo(30)
//        }
//
//        titleLabel.snp.makeConstraints {
//            $0.centerY.equalTo(icon.snp.centerY)
//            $0.leading.equalTo(icon.snp.trailing).offset(4)
//        }
//    }
//}
