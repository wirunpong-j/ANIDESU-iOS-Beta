//
//  AnimeService.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AniListService {
    static let instance = AniListService()
    
    func fetchAnimeDataBySeason(season: SeasonType, completion: @escaping ([Anime]?) -> ()) {
        let body: [String: Any] = [
            "season": season.rawValue,
            "full_page": true,
            "airing_data": true
        ]
        Alamofire.request(ANIME_BROWSE_URL, method: .get, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                var json: JSON
                do { try json = JSON(data: data) } catch { return }
                
                if let jsonArray = json.array {
                    var animeList = [Anime]()
                    for item in jsonArray {
                        let anime = Anime(anime: item)
                        animeList.append(anime)
                    }
                    completion(animeList)
                } else {
                    completion(nil)
                }
            } else {
                print("ERROR")
                completion(nil)
            }
        }
    }
}
