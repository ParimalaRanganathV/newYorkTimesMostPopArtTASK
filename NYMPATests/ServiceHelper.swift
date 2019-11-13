//
//  ServiceHelper.swift
//  NYMPATests
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import XCTest

@testable import NYMPA

class ServiceHelperTests: XCTestCase {
    
    func testCancelRequest() {
        
        // giving a "previous" session
        ServiceHelper.shared.fetchArticles { (_) in
            // ignore call
        }
        
        // Expected to task nil after cancel
        ServiceHelper.shared.cancelFetchArticles()
        XCTAssertNil(ServiceHelper.shared.task, "Expected task nil")
    }
}
