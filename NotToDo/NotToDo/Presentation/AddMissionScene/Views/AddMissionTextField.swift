//
//  AddMissionTextFieldView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/05.
//

import UIKit

import SnapKit
import Then

final class AddMissionTextField: UITextField {
    
    // MARK: - View Life Cycles
    
    init(frame: CGRect, placeHolder: String) {
        super.init(frame: frame)
        setUI(placeHolder: placeHolder)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension AddMissionTextField {
    private func setUI(placeHolder: String) {
        self.do {
            $0.backgroundColor = .nottodoWhite
            $0.layer.borderWidth = 1.adjusted
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.font = .PretendardMedium(size: 16)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.adjusted, height: 0.0))
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.nottodoGray3!])
            $0.addTarget(self, action: #selector(changeText), for: .editingChanged)
        }
    }
    
    private func setLayout() {
        snp.makeConstraints {
            $0.height.equalTo(46.adjusted)
        }
    }
    
    // MARK: - @objc Methods
    
    @objc func changeText() {
        if text!.count > 0 {
            layer.borderColor = UIColor.nottodoGray2?.cgColor
        } else {
            layer.borderColor = UIColor.nottodoGray4?.cgColor
        }
    }
}
