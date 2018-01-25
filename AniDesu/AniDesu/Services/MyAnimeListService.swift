//
//  MyAnimeListService.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class MyAnimeListService {
    static let instance = MyAnimeListService()
    var allMyAnimeList = [MyAnimeList]()
    
    func fetchAllMyAnimeListData(completion: @escaping CompletionHandler) {
        let list1 = MyAnimeList(anime_id: 1, score: 8, progress: 3, note: "Sanook")
        self.allMyAnimeList.append(list1)
    }
}
