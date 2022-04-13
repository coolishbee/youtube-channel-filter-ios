//
//  YoutubeSearchResult.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/15.
//

import Foundation

struct YoutubeSearchResult: Decodable {
    let items: [YoutubeSearchResult.VideoItem]

    struct VideoItem: Decodable {
        let id: Id
        let snippet: YoutubeSearchResult.Snippet
    }

    struct Id: Decodable {
        let videoId: String
    }

    struct Snippet: Decodable {
        let title: String
        let publishedAt: String
        let description: String
        let channelTitle: String
        let thumbnails: YoutubeSearchResult.Thumbnails
    }

    struct Thumbnails: Decodable {
        let `default`: YoutubeSearchResult.Thumbnail
        let medium: YoutubeSearchResult.Thumbnail
        let high: YoutubeSearchResult.Thumbnail
    }

    struct Thumbnail: Decodable {
        let url: String
        let width: Int
        let height: Int
    }
}
