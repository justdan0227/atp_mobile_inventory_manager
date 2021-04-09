//
//  ATPPartsObject.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class  ATPPartsObject {
    
    /*
     {
         "id": 1,
         "cost": 7.99,
         "partNumber": "158CDWS1",
         "name": "Grip-Rite 158CDWS1 1-5/8-Inch 6 Coarse Thread Drywall Screw with Bugle Head, 1 Pound",
         "description": "Exclusive FILTECH media technology screens out more harmful contaminants for greater engine protection. Strong steel base plates and housings prevent warpage, leaks and poor fit. Silicone anti-drain back valve ensures a supply of clean oil when the car is started. High lubricity gasket design provides a tight seal, yet easy removal. Double-locked rolled seam forms a leak free canister.",
         "isActive": true,
         "image": "http://localhost:9001/images/drywallscrews.jpg",
         "inStock": 3,
         "_id": "8506bca8ae95491a83f1ed68091b7294"
       },
     */
    var id: String = ""
    var cost: Double = 0.0
    var partNumber: String = ""
    var name: String = ""
    var description: String = ""
    var isActive: Bool = true
    var imageURL: String = ""
    var inStock: Int = 0
    var _id = ""
    
    //mutating func getCurrentWeather(city: String, state: String, completion: @escaping(_ success : Bool) ->
    
    func getPart(partNumber: String, completion: @escaping(_ success : Bool, _ returnedPart: ATPPartsObject) -> Void) {
        
    }
                                        
    
    static func getAllParts( completion: @escaping(_ success : Bool, _ returnedArray:[ATPPartsObject]) -> Void) {

        //var urlString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let ATP_DB_URL = "http://localhost:9001/parts"
            //.0/current?&city=\(urlString!),\(state)&units=I&key=e50d1fe4b2b9400da6ae9cefd514257c"
 
//        let parameters2 = ["postal_code": postal_code, "units": "I", "key":"e50d1fe4b2b9400da6ae9cefd514257c"]
        
        let parameters = ["id":"value"]

        AF.request(ATP_DB_URL, parameters: parameters).responseJSON { response in
            
            let json = JSON(response.value as Any)
//
            var newArray: [ATPPartsObject] = []
            
            let arrayCount = json.array?.count ?? 0
            for i in 0..<arrayCount {
                let returnedPart:ATPPartsObject = ATPPartsObject()
                
                returnedPart.name = json[i]["name"].stringValue
                returnedPart.partNumber = json[i]["partNumber"].stringValue
                returnedPart.inStock = json[i]["inStock"].intValue
                returnedPart.description = json[i]["description"].stringValue
                returnedPart.imageURL = json[i]["image"].stringValue
                newArray.append(returnedPart)

            }
                        
//
//            self.date = currentDateFromUnix(unixDate: json["data"][0]["ts"].double) ?? Date()
//            self.weatherType = json["data"][0]["weather"]["description"].stringValue
//
//            self.currentTemp = getTempBasedOnSettings(celsius: json["data"][0]["temp"].double ?? 0.0)
//            self.feelsLike = getTempBasedOnSettings(celsius: json["data"][0]["app_temp"].double ?? 0.0)
//            self.pressure = json["data"][0]["pres"].double
//            self.humidity = json["data"][0]["rh"].doubleValue
//            self.windSpeed = json["data"][0]["wind_spd"].double
//            self.weatherIcon = json["data"][0]["weather"]["icon"].stringValue
//            self.visibility = json["data"][0]["vis"].double
//            self.uv = json["data"][0]["uv"].doubleValue
//            self.sunrise = json["data"][0]["sunrise"].string
//            self.sunset = json["data"][0]["sunset"].string

            completion(true, newArray)
        }
//        } else {
//
//            completion(false)
//            print("no result found for current location")
//        }
    }
}
