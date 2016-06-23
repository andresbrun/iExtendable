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
    @IBOutlet weak var price: UILabel! {
        didSet {
            price.backgroundColor = .wBlue()
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 20
            containerView.clipsToBounds = true
            containerView.layer.borderColor = UIColor.wBlue().cgColor
            containerView.layer.borderWidth = 0.5
        }
    }
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
