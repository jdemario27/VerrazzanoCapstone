//
//  Movie.swift
//  Extracts all movie data from the API
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 2/27/22.
//

import Foundation

//Codable is a type alias for encoder and decoder protocol

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
