//
//  HomeCollectionReusableView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/06.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class HomeCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = "HomeCollectionReusableView"
    
    // MARK: - UI Components
    
    var dateLabel = UILabel()
    private let dateView = UIView()
    private var motivationLabel = UILabel()
    private var graphicImageView = UIImageView()
    
    // MARK: - Life Cycle
    
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

extension HomeCollectionReusableView {
    private func setUI() {
        backgroundColor = .nottodoWhite
        dateLabel.do {
            $0.textColor = .nottodoBlack
            $0.font = .PretendardBold(size: 18.adjusted)
        }
        dateView.backgroundColor = .yellow_basic
        motivationLabel.do {
            $0.font = .PretendardBold(size: 23.adjusted)
            $0.textColor = .nottodoBlack
            $0.text = ""
            $0.numberOfLines = 0
        }
        graphicImageView.do {
            $0.image = graphicData.shuffled().first
        }
        layer.addBorder([.bottom], color: .nottodoGray2!, width: 0.5)
    }
    
    private func setLayout() {
        addSubviews(dateView, dateLabel, graphicImageView, motivationLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25.adjusted)
            $0.leading.equalToSuperview().inset(27.adjusted)
        }
        
        dateView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.top)
            $0.trailing.equalTo(dateLabel.snp.trailing).offset(4.adjusted)
            $0.leading.equalTo(dateLabel.snp.leading).offset(-4.adjusted)
            $0.bottom.equalTo(dateLabel.snp.bottom).offset(1.adjusted)
        }
        
        motivationLabel.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.trailing.equalTo(graphicImageView.snp.leading)
        }
        
        graphicImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17.adjusted)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(144.adjusted)
            $0.width.equalTo(160.adjusted)
            $0.bottom.equalToSuperview().inset(22.adjusted)
        }
    }
    
    func setRandomData(banner: BannerResponseDTO) {
        graphicImageView.setImage(with: banner.image)
        let randomText = banner.title
        motivationLabel.text = randomText
//        self.typingAnimation(randomText)
    }
    
    private func typingAnimation(_ target: String) {
        var charIndex = 0.0
        motivationLabel.text = ""
        for letter in target {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex,
                                 repeats: false) { _ in
                self.motivationLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}
