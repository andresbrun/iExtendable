//
//  OfferCell.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import UIKit

class OfferCell: UITableViewCell {
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
}

extension OfferCell {
    func configure(offer: Offer) {
        DispatchQueue.main.async {
            if let imageURL = URL(string:  offer.imageURL) {
                let data = try! Data(contentsOf: imageURL)
                self.offerImageView.image = UIImage(data: data)
            }
        }
        
        price.text = offer.price
        title.text = offer.name
    }
}
