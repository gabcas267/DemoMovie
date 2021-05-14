//
//  Constants.swift
//  DemoMovie
//
//  Created by Gabriel Castillo on 5/13/21.
//

import Foundation

struct WebServicesURL {
    
    private static let apiKey       = "?api_key=f799e3986674237899820af4855fc705"
    private static let main         = "https://api.themoviedb.org/"
    private static let urlImage     = "https://image.tmdb.org/t/p/w200"
    private static let youtube      = "https://www.youtube.com/embed/"

    static let popularMovies    = main + "3/movie/popular" + apiKey
    static let topRatedMovies   = main + "3/movie/top_rated" + apiKey
    static let upComingMovies   = main + "3/movie/upcoming" + apiKey
    
    static func detailMovie(_ idMovie: Int) -> String {
        main + "3/movie/\(idMovie)" + apiKey
    }
    
    static func videoMovie(_ idMovie: Int) -> String {
        main + "3/movie/\(idMovie)/videos" + apiKey
    }
    
    static func youtubeURl(_ endPoint: String) -> String {
        youtube + endPoint
    }
    
    static func urlImages(_ endPoint: String) -> String {
        urlImage + endPoint
    }
    
}
