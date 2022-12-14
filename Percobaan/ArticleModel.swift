//
//  ArticleService.swift
//  Percobaan
//
//  Created by Daninsyah Bagas Abiyansa on 27/08/22.
//

import Foundation
import Foundation

struct ArticleModel: Decodable {
    var totalResults:Int?
    let articles:[Article]?
}
struct Article : Decodable {
    let author:String?
    let title:String?
    let description:String?
    let url:String?
    var urlToImage:String?
    let publishedAt:String?
    let content:String?
}

