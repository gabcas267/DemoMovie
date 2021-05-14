//
//  MovieVideo.swift
//  DemoMovie
//
//  Created by Gabriel Castillo on 5/14/21.
//

import Foundation

struct MovieVideos: Codable {
    let listOfVideos: [MovieVideo]
    
    enum CodingKeys: String, CodingKey {
        case listOfVideos = "results"
    }
}

struct MovieVideo: Codable {
    
    let key: String
    let site: String
    
}
