//
//  summonerInfo.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/21.
//

import Foundation

struct summonerInfo: Decodable {
    let success: String
    let code: Int
    let message: String
    let data: summonerData
    
    struct summonerData: Decodable {
        let summonerId: String
        let summonerName: String
    }
}
