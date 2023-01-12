//
//  File.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/13.
//

import Foundation

struct AddMissionRequest: Encodable {
    let title: String
    let situation: String
    let actions: [String]
    let goal: String
    let actionDate: String
}
