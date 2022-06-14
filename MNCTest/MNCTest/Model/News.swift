//
//  News.swift
//  MNCTest
//
//  Created by Dimas Syuhada on 14/06/22.
//

import Foundation

struct NewsData: Decodable {
    
    let id: String
    let title: String
    let content: String
    let contributorName: String
    let contentThumbnail: String
    let createdAt: String
    
}

struct News: Decodable {
    var news: [NewsData]
}
