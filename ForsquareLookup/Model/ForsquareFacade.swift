//
//  ForsquareFacade.swift
//  ForsquareLookup
//
//  Created by Patryk Winowski on 16/11/2019.
//  Copyright © 2019 Patryk Winowski. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class ForsquareFacade {
    
    private static let forsquareURLBase = "https://api.foursquare.com/v2/venues/search"
    private static let apiDate = "20191111"
    
    public func searchForVenues(named name: String,
                                location: CLLocationCoordinate2D,
                                userID: String,
                                secret: String,
                                completion: @escaping ([Venue]) -> Void) {

        guard let url = URL(string: ForsquareFacade.forsquareURLBase) else {
          completion([])
          return
        }
        
        let llString = "\(location.latitude),\(location.longitude)"
        
        let parameters: Parameters =
        [
            "intent": "checkin",
            "query": name,
            "ll": llString,
            "client_id": userID,
            "client_secret": secret,
            "v": ForsquareFacade.apiDate
        ]
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters)
        .validate()
        .responseJSON { response in
          switch response.result {
            case .success(let value):
                let json = JSON(value)
                var venues = [Venue]()
                for venueJson in json["response"]["venues"] {
                    venues.append(Venue(fromJson: venueJson.1))
                }
                completion(venues)
            
            case .failure(let error):
                print(error)
          }
        }
    }
}
