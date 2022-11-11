//
//  YoutubeResult.swift
//  Netflix
//
//  Created by Gadirli on 05.11.22.
//

import Foundation

struct YoutubeResult: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let videoId: String
}
