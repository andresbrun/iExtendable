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
    func offerDidSelected(search: Search)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
    }
    
    static func initFromStoryboard(search: Search, delegate: OfferListVCDelegate) -> OfferListVC {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "OfferListVC") as? OfferListVC else { fatalError("Unable to instantiate a CompletedIceCreamViewController from the storyboard") }
        controller.search = search
        controller.delegate = delegate
        return controller
    }
    
    func requestOffers() {
        let url = URL(string: "https://mapi.staging.wimdu.com/api/v3/hk_search_offers?search_key=1943-berlin&guests=2")
        // checkin=2016-07-29&checkout-2016-07-30
        let task = URLSession.shared().dataTask(with: url!) {(data, response, error) in
            let jsonOffers = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String: String]]
            print(jsonOffers)
            DispatchQueue.main.sync {
                self.offers = jsonOffers.map({ (dictionary) -> Offer in
                    return Offer(name: dictionary["title"]!, price: dictionary["price"]!, imageURL: dictionary["photo"]!, id: dictionary["id"]!)
                })
            }
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
        
        let offer = offers![indexPath.row]
        search?.selectedOfferID = offer.id
        search?.selectedOfferImageURL = offer.imageURL

        delegate?.offerDidSelected(search: search!)
    }
}
s
