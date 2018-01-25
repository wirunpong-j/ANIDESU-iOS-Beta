//
//  AnimeService.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class AnimeService {
    static let instance = AnimeService()
    var allAnime = [Anime]()
    
    func fetchAnimeDataBySeason(season: String, completion: @escaping CompletionHandler) {
        
        for i in 1...10 {
            var anime1 = Anime(id: 1, series_type: "Anime", title_romaji: "Nanatsu no Taizai: Imashime no Fukkatsu", title_english: "title_english", title_japanese: "title_japanese", type: "Anime", start_date: "Jan 13, 2018", end_date: "Jan 15, 2018", start_date_fuzzy: 1, end_date_fuzzy: 1, season: 1, description: "ETC", synonyms: ["synonyms"], genres: ["genres"], adult: false, average_score: 69.2, popularity: 1000, favourite: true, image_url_sml: "https://cdn.anilist.co/img/dir/anime/reg/99539-bkfUqkhBTSeR.jpg", image_url_med: "https://cdn.anilist.co/img/dir/anime/reg/99539-bkfUqkhBTSeR.jpg", image_url_lge: "https://cdn.anilist.co/img/dir/anime/reg/99539-bkfUqkhBTSeR.jpg", image_url_banner: "https://cdn.anilist.co/img/dir/anime/reg/99539-bkfUqkhBTSeR.jpg", updated_at: 021922, total_episodes: 12, duration: 1, airing_status: "FINISHED AIRING", youtube_id: "123456", hashtag: "#eiei", source: "source")
            
            self.allAnime.append(anime1)
        }
    }
}
