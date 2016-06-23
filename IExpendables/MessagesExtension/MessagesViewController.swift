//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
}

extension MessagesViewController {
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        // Determine the controller to present.
        let search = Search(message: conversation.selectedMessage) ?? Search()
        let controller: UIViewController
        
        if presentationStyle == .compact {
            controller = SearchVC.initFromStoryboard(search: search)
        } else {
            controller = OfferListVC.initFromStoryboard(search: search, delegate: self)
        }

        
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    private func composeMessage(with search: Search, session: MSSession?) -> MSMessage {
        var components = URLComponents()
        components.queryItems = search.queryItems
        
        let layout = MSMessageTemplateLayout()
        if let urlString = search.selectedOfferImageURL, imageURL = URL(string: urlString) {
            let data = try! Data(contentsOf: imageURL)
            layout.image = UIImage(data: data)
        }
        layout.trailingSubcaption = "\(search.selectedOfferPrice!) per night"
        layout.imageTitle = search.selectedOfferName
        layout.subcaption = "\(search.guests) guests"
        
        if let checkin = search.checkin, checkout = search.checkout {
            layout.caption = checkin.humanDescription
            layout.trailingCaption = checkout.humanDescription
        }

        let message = MSMessage(session: session ?? MSSession())
        message.url = components.url!
        message.layout = layout
        
        return message
    }
}


extension MessagesViewController: OfferListVCDelegate {
    func offerDidSelected(search: Search) {
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        
        // Create a new message with the same session as any currently selected message.
        let message = composeMessage(with: search, session: conversation.selectedMessage?.session)
        
        var datesString = ""
        if let checkin = search.checkin, checkout = search.checkout {
            datesString = "\(checkin.humanDescription) to \(checkout.humanDescription)"
        }
        
        // Add the message to the conversation.
        conversation.insert(message, localizedChangeDescription: "\(datesString) for \(search.guests) Guest. Offer: \(search.selectedOfferPrice!) per person") { error in
            if let error = error {
                print(error)
            }
        }
        
        dismiss()
    }
}

extension Date {
    var humanDescription: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .mediumStyle
        formatter.timeStyle = .noStyle
        
        return formatter.string(from: self)
    }
}
