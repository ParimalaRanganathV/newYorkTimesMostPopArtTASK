//
//  Utilities.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import Foundation
import Reachability

class Utilities
{
    static func isOnline() -> Bool {
        return (Reachability()?.connection != .none)
    }
    
    static func getDateFromString(dateString:String) -> NSDate?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:dateString) else {
            NSLog(" Conversion failed ")
            return NSDate()
        }
        return date as NSDate
    }
    
    static func getStringFromDate(date:Date) -> String?
    {
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyy-MM-dd"
        let newD = dateF.string(from: date)
        return newD
    }
    
    
}
