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
    
    static var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjExLCJpYXQiOjE2NzM0NTQxMDgsImV4cCI6MTY3NTUyNzcwOH0.rsDnsUfOYGBa44eiKz_vePR_lyz-yrvlCDgrZmrAP9E"
}
