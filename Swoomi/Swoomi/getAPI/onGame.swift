//
//  onGame.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/25.
//

import Foundation

struct onGame: Decodable {
    let success: String
    let code: Int
    let message: String
    let data: gameStatus
    
    struct gameStatus: Decodable {
        let matchStatus: String
    }
}
