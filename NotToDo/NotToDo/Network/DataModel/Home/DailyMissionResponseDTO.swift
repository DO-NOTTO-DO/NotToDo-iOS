//
//  DailyMissionResponseDTO.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/13.
//

import Foundation
import UIKit

struct DailyMissionResponseDTO: Codable {
    let id: Int
    var title, situation, completionStatus, goal: String
    let actions: [ActionDTO]
}

struct ActionDTO: Codable {
    let name: String
}
