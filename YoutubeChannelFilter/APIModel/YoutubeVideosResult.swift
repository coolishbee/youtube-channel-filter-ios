//
//  YoutubeVideosResult.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/15.
//

import Foundation

struct YoutubeVideosResult: Decodable {
    let items: [YoutubeVideosResult.VideoItem]

    struct VideoItem: Decodable {
        let id: String
        let snippet: YoutubeVideosResult.Snippet
    }

    struct Snippet: Decodable {
        let title: String
        let channelTitle: String
        let thumbnails: YoutubeVideosResult.Thumbnails
    }

    struct Thumbnails: Decodable {
        let `default`: YoutubeVideosResult.Thumbnail
        let medium: YoutubeVideosResult.Thumbnail
        let high: YoutubeVideosResult.Thumbnail
    }

    struct Thumbnail: Decodable {
        let url: String
        let width: Int
        let height: Int
    }
}
