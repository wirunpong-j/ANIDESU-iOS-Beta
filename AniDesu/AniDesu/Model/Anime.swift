//
//  Anime.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

struct Anime {
    public private(set) var id: Int
    public private(set) var series_type: String
    public private(set) var title_romaji: String
    public private(set) var title_english: String
    public private(set) var title_japanese: String
    public private(set) var type: String
    public private(set) var start_date: String
    public private(set) var end_date: String
    public private(set) var start_date_fuzzy: Int
    public private(set) var end_date_fuzzy: Int
    public private(set) var season: Int
    public private(set) var description: String
    public private(set) var synonyms: [String]
    public private(set) var genres: [String]
    public private(set) var adult: Bool
    public private(set) var average_score: Double
    public private(set) var popularity: Int
    public private(set) var favourite: Bool
    public private(set) var image_url_sml: String
    public private(set) var image_url_med: String
    public private(set) var image_url_lge: String
    public private(set) var image_url_banner: String
    public private(set) var updated_at: Int
    public private(set) var total_episodes: Int
    public private(set) var duration: Int
    public private(set) var airing_status: String
    public private(set) var youtube_id: String
    public private(set) var hashtag: String
    public private(set) var source: String
}
