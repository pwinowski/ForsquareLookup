//
//  ForsquareFacadeTests.swift
//  ForsquareLookupTests
//
//  Created by Patryk Winowski on 17/11/2019.
//  Copyright © 2019 Patryk Winowski. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ForsquareLookup

/* Note!  Because of the requirement of not storing the secret string on the git repo,
This test requires to store userID and userSecret manually by running the app after a fresh install */
class ForsquareFacadeTests: XCTestCase {
    
    let facade = ForsquareFacade()
    let keeper = SecretsKeeper()


    func testSearchValidParameters() {
        let location = CLLocationCoordinate2D(latitude: 54.408905, longitude: 18.575696)
        guard let user = try? keeper.getUserId(), let secret = try? keeper.getSecret() else {
            return XCTFail("Couldn't get credentials")
        }
        
        let expectation = XCTestExpectation(description: "Download McDonald venues list")
        
        facade.searchForVenues(named: "McDonald", location: location, userID: user, secret: secret) { results in
            guard let venue = results.first else {
                return XCTFail("No results, while expected any")
            }
            XCTAssert(venue.name.contains("McDonald"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

}
