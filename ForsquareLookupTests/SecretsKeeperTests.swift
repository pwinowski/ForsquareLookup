//
//  SecretsKeeperTests.swift
//  ForsquareLookupTests
//
//  Created by Patryk Winowski on 17/11/2019.
//  Copyright © 2019 Patryk Winowski. All rights reserved.
//

import XCTest
@testable import ForsquareLookup

/* Note!  Because of the requirement of not storing the secret string on the git repo,
    This test requires to store userID and userSecret manually by running the app after a fresh install */

class SecretsKeeperTests: XCTestCase {
    
    let keeper = SecretsKeeper()

    func testgettingUserId() {
        let id = try? keeper.getUserId()
        XCTAssertNotNil(id)
    }
    
    func testgettingUserSecret() {
        let secret = try? keeper.getSecret()
        XCTAssertNotNil(secret)
    }

}
