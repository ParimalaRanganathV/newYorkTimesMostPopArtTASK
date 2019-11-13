//
//  Article.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import Foundation

struct NewsData {
    var articles: [Article]?
}

extension NewsData: Parsable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<NewsData, ErrorResult> {
        if let results = dictionary["results"] as? [[String: Any]] {
            let articles = results.map({ Article(articleDict: $0)}).compactMap{$0}
            let meta = NewsData(articles: articles)
            return Result.success(meta)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse API response"))
        }
    }
}

struct Article
{
    var name:String!
    var imageUrl:String?
    var publishedDate:Date!
    var byLineString:String?
    var abstractInfo:String?
    
    
    init?(articleDict:Dictionary<String,Any>)
    {
        guard let _ = articleDict["title"] as? String else {
            return nil
        }
        
        self.name = articleDict[constServerDataJSONKeyTitle] as! String
        self.byLineString = articleDict[constServerDataJSONKeyByLine] as? String
        self.abstractInfo = articleDict[constServerDataJSONKeyAbstract] as? String
        
        if let dateString = articleDict[constServerDataJSONKeyPublishedDate] as? String {
            self.publishedDate = Utilities.getDateFromString(dateString: dateString)! as Date
        }
        
        if let media = articleDict[constServerDataJSONKeyMedia] as? [Dictionary<String,Any>] {
            if let media_metaData = media.first?[constServerDataJSONKeyMediaMetaData] as? [Dictionary<String,Any>] {
                self.imageUrl = media_metaData.first?[constServerDataJSONKeyImageURL] as? String
            }
        }
    }
}
