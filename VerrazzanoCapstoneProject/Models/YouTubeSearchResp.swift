//
//  YouTubeSearchResp.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 3/2/22.
//

import Foundation

struct YouTubeSearchResults: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
