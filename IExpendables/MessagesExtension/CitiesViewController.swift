//
//  CitiesViewController.swift
//  IExpendables
//
//  Created by Hani Ibrahim on 6/23/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import UIKit

class CitiesViewController: UITableViewController, SearchParameterViewController {
    
    var search: Search?
    var completion: ((Void) -> ())?
    var cities = [Inspiration]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCities()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InspirationTableViewCellID", for: indexPath) as! InspirationTableViewCell
        let city = cities[indexPath.row]
        cell.configure(city: city)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        search?.inspiration = cities[indexPath.row]
        completion?()
    }
    
    private func getCities() {
        let urlString = "https://mapi.staging.wimdu.com/api/v3/hk_inspirations"
        let url = URL(string: urlString)
        
        let task = URLSession.shared().dataTask(with: url!) { (data, response, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String: String]]
            let cities = json?.map { Inspiration(json: $0) }
            DispatchQueue.main.async { [weak self] in
                self?.cities = cities!
            }
        }
        
        task.resume()
    }
}
