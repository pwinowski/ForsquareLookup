//
//  Venue.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 16, 2019

import Foundation
import SwiftyJSON


class Venue : NSObject, NSCoding{

    var id : String!
    var location : VenueLocation!
    var name : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].stringValue
        let locationJson = json["location"]
        if !locationJson.isEmpty{
            location = VenueLocation(fromJson: locationJson)
        }
        name = json["name"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if location != nil{
            dictionary["location"] = location.toDictionary()
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? String
        location = aDecoder.decodeObject(forKey: "location") as? VenueLocation
        name = aDecoder.decodeObject(forKey: "name") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }

    }

}
