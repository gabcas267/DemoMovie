//
//  Enums.swift
//  DemoMovie
//
//  Created by Gabriel Castillo on 5/13/21.
//

import UIKit

enum MovieState: Int {
    case popular = 0
    case topRated
    case upcoming
    
    func getUrlString() -> String {
        switch self {
        case .popular:
            return WebServicesURL.popularMovies
        case .topRated:
            return WebServicesURL.topRatedMovies
        case .upcoming:
            return WebServicesURL.upComingMovies
        }
    }
}
