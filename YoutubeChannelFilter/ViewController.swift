//
//  ViewController.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/03.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
        
    var videoArray = [VideoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Logo")
        self.navigationItem.titleView = UIImageView(image: image)
        
        getYoutubeAPIData(query: "예린몸매") { [weak self] (data: [VideoData]) in
            self?.refreshTableData(newVids: data)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("tableView " + String(indexPath.row))
        let cell = Bundle.main.loadNibNamed("VideoTableCell", owner: self, options: nil)?.first as! VideoTableCell
        cell.title.text = self.videoArray[indexPath.row].title
        cell.title.sizeToFit()
        cell.channel.text = self.videoArray[indexPath.row].channel
        cell.date.text = self.videoArray[indexPath.row].date
        let img = self.videoArray[indexPath.row].videoImg
        cell.videoImg.sd_setImage(with: URL(string: img), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        
        
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
    
    private func getYoutubeAPIData(query: String,
                                   completion: @escaping ((_ data: [VideoData]) -> Void)
    ) {
        var videos = [VideoData]()
        
        YoutubeAPIClient.shared.search(query: "예린몸매") {
            (res: DataResponse<YoutubeSearchResult, AFError>) in
            
            do{
                let result = try JSONDecoder().decode(YoutubeSearchResult.self, from: res.data!)
                
                for item in result.items {
                    //print(item)
                    let videoData : VideoData = VideoData()
                    videoData.id = item.id.videoId
                    videoData.title = item.snippet.title
                    videoData.channel = item.snippet.channelTitle
                    videoData.date = self.parseDate(date: item.snippet.publishedAt)
                    videoData.videoImg = item.snippet.thumbnails.high.url
                    
                    videos.append(videoData)
                }
                completion(videos)
            }catch{
                print("parsing error!!")
            }
        }
    }
    
    func refreshTableData(newVids: [VideoData])
    {
        self.videoArray = newVids
        print("Updating Videos, First title: ")
        print(self.videoArray.count)
        self.table.reloadData()
    }
    
    func parseDate(date: String) -> String
    {
        let indexT = date.firstIndex(of: "T")
        let shortDate = String(date[...date.index(before: indexT!)])
        return "Uploaded on: "+shortDate
    }
}

