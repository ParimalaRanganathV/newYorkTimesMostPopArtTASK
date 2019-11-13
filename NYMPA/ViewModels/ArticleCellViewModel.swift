//
//  ArticleCellViewModel.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import Foundation

struct ArticleCellViewModel
{
    var title:String!
    var imageUrl:String?
    var publishedDate:Date!
    var byLineString:String?
    var captionInfo:String?
    
    init(article:Article)
    {
        self.title = article.name
        self.imageUrl = article.imageUrl
        self.publishedDate = article.publishedDate
        self.byLineString = article.byLineString
        self.captionInfo = article.abstractInfo
    }
}
