//
//  FlightListViewController.swift
//  FlightCentre
//
//  Created by Dharmil Raval on 8/2/21.
//

import Foundation
import UIKit

//MARK: - For splitting flights by date sections
struct FlightSection {
    var sectionDate: String
    var flight: [FlightList]
}

class FlightListViewController: UIViewController {
    
    var arrayOfFlights = [FlightList]()
    var sectionStructuredData: [FlightSection] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Trips"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ///Calling API and setting up Data
        getFlightListData()
    }
    
    func getFlightListData() {
        FlightList.getData() {[weak self] (error, data) in
            ///Checking if data exists
            if !data!.isEmpty {
                self?.arrayOfFlights.append(contentsOf: data!)
                ///Data into sections
                self?.structureDataForTable()
            }
        }
    }
    
    //MARK: - For splitting up data by date sections
    func structureDataForTable() {
        ///Looping through each flight from the list
        arrayOfFlights.forEach { flight in
            ///Converting date string into date
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            if let departureDate = dateFormatter.date(from: flight.departureDate) {
                ///Converting date into specified time
                dateFormatter.dateFormat = "E, dd LLL"
                ///Checking if section already exists and already create a new one if it does not exists
                let filterSection = sectionStructuredData.filter{$0.sectionDate == dateFormatter.string(from: departureDate)}
                let position = sectionStructuredData.firstIndex{$0.sectionDate == dateFormatter.string(from: departureDate)}
                if filterSection.count > 0 {
                    sectionStructuredData[position!].flight.append(flight)
                }
                else {
                    sectionStructuredData.append(FlightSection(sectionDate: dateFormatter.string(from: departureDate), flight: [flight]))
                }
            }
        }
        
        self.tableView.reloadData()
    }
}

//MARK: - Extending class for TableView
extension FlightListViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionStructuredData[section].flight.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionStructuredData[section].sectionDate
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionStructuredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath) as? FlightListTableViewCell
        else {
            fatalError("Missing Flight Cell")
        }
        let flightList = sectionStructuredData[indexPath.section].flight[indexPath.row]
        cell.setFlightData(flightList: flightList)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flightVar = sectionStructuredData[indexPath.section].flight[indexPath.row]
        ///Creating data for FlightDetailViewController class
        let flightDets = [
            "departingAirport":flightVar.departureAirport,
            "arrivalAirport":flightVar.arrivalAirport,
            "departingCity":flightVar.departureCity,
            "arrivalCity":flightVar.arrivalCity,
            "departingDate":flightVar.departureDate,
            "arrivalDate":flightVar.arrivalDate,
            "flightNumber":flightVar.flightNumber,
            "airlineCode":flightVar.airlineCode,
        ]
        var vc = FlightDetailsViewController()
        vc = (self.storyboard?.instantiateViewController(withIdentifier: "FlightDetailsViewController") as? FlightDetailsViewController)!
        vc.flightDetails = flightDets
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
