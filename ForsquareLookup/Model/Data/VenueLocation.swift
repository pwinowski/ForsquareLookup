//
//  VenueLocation.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 16, 2019

import Foundation
import SwiftyJSON


class VenueLocation : NSObject, NSCoding{

    var address : String!
    var cc : String!
    var city : String!
    var country : String!
    var crossStreet : String!
    var distance : Int!
    var formattedAddress : [String]!
    var labeledLatLngs : [VenueLabeledLatLng]!
    var lat : Float!
    var lng : Float!
    var postalCode : String!
    var state : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        cc = json["cc"].stringValue
        city = json["city"].stringValue
        country = json["country"].stringValue
        crossStreet = json["crossStreet"].stringValue
        distance = json["distance"].intValue
        formattedAddress = []
        let formattedAddressArray = json["formattedAddress"].arrayValue
        for formattedAddressJson in formattedAddressArray{
            formattedAddress.append(formattedAddressJson.stringValue)
        }
        labeledLatLngs = [VenueLabeledLatLng]()
        let labeledLatLngsArray = json["labeledLatLngs"].arrayValue
        for labeledLatLngsJson in labeledLatLngsArray{
            let value = VenueLabeledLatLng(fromJson: labeledLatLngsJson)
            labeledLatLngs.append(value)
        }
        lat = json["lat"].floatValue
        lng = json["lng"].floatValue
        postalCode = json["postalCode"].stringValue
        state = json["state"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if cc != nil{
            dictionary["cc"] = cc
        }
        if city != nil{
            dictionary["city"] = city
        }
        if country != nil{
            dictionary["country"] = country
        }
        if crossStreet != nil{
            dictionary["crossStreet"] = crossStreet
        }
        if distance != nil{
            dictionary["distance"] = distance
        }
        if formattedAddress != nil{
            dictionary["formattedAddress"] = formattedAddress
        }
        if labeledLatLngs != nil{
        var dictionaryElements = [[String:Any]]()
        for labeledLatLngsElement in labeledLatLngs {
            dictionaryElements.append(labeledLatLngsElement.toDictionary())
        }
        dictionary["labeledLatLngs"] = dictionaryElements
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if lng != nil{
            dictionary["lng"] = lng
        }
        if postalCode != nil{
            dictionary["postalCode"] = postalCode
        }
        if state != nil{
            dictionary["state"] = state
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? String
        cc = aDecoder.decodeObject(forKey: "cc") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        country = aDecoder.decodeObject(forKey: "country") as? String
        crossStreet = aDecoder.decodeObject(forKey: "crossStreet") as? String
        distance = aDecoder.decodeObject(forKey: "distance") as? Int
        formattedAddress = aDecoder.decodeObject(forKey: "formattedAddress") as? [String]
        labeledLatLngs = aDecoder.decodeObject(forKey: "labeledLatLngs") as? [VenueLabeledLatLng]
        lat = aDecoder.decodeObject(forKey: "lat") as? Float
        lng = aDecoder.decodeObject(forKey: "lng") as? Float
        postalCode = aDecoder.decodeObject(forKey: "postalCode") as? String
        state = aDecoder.decodeObject(forKey: "state") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if cc != nil{
            aCoder.encode(cc, forKey: "cc")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if crossStreet != nil{
            aCoder.encode(crossStreet, forKey: "crossStreet")
        }
        if distance != nil{
            aCoder.encode(distance, forKey: "distance")
        }
        if formattedAddress != nil{
            aCoder.encode(formattedAddress, forKey: "formattedAddress")
        }
        if labeledLatLngs != nil{
            aCoder.encode(labeledLatLngs, forKey: "labeledLatLngs")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lng != nil{
            aCoder.encode(lng, forKey: "lng")
        }
        if postalCode != nil{
            aCoder.encode(postalCode, forKey: "postalCode")
        }
        if state != nil{
            aCoder.encode(state, forKey: "state")
        }

    }

}
