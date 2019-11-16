//
//  VenueLabeledLatLng.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 16, 2019

import Foundation
import SwiftyJSON


class VenueLabeledLatLng : NSObject, NSCoding{

    var label : String!
    var lat : Float!
    var lng : Float!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        label = json["label"].stringValue
        lat = json["lat"].floatValue
        lng = json["lng"].floatValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if label != nil{
            dictionary["label"] = label
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if lng != nil{
            dictionary["lng"] = lng
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        label = aDecoder.decodeObject(forKey: "label") as? String
        lat = aDecoder.decodeObject(forKey: "lat") as? Float
        lng = aDecoder.decodeObject(forKey: "lng") as? Float
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if label != nil{
            aCoder.encode(label, forKey: "label")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lng != nil{
            aCoder.encode(lng, forKey: "lng")
        }

    }

}
