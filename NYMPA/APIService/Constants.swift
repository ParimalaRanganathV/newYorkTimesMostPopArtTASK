//
//  Constants.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import Foundation
import UIKit


//Storyboard ID's
let constArticleCellID = "ArticleCellID"
let constNewDetailSegue = "DetailsSegue"


//String constants
let constNewsTitleString = "New York Times Most Popular Articles"
let constNoNetworkErrorMessgae = "Please check your internet setting and try again."
let constNetworkErrorMessgae = "Network error occurred!, please try after some time"
let constAPIParseErrorMessgae = "An error occurred while processing response!. Please check your internet setting and try again later"

//API response keys
let constServerDataJSONKeyTitle:String  = "title"
let constServerDataJSONKeyByLine:String  = "byline"
let constServerDataJSONKeyPublishedDate:String  = "published_date"
let constServerDataJSONKeyMedia:String  = "media"
let constServerDataJSONKeyResult:String  = "results"
let constServerDataJSONKeyAbstract:String  = "abstract"
let constServerDataJSONKeyMediaMetaData:String  = "media-metadata"
let constServerDataJSONKeyImageURL:String  = "url"

// API URLS
let constAPIKey = "75RmhIFvnwAA4z62cCwOMXuIecrpAXBg"
let constAPIPeriods:Int = 7
let constAPISections = "all-sections"
let constBASE_URL: String = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/"

let constAPI_URL = constBASE_URL + "/\(constAPISections)" + "/\(constAPIPeriods)" + ".json?api-key=\(constAPIKey)"


