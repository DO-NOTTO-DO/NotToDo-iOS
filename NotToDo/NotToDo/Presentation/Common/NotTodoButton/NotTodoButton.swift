//
//  NotTodoButton.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/01.
//

import UIKit

// MARK: - ButtonType

enum ButtonMode: CaseIterable {
    case plain
    case withImage
}

final class NotTodoButton: UIButton {
    
    // MARK: - Properties
    
    private var mode: ButtonMode
    
    // MARK: - View Life Cycle
    
    init(frame: CGRect, mode: ButtonMode, text: String, image: UIImage?,
         font: UIFont.PretendardType, size: CGFloat) {
        self.mode = mode
        super.init(frame: frame)
        setupMode(mode: mode, image: image ?? nil, text: text,
                  font: font, size: size)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConfiguration() {
        guard let configuration = configuration else {
            return
        }
        var updatedConfiguration = configuration
        var background = updatedConfiguration.background

        switch self.state {
        case .normal:
            background.backgroundColor = .nottodoBlack!
        case .disabled:
            background.backgroundColor = .nottodoGray2!
        default:
            background.backgroundColor = .nottodoBlack!
        }
        updatedConfiguration.background = background
        self.configuration = updatedConfiguration
    }
}

extension NotTodoButton {
    private func setupMode(mode: ButtonMode, image: UIImage?, text: String,
                           font: UIFont.PretendardType, size: CGFloat) {
        var config = UIButton.Configuration.plain()
        var attString = AttributedString(text)
        attString.font = .Pretandard(font, size: size)
        attString.foregroundColor = .nottodoWhite
        
        config.attributedTitle = attString
        config.cornerStyle = .capsule
        
        switch self.mode {
        case .plain: break
        case .withImage:
            config.image = image!
            config.imagePlacement = .trailing
            config.imagePadding = 10.adjusted
        }
        self.configuration = config
    }
}
