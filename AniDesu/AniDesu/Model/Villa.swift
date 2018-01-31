//
//  Villa.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 30/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

struct Villa {
    
    let country: String
    let locality: String
    let description: String
    let title: String
    let imageName: String
    
    init(country: String, locality: String, description: String, title: String, imageName: String) {
        self.country = country
        self.locality = locality
        self.description = description
        self.title = title
        self.imageName = imageName
    }
}

extension Villa {
    static var testData: [Villa] {
        return [
            Villa(country: "Swiss", locality: "Swiss Alps", description: "This residential project was recently completed by D4 Designs, a multi-award winning design practice founded in 2000 by Douglas Paton.", title: "a's Villa", imageName: "banner"),
            Villa(country: "France", locality: "Les Houches", description: "A special charm is given by the dark rectangular box above the main entrance.", title: "b's Villa", imageName: "banner"),
            Villa(country: "Austria", locality: "Vienna", description: "A wooden table and a beige stuffed couch in front of plasma, this is definitely a good place to spend your afternoons watching movies with your family.", title: "c's Villa", imageName: "banner")
        ]
    }
}
