//
//  ArticleData.swift
//  NYMPATests
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import XCTest

@testable import NYMPA

let constSampleArticleTitle = "I Was the Fastest Girl in America, Until I Joined Nike"
let constSampleArticleCount = 1
let constSampleArticlePubDate = "2019-11-07"

class DataTests: XCTestCase {
    
    func testParseEmptyNewsData() {
        
        // giving empty data
        let data = Data()
        
        // giving completion after parsing
        // expected valid NewsData with   valid Article data
        let completion : ((Result<NewsData, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        
        Parser.parse(data: data, completion: completion)
    }
    
    func testParseNewsData() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }
        
        // giving completion after parsing
        // expected valid converter with valid data
        let completion : ((Result<NewsData, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid newsData")
            case .success(let newsData):
                
                XCTAssertEqual(newsData.articles?.count, constSampleArticleCount, "Expected \(constSampleArticleCount)")
                XCTAssertEqual(newsData.articles?.first?.name, constSampleArticleTitle, "Expected \(constSampleArticleTitle)")
                if let date = newsData.articles?.first?.publishedDate
                {
                    XCTAssertEqual(Utilities.getStringFromDate(date: date), constSampleArticlePubDate, "Expected \(constSampleArticlePubDate)")
                }
            }
        }
        
        Parser.parse(data: data, completion: completion)
    }
    
    func testWrongKeyNewsData() {
        
        // giving a wrong dictionary
        let dictionary = ["test" : 123 as AnyObject]
        
        // expected to return error of NewsData
        let result = NewsData.parseObject(dictionary: dictionary)
        
        switch result {
        case .success(_):
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}

extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle(for: DataTests.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}
