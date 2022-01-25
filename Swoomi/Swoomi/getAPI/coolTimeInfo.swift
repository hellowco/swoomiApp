//
//  coolTimeInfo.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/25.
//

import Foundation

struct coolTimeInfo: Decodable {
    let success: String
    let code: Int
    let message: String
    let data: coolTime
    
    struct coolTime: Decodable {
        let cooltimeD: String
        let spellDName: String
        let cooltimeF: String
        let spellFName: String
        let cooltimeR: String
    }
}
