//
//  frequentItems.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/25.
//

import Foundation

struct frequentItems: Decodable {
    let success: String
    let code: Int
    let message: String
    let data: itemData
    
    struct itemData: Decodable {
        let name: String
        let skillAccel: String
        let englishName: String
        let src: String
    }
}
