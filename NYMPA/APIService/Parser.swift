//
//  Parser.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import Foundation

protocol Parsable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class Parser {
    
    static func parse<T: Parsable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        do {
            
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                
                // init final result
                // check foreach dictionary if parseable
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }
                
                
            } else {
                NSLog("Json data is not an array")
                completion(.failure(.parser(string:constAPIParseErrorMessgae)))
            }
        } catch {
            // can't parse json
            NSLog("Error while parsing json data")
            completion(.failure(.parser(string:constAPIParseErrorMessgae)))
        }
    }
}
