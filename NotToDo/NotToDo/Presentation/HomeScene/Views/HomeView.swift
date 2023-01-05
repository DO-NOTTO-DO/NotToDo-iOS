//
//  HomeView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/02.
//

import UIKit

import FSCalendar
import SnapKit
import Then

final class HomeView: UIView {
    
    // MARK: - Properties
    
    private let weekly = Date()
    
    // MARK: - UI Components
    
    var calendar = FSCalendar(frame: .zero)
    private var motivationLabel = UILabel()
    private var graphicImageView = UIImageView()
    private 
    
    
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

extension HomeView {
    private func setUI() {
        backgroundColor = .nottodoWhite
    }
    
    private func setLayout() {
    }
}
