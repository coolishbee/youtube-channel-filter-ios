//
//  ViewController.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/03.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("view load")
        YoutubeCrawler.shared.fetchYoutubeReviews()
        
        
        
    }        

    

}

