//
//  FlightListTableViewCell.swift
//  FlightCentre
//
//  Created by Dharmil Raval on 8/2/21.
//

import Foundation
import UIKit

class FlightListTableViewCell: UITableViewCell {
    
    // MARK: - Labels
    @IBOutlet weak var flightTo: UILabel!
    @IBOutlet weak var departureAirport: UILabel!
    @IBOutlet weak var arrivalAirport: UILabel!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var departureCity: UILabel!
    @IBOutlet weak var arrivalCity: UILabel!
    @IBOutlet weak var scheduledDuration: UILabel!
    
    
    //MARK: - Loading data into cells
    func setFlightData(flightList: FlightList) {
        
        scheduledDuration.text = flightList.scheduledDuration
        
        departureAirport.text = flightList.departureAirport
        arrivalAirport.text = flightList.arrivalAirport
        
        ///Formatting date into specified format
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let departureDate = dateFormatter.date(from: flightList.departureDate) {
            dateFormatter.dateFormat = "HH:mm"
            departureTime.text = dateFormatter.string(from: departureDate)
        }
        if let arrivalDate = dateFormatter.date(from: flightList.arrivalDate) {
            dateFormatter.dateFormat = "HH:mm"
            arrivalTime.text = dateFormatter.string(from: arrivalDate)
        }
        
        ///Extracting city name
        let splitDepartureCity = flightList.departureCity.components(separatedBy: ", ")
        departureCity.text = splitDepartureCity[0]
        
        let splitArrivalCity = flightList.arrivalCity.components(separatedBy: ", ")
        arrivalCity.text = splitArrivalCity[0]
        
        flightTo.text = "Flight to " + splitArrivalCity[0]
    }
}
