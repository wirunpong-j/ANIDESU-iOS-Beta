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
let SEGUE_HOME = "toHome"
let SEGUE_CREATE_POST = "toCreatePost"
let SEGUE_REVIEW_DETAIL = "toReviewDetail"
let SEGUE_ANIME_DETAIL = "toAnimeDetail"
let SEGUE_ADD_MY_ANIME_LIST = "toAddMyAnimeList"

// Reuse Cell
let POST_CELL = "postCell"
let ANIME_CELL = "animeCell"
let MY_ANIME_LIST_CELL = "myAnimeListCell"
let PRE_POST_CELL = "prePostCell"
let REVIEW_CELL = "reviewCell"
let USER_PROFILE_CELL = "userProfileCell"
let EXTERNAL_LINK_CELL = "externalLinkCell"
let CHARACTER_CELL = "characterCell"
let STAFF_CELL = "staffCell"

// User default key
let LOGGED_IN_KEY = "logged"
let TOKEN_KEY = "token"
let ANILIST_TOKEN_KEY = "anilistToken"
let USER_ID_KEY = "uid"

// Anilist APIs
let BASE_URL = "https://anilist.co/api"
let AUTHORIZE_URL = "\(BASE_URL)/auth/access_token"
let ANIME_BROWSE_URL = "\(BASE_URL)/browse/anime"
let ANIME_PAGE_URL = "\(BASE_URL)/anime"

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
enum StatusType: String {
    case PLAN_TO_WATCH = "Plan To Watch"
    case WATCHING = "Watching"
    case COMPLETED = "Completed"
    case DROPPED = "Dropped"
}
