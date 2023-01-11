//
//  UIDevice+.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/11.
//

import UIKit

import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
