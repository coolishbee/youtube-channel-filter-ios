//
//  VideoData.swift
//  YoutubeChannelFilter
//
//  Created by gamepub on 2022/04/21.
//

import Foundation

class VideoData {
    
    public var id: String
    public var title: String
    public var videoImg: String
    public var channel: String
    public var duration: String
    public var date: String
    
    init(id: String,
         title: String,
         videoImg: String,
         channel: String,
         duration: String,
         date: String)
    {
        self.id = id
        self.title = title
        self.videoImg = videoImg
        self.channel = channel
        self.duration = duration
        self.date = date
    }
    
    init() {
        self.id = ""
        self.title = ""
        self.videoImg = ""
        self.channel = ""
        self.duration = ""
        self.date = ""
    }
    
}
