//
//  String+.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/13.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            if let date = dateFormatter.date(from: self) {
                return date
            } else {
                return nil
            }
        }
}
