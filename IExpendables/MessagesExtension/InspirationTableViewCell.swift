//
//  InspirationTableViewCell.swift
//  IExpendables
//
//  Created by Hani Ibrahim on 6/23/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import UIKit

class InspirationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityContainer: UIView! {
        didSet {
            cityContainer.layer.cornerRadius = 10
            cityContainer.layer.borderColor = UIColor.black().cgColor
            cityContainer.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel! {
        didSet {
            cityLabel.font = WimduFont.Title.font
            cityLabel.textColor = .wLightGrey()
        }
    }
    
    func configure(city: Inspiration) {
        cityLabel.text = city.name
        cityImageView.image = city.image
        getImage(city: city)
    }
    
    private func getImage(city: Inspiration) {
        guard cityImageView.image == nil else { return }
        let url = URL(string: city.imageURL)
        
        let task = URLSession.shared().dataTask(with: url!) { (data, response, error) in
            let image = UIImage(data: data!)
            DispatchQueue.main.async { [weak self] in
                self?.cityImageView.image = image
                city.image = image
            }
        }
        
        task.resume()
    }
}
