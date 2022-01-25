//
//  opponentsData.swift
//  Swoomi
//
//  Created by 권성은 on 2022/01/25.
//

import Foundation

struct opponentsData: Decodable {
    let success: String
    let code: Int
    let message: String
    let data: opponentData
    
    struct opponentData: Decodable {
        let summonerName: String
        let championName: String
        let championImgUrl: String
        let ultImgUrl:String
        let spellDName: String
        let speelFName: String
        let spellDImgUrl: String
        let spellFImgUrl: String
        let frequentItems: itemData
    }
    
    struct itemData: Decodable {
        let name: String
        let skillAccel: String
        let englishName: String
        let src: String
    }
}
