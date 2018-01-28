//
//  Constants.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 22/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// Segues
let TO_HOME = "toHome"

// Reuse Cell
let POST_CELL = "postCell"
let ANIME_CELL = "animeCell"
let MY_ANIME_LIST_CELL = "myAnimeListCell"

// User default key
let LOGGED_IN_KEY = "logged"
let TOKEN_KEY = "token"
let ANILIST_TOKEN_KEY = "anilistToken"
let USER_ID_KEY = "uid"

// Anilist APIs
let BASE_URL = "https://anilist.co/api"
let AUTHORIZE_URL = "\(BASE_URL)/auth/access_token"
let ANIME_BROWSE_URL = "\(BASE_URL)/browse/anime"

let AUTHORIZE_BODY = [
    "grant_type": "client_credentials",
    "client_id": "bbellkungdesu-vstku",
    "client_secret": "L5gVawdnzKUYaRWD3WioXZRq0rz"
]
let API_HEADER = [
    "Content-Type": "application/json",
    "Accept": "application/json"
]
var BEARER_HEADER: [String: String] {
    get {
        return [
            "Authorization": "Bearer \(AuthService.instance.anilistToken)",
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
    }
}

// Enum
enum SeasonType: String {
    case WINTER = "WINTER"
    case SPRING = "SPRING"
    case FALL = "FALL"
    case SUMMER = "SUMMER"
}
