//
//  ViewController.swift
//  blesson3
//
//  Created by Oscar Rodriguez Garrucho on 10/9/17.
//  Copyright © 2017 Oscar Rodriguez Garrucho. All rights reserved.
//

import UIKit
import CoreLocation
import Permission

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "PlaceCell"
    var tapGesture : UITapGestureRecognizer!
    var places: [Place] = [Place]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let nib = UINib(nibName: "PlaceCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        self.title = "Blesson 3 Project"
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tapGesture.cancelsTouchesInView = false // translate the event touch to the next view (tableView, for example)

        if (UserDefaults.standard.object(forKey: "latitude") != nil) {
            ECProgressView.shared.showProgressView(self.view)
        }
    }


    
    // Get results from Core Data to show in tableView
    func loadFromCoreData() {
        
        let dataProvider = LocalCoreDataService()
        places = dataProvider.getAllPlaces()
        print("Places loaded from CoreData successfully!")
        self.tableView.reloadData()
    }
    
    
    
    // We call to API Google Places to get all places around us
    // Then We save them in Core Data and print them on the tableView.
    func searchInGooglePlace() {
        
        if let text = searchBar.text {
            
            let conn = ConnectionServices()
            
            print("Searching on Google Place for \(text)")
            conn.getNewPlaces(place: text){ places in
                
                if let places = places {
                    
                    let dataProvider = LocalCoreDataService()
                    dataProvider.savePlaces(places: places)
                    print("Places saved in CoreData successfully!")
                    self.loadFromCoreData()
                    
                } else {
                    print("Server connection has failed in Get New Places. Try again later.")
                    print("Error while calling REST Get New Places services")
                }
                
            }
        }

    }
    
    
    
    
    
    
    // MARK: SearchBox
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view.addGestureRecognizer(self.tapGesture)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Text in searchBar changed")
        if let text = searchBar.text {
            if (text.isEmpty){          // if there is no text, clean the tableView
                places = [Place]()
                self.tableView.reloadData()
            }
            else {
                self.searchInGooglePlace()
            }
        }
        
    }
    
    
    func hideKeyboard() {
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(self.tapGesture)
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Clicked on SearchBar!")
        hideKeyboard()
    }

    
    
    
    
    
    
    
    // MARK: ResultTableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PlaceCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PlaceCell
        cell.configCellWithOptions(place: places[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // We pass the selected place to Details View Controller
        let myDetailsVC = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        myDetailsVC.place = places[indexPath.row]
        navigationController?.pushViewController(myDetailsVC, animated: true)
    }



}

