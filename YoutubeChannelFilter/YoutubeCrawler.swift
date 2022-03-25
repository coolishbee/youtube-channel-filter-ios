//
//  YoutubeCrawler.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/03.
//

import Foundation
import SwiftSoup
import Alamofire

final class YoutubeCrawler {
    private let baseURL = "https://www.youtube.com/results?search_query="
    private init() {}
    static let shared = YoutubeCrawler()

    func fetchYoutubeReviews(query: String, completion: @escaping ([String?]) -> Void) {
        let searchQuery = query.split(separator: " ").joined(separator: "+")

        guard let encodedString = (baseURL + searchQuery)
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else { return }

        AF.request(url, method: .get).responseString { response in
            do {
                let htmlSource = try response.result.get()
                let script = try SwiftSoup.parse(htmlSource).select("body[dir]").select("script[nonce]").array()
                let filtered = try script.filter { element in
                    try element.html().contains("ytInitialData")
                }
                //print(filtered)

                if let jsonData = filtered.first {
                    let dataString = String(try jsonData.html()
                                                .replacingOccurrences(of: "var ytInitialData = ", with: "")
                                                .dropLast())
                    //print(dataString)
                    let data = Data(dataString.utf8)
                    let result = try JSONDecoder().decode(YoutubeCrawlingResult.self, from: data)
                    //var contentIndex = 0

                    let itemSectionRenderers = result.contents?.twoColumnSearchResultsRenderer?
                        .primaryContents?.sectionListRenderer?.contents
                    var videoIds = [String?]()

                    itemSectionRenderers?.forEach { sectionContent in
                        sectionContent.itemSectionRenderer?.contents?.forEach { videoContent in
                            videoIds.append(videoContent.videoRenderer?.videoId)
                            print(videoContent.videoRenderer?.videoId ?? "empty")
                        }
                    }
                    //print(videoIds)
                    completion(videoIds)
                }
            } catch {

            }
        }
    }
}
