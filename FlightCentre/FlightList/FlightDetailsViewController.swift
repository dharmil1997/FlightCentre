//
//  FlightDetailsViewController.swift
//  FlightCentre
//
//  Created by Dharmil Raval on 8/2/21.
//

import Foundation
import UIKit

class FlightDetailsViewController: UIViewController {
    
    @IBOutlet weak var departingAirport: UILabel!
    @IBOutlet weak var arrivalAirport: UILabel!
    
    @IBOutlet weak var departingCity: UILabel!
    @IBOutlet weak var arrivalCity: UILabel!
    
    @IBOutlet weak var departingDate: UILabel!
    @IBOutlet weak var arrivalDate: UILabel!
    
    @IBOutlet weak var departingTime: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var terminal: UILabel!
    @IBOutlet weak var gateNumber: UILabel!
    @IBOutlet weak var seatNumber: UILabel!
    
    var flightDetails: [String : String] = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Trips"
        
        ///Setting up flight details data
        setFlightDetailsData()
    }
    
    func setFlightDetailsData() {
        departingAirport.text = flightDetails["departingAirport"]
        arrivalAirport.text = flightDetails["arrivalAirport"]
        
        ///Extracting city name
        var splitArrivalCity = flightDetails["departingCity"]!.components(separatedBy: ", ")
        departingCity.text = splitArrivalCity[0]
        splitArrivalCity = flightDetails["arrivalCity"]!.components(separatedBy: ", ")
        arrivalCity.text = splitArrivalCity[0]
        
        ///Formatting date into specified format
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let departureDate = dateFormatter.date(from: flightDetails["departingDate"]!) {
            dateFormatter.dateFormat = "E, dd LLL"
            departingDate.text = dateFormatter.string(from: departureDate)
        }
        if let arrivingDate = dateFormatter.date(from: flightDetails["arrivalDate"]!) {
            dateFormatter.dateFormat = "E, dd LLL"
            arrivalDate.text = dateFormatter.string(from: arrivingDate)
        }
        
        if let departureTime = dateFormatter.date(from: flightDetails["departingDate"]!) {
            dateFormatter.dateFormat = "HH:mm a"
            departingTime.text = dateFormatter.string(from: departureTime)
        }
        if let arrivingTime = dateFormatter.date(from: flightDetails["arrivalDate"]!) {
            dateFormatter.dateFormat = "HH:mm a"
            arrivalTime.text = dateFormatter.string(from: arrivingTime)
        }
        
        flightNumber.text = (flightDetails["airlineCode"]! + flightDetails["flightNumber"]!)
    }
}
