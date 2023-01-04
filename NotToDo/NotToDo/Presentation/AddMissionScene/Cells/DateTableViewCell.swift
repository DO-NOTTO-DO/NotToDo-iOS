//
//  DateTableViewCell.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

// MARK: - DateTableViewCell

final class DateTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "DateTableViewCell"
    
    // MARK: - UI Components
    
    var date = Date()
    private lazy var dateLabel = UILabel()
    private lazy var dateButton = UIButton(configuration: .filled())
    
    // MARK: - View Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DateTableViewCell {
    
    // MARK: - UI Helpers
    
    private func setUI() {
        dateLabel.do {
            $0.text = "실천 날짜"
            $0.textColor = .nottodoBlack
            $0.font = .PretendardMedium(size: 16)
        }
        
        dateButton.do {
            let nowDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let str = dateFormatter.string(from: nowDate)
            $0.configuration?.title = str
            $0.configuration?.image = UIImage(systemName: "calendar")
            $0.configuration?.imagePadding = 10
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.trailing
            $0.configuration?.baseBackgroundColor = .nottodoGray1
            $0.configuration?.baseForegroundColor = .nottodoBlack
            $0.configuration?.cornerStyle = .medium
//            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(dateLabel, dateButton)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        dateButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(35)
            $0.width.equalTo(150)
        }
    }
    
    func updateData(date: String){
        dateButton.setTitle(date, for: .normal)
    }
    
//    @objc func buttonTapped(_sender : UIButton){
//        print("tapped")
//        let dateVC = CalendarVC()
//        present(dateVC, animated: true, completion: nil)
//        dateVC.dateSendDelegate = self
//    }
}
