//
//  SearchParameterTextField.swift
//  Guest
//
//  Created by Andres Brun on 27/03/15.
//  Copyright (c) 2015 Wimdu. All rights reserved.
//

import UIKit

class SearchParameterTextField: UITextField {
    
    private let iconPadding = CGFloat(5)
    private var iconImage: UIImage? {
        didSet {
            leftView = iconByAddingHorizontalPadding(imageView: UIImageView(image: iconImage))
            leftViewMode = .always
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = .wValleyGrey()
        font = WimduFont.Body1.font
    }
    
    // We dont't want this UITextField to be editable
    override func becomeFirstResponder() -> Bool {
        return false
    }
    
    func iconImageName() -> String? {
        return nil
    }
    
    func commonInit() {
        initIcon()
    }
    
    // UITextfield doesn't react to `Touch Up Inside` event, so we force it when touches ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        if bounds.contains(touchLocation) {
            sendActions(for: UIControlEvents.touchUpInside)
        }
    }
    
    private func initIcon() {
        if let iconImageValue = iconImageName() {
            iconImage = UIImage(named: iconImageValue)
        }
    }
    
    // Due to the original padding of the icon is 0
    private func iconByAddingHorizontalPadding(imageView: UIImageView) -> UIView {
        let wrapperView = UIView(frame: imageView.bounds.insetBy(dx: -iconPadding, dy: 0))
        imageView.center = CGPoint(x: wrapperView.bounds.midX, y: wrapperView.bounds.midY)
        wrapperView.addSubview(imageView)
        
        return wrapperView
    }
}
