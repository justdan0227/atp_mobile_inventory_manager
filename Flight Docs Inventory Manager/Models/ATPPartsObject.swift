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
    //var cost: Decimal = 0.0
    var partNumber: String = ""
    var name: String = ""
    var description: String = ""
    var isActive: Bool = true
    var imageURL: String = ""
    var inStock: Int = 0
    var _id = ""
    
    static let ATP_DB_URL = "http://localhost:9001/parts"
    
    //mutating func getCurrentWeather(city: String, state: String, completion: @escaping(_ success : Bool) ->
    
    func getPart(partNumber: String, completion: @escaping(_ success : Bool, _ returnedPart: ATPPartsObject) -> Void) {
        
    }
                                        
    static func getAllParts( completion: @escaping(_ success : Bool, _ returnedArray:[ATPPartsObject]) -> Void) {

        //var urlString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let parameters = ["id":"value"]

        AF.request(ATP_DB_URL, parameters: parameters).responseJSON { response in
            
            let json = JSON(response.value as Any)

            var newArray: [ATPPartsObject] = []
            
            let arrayCount = json.array?.count ?? 0
            for i in 0..<arrayCount {
                let returnedPart:ATPPartsObject = ATPPartsObject()
                
                returnedPart.id = json[i]["id"].stringValue
                returnedPart.name = json[i]["name"].stringValue
                returnedPart.partNumber = json[i]["partNumber"].stringValue
                returnedPart.inStock = json[i]["inStock"].intValue
                returnedPart.description = json[i]["description"].stringValue
                returnedPart.imageURL = json[i]["image"].stringValue
                returnedPart.cost = json[i]["cost"].doubleValue
                returnedPart.isActive = json[i]["isActive"].boolValue
                newArray.append(returnedPart)

            }
                        
            completion(true, newArray)
        }
    }
    
    static func createNewPart(newATPPartObject: ATPPartsObject,  completion: @escaping(_ success : Bool) -> Void) {

        let parameters = [
            "cost":newATPPartObject.cost,
            "name":newATPPartObject.name,
            "partNumber":newATPPartObject.partNumber,
            "description":newATPPartObject.description,
            "inStock": newATPPartObject.inStock,
            "image": newATPPartObject.imageURL,
            "isActive": newATPPartObject.isActive
        ] as [String : Any]

        
        AF.request(ATP_DB_URL,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: nil).responseJSON { response  in
            
                    debugPrint(response.result)
        }
        
            completion(true)
        }
    
    static func updatePart(updatedATPPartObject: ATPPartsObject,  completion: @escaping(_ success : Bool) -> Void) {

        let parameters = [
            "id":updatedATPPartObject.id,
            "cost":updatedATPPartObject.cost,
            "name":updatedATPPartObject.name,
            "partNumber":updatedATPPartObject.partNumber,
            "description":updatedATPPartObject.description,
            "inStock": updatedATPPartObject.inStock,
            "image": updatedATPPartObject.imageURL,
            "isActive": updatedATPPartObject.isActive
        ] as [String : Any]

        
        let urlString  = ATP_DB_URL+"/"+updatedATPPartObject.id
        
        AF.request(urlString,
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: nil).responseJSON { response  in
            
                    debugPrint(response.result)
        }
        
            completion(true)
        }
}
