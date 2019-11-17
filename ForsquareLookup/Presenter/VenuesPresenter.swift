//
//  VenuesPresenter.swift
//  ForsquareLookup
//
//  Created by Patryk Winowski on 16/11/2019.
//  Copyright © 2019 Patryk Winowski. All rights reserved.
//

import Foundation
import CoreLocation

class VenuesPresenter: NSObject {
    
    // next phase would be protocols instead of fixed classes,
    // leading to dependency injection, but let it be for now
    private let forsquare = ForsquareFacade()
    private let keeper = SecretsKeeper()
    private let locationManager = CLLocationManager()
    weak var viewDelegate: VenuesPresenterDelegate?
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func onVenueNameInput(_ name: String) {
        locationManager.requestLocation()
        do {
            let user = try keeper.getUserId()
            let secret = try keeper.getSecret()
            guard let locationCoords = locationManager.location?.coordinate else { return }
            
            forsquare.searchForVenues(named: name,
                                      location: locationCoords,
                                      userID: user,
                                      secret: secret){ (results: [Venue]) in
                                        self.rows = results.map {
                                            VenueRow(venue: $0)
                                        }
                                        
                                        self.viewDelegate?.refreshVenuesList()
            }
        }
        catch AuthenticationError.noUserRegistered {
            print("No user registered!")
        }
        catch AuthenticationError.keychaninNoSecretFound {
            print("Secred input needed")
        }
        catch {
            print(error)
            return
        }
    }
    
    public var rowsCount: Int = 0
    public var rows: [VenueRow] = []
}

struct VenueRow {
    let name: String
    let address: String
    let distance: String
    
    init(venue: Venue){
        name = venue.name
        address = venue.location.address
        distance = venue.location?.distance.description ?? "?"
    }
}

protocol VenuesPresenterDelegate: class {
    func refreshVenuesList()
}

extension VenuesPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
}
