//
//  YoutubeCrawlingResult.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/03.
//

import Foundation

struct YoutubeCrawlingResult: Decodable {
    let contents: YoutubeCrawlingContent?

    struct YoutubeCrawlingContent: Decodable {
        let twoColumnSearchResultsRenderer: TwoColumnSearchResultsRenderer?
    }

    struct TwoColumnSearchResultsRenderer: Decodable {
        let primaryContents: PrimaryContent?
    }

    struct PrimaryContent: Decodable {
        let sectionListRenderer: SectionListRenderer?
    }

    struct SectionListRenderer: Decodable {
        let contents: [SectionListRendererContent]?
    }

    struct SectionListRendererContent: Decodable {
        let itemSectionRenderer: ItemSectionRenderer?
    }

    struct ItemSectionRenderer: Decodable {
        let contents: [VideoContent]?
    }

    struct VideoContent: Decodable {
        let videoRenderer: VideoRenderer?
    }

    struct VideoRenderer: Decodable {
        let videoId: String?
    }
}
