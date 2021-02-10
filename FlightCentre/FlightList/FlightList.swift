//
//  FlightList.swift
//  FlightCentre
//
//  Created by Dharmil Raval on 8/2/21.
//

import Foundation
import Alamofire

struct FlightList {
    
    // MARK: - Properties
    var id = 0
    var departureDate = ""
    var airlineCode = ""
    var flightNumber = ""
    var departureCity = ""
    var departureAirport = ""
    var arrivalCity = ""
    var arrivalAirport = ""
    var scheduledDuration = ""
    var arrivalDate = ""
    
    //MARK: - Initializer
    init?(rawApiData: [String : Any]) {
        
        if let id = rawApiData["id"] as? Int {
            self.id = id
        }
        
        if let departureDate = rawApiData["departure_date"] as? String {
            self.departureDate = departureDate
        }
        
        if let airlineCode = rawApiData["airline_code"] as? String {
            self.airlineCode = airlineCode
        }
        
        if let flightNumber = rawApiData["flight_number"] as? String {
            self.flightNumber = flightNumber
        }
        
        if let departureCity = rawApiData["departure_city"] as? String {
            self.departureCity = departureCity
        }
        
        if let departureAirport = rawApiData["departure_airport"] as? String {
            self.departureAirport = departureAirport
        }
        
        if let arrivalCity = rawApiData["arrival_city"] as? String {
            self.arrivalCity = arrivalCity
        }
        
        if let arrivalAirport = rawApiData["arrival_airport"] as? String {
            self.arrivalAirport = arrivalAirport
        }
        
        if let scheduledDuration = rawApiData["scheduled_duration"] as? String {
            self.scheduledDuration = scheduledDuration
        }
        
        if let arrivalDate = rawApiData["arrival_date"] as? String {
            self.arrivalDate = arrivalDate
        }
        
    }
    
    //MARK: - Methods
    static func getItems(items: [[String : Any]]) -> [FlightList] {
        var arrayOfItems = [FlightList]()
        for item in items {
            if let item = FlightList(rawApiData: item) {
                arrayOfItems.append(item)
            }
        }
        return arrayOfItems
    }
    ///API call to retrieve data
    static func getData(callBack: @escaping (_ error: Error?, [FlightList]?) -> Void) {
        AF.request( "https://firebasestorage.googleapis.com/v0/b/flight-centre-brand.appspot.com/o/developer-test-flights-list.json?alt=media&token=81d93056-9c7f-451d-94b6-3e88eb6fa9ad", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                switch response.result {
                
                case .success(let json):
                    callBack(nil, FlightList.getItems(items: json as! [[String : Any]]))
                    
                case .failure(let error):
                    print(error)
                    callBack(error, nil)
                }
            }
    }
}
