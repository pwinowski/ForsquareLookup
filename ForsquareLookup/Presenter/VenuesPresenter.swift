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
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func onVenueNameInput(_ name: String) {
        do {
            let user = try keeper.getUserId()
            let secret = try keeper.getSecret()
            let locationCoords = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 54.404332, longitude: 18.570695)
            
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
            viewDelegate?.askForCredentials(completion: { (user: String, secret: String) in
                try? self.keeper.storeSecret(secret, forUserId: user)
            })
        }
        catch AuthenticationError.keychaninNoSecretFound {
            print("Secred input needed")
            viewDelegate?.askForCredentials(completion: { (user: String, secret: String) in
                try? self.keeper.storeSecret(secret, forUserId: user)
            })
        }
        catch {
            print(error)
            return
        }
    }
    
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
    func askForCredentials(completion: @escaping (String, String) -> Void)
}

extension VenuesPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
}
