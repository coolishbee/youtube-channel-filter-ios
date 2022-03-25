//
//  ViewController.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/03.
//

import UIKit
import Alamofire
import SwiftSoup

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    
    private var youtubeResults = [YoutubeVideosResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Logo")
        self.navigationItem.titleView = UIImageView(image: image)        
        
        print("view load")
        YoutubeCrawler.shared.fetchYoutubeReviews(query: "주라벨",
                                                  completion: youtubeVideoIdFetchCompletion(videoIds:))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtubeResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("tableView load")
        let cell = Bundle.main.loadNibNamed("VideoTableCell", owner: self, options: nil)?.first as! VideoTableCell

//        let map = youtubeResults.map { $0 }
//        let compactmap = youtubeResults.compactMap { $0 }
//        print(map)
//        print(compactmap)
        cell.title.text = "20년차 예비역의 안산길 무장구보 (20kg)"
        cell.channel.text = "soonki Hong"
        cell.date.text = "1개월 전"
        cell.duration.text = "3:07"
        
        cell.videoImg.image = #imageLiteral(resourceName: "4")
        cell.type.image = #imageLiteral(resourceName: "movie") //Meaning Solo Video or Movie
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        print("User Selected: ", String(index))
    }
    
    
    private func youtubeVideoIdFetchCompletion(videoIds: [String?]) {
        let videoIdsWithoutNil = videoIds.compactMap { $0 }

        videoIdsWithoutNil.enumerated().forEach { index, videoId in
            YoutubeAPIClient.shared.fetchYoutubeVideoById(videoId: videoId) { [weak self]
                (response: DataResponse<YoutubeVideosResult, AFError>) in
                guard let self = self else { return }
                do {
                    let result = try JSONDecoder().decode(YoutubeVideosResult.self, from: response.data!)
                    self.youtubeResults.append(result)
                } catch {

                }
                if index == videoIdsWithoutNil.count - 1 {
                    print("load complete")
                    self.table.reloadData()
                }
            }
        }
    }
}

