//
//  OfferListVC.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import UIKit

protocol OfferListVCDelegate {
    func offerDidSelected(offer: Offer)
}

class OfferListVC: UITableViewController {
    var delegate: OfferListVCDelegate?
    
    var search: Search? {
        didSet {
            requestOffers()
        }
    }
    var offers: [Offer]? {
        didSet {
            tableView.reloadData()
            
            var index: IndexPath?
            offers!.enumerated().forEach { (offSet, element) in
                if element.id == search?.selectedOfferID {
                    index = IndexPath(row: offSet, section: 0)
                }
            }
            if let indexPath = index {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
            }
        }
    }
    
    static func initFromStoryboard(search: Search) -> OfferListVC {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "OfferListVC") as? OfferListVC else { fatalError("Unable to instantiate a CompletedIceCreamViewController from the storyboard") }
        controller.search = search
        return controller
    }
    
    func requestOffers() {
        let url = URL(string: "http://www.stackoverflow.com")
        
        let task = URLSession.shared().dataTask(with: url!) {(data, response, error) in
//            let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
            // offers = "whatever"
        }
        
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let offers = offers else { return 0 }
        return offers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell") as! OfferCell
        cell.configure(offer: offers![indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        delegate?.offerDidSelected(offer: offers![indexPath.row])
    }
}
