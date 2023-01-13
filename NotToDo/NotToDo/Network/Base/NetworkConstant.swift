//
//  NetworkConstant.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import Foundation

struct NetworkConstant {
    static let noTokenHeader = ["Content-Type": "application/json"]
    static let hasTokenHeader = ["Content-Type": "application/json",
                                 "Authorization": NetworkConstant.accessToken]
    
    static var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzLCJpYXQiOjE2NzM2MjM0ODgsImV4cCI6MTY3NTY5NzA4OH0.S6LxBOCHwMg-zysGGZisQbST1Lw8aIzgtz6aY3iKBRw"
}
