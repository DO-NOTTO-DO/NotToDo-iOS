//
//  AddSituationFooterView.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

protocol AddSituationFooterViewDelegate: AnyObject {
    func sendSituationTextFieldData(text: String)
}

class AddSituationFooterView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier: String = "AddSituationFooterView"
    
    // MARK: - UI Components
    
    var inputTextField = UITextField()
    var textCountLabel = UILabel()
    let maxLength = 15
    weak var delegate: AddSituationFooterViewDelegate?
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        inputTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension AddSituationFooterView {
    
    private func setUI() {
        inputTextField.do {
            $0.backgroundColor = .nottodoWhite
            $0.layer.borderWidth = 1.adjusted
            $0.layer.borderColor = UIColor.nottodoGray4?.cgColor
            $0.font = .PretendardMedium(size: 16.adjusted)
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.adjusted, height: 0.0))
            $0.leftViewMode = .always
            $0.attributedPlaceholder = NSAttributedString(string: I18N.inputPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.nottodoGray3!])
            $0.addTarget(self, action: #selector(changeText), for: .editingChanged)
        }
        
        textCountLabel.do {
            $0.text = "0/\(maxLength)"
            $0.font = .PretendardRegular(size: 16.adjusted)
            $0.textColor = .nottodoGray2
        }
        
        inputTextField.do {
            $0.layer.borderColor = UIColor.nottodoGray2!.cgColor
            $0.layer.borderWidth = 1.adjusted
        }
    }
    
    private func setLayout() {
        addSubviews(inputTextField, textCountLabel)
        
        inputTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(46.adjusted)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(9.adjusted)
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
    }
    
    func setData(_ text: String) {
        inputTextField.text = text
        textCountLabel.text = "\(inputTextField.text!.count)/\(maxLength)"
    }
    
    // MARK: - @objc Methods
    
    @objc func changeText() {
        let addSituationView = AddSituationView()
        addSituationView.addSituationCollectionView.reloadData()
        
        if inputTextField.text?.count ?? 0 > maxLength {
            inputTextField.deleteBackward()
        }
        textCountLabel.text = "\(inputTextField.text?.count ?? 0)/\(maxLength)"
        
        if inputTextField.text!.count > 0 {
            inputTextField.layer.borderColor = UIColor.nottodoGray2?.cgColor
        } else {
            inputTextField.layer.borderColor = UIColor.nottodoGray4?.cgColor
        }
    }
}

extension AddSituationFooterView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.sendSituationTextFieldData(text: self.inputTextField.text ?? "")
    }
}
