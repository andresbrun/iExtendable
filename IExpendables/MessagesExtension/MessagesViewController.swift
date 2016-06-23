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
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        // Present the view controller appropriate for the conversation and presentation style.
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
        let controller: UIViewController = SearchVC.initFromStoryboard(search: Search())
//        if presentationStyle == .compact {
//            // Show a list of previously created ice creams.
//            controller = SearchVC.initFromStoryboard(search: Search())
//        }
//        else {
//            /*
//             Parse an `IceCream` from the conversation's `selectedMessage` or
//             create a new `IceCream` if there isn't one associated with the message.
//             */
//            let iceCream = IceCream(message: conversation.selectedMessage) ?? IceCream()
//            
//            if iceCream.isComplete {
//                controller = instantiateCompletedIceCreamController(with: iceCream)
//            }
//            else {
//                controller = instantiateBuildIceCreamController(with: iceCream)
//            }
//        }
        
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
    
//    private func composeMessage(with search: Search, caption: String, session: MSSession? = nil) -> MSMessage {
//        var components = URLComponents()
//        components.queryItems = iceCream.queryItems
//        
//        let layout = MSMessageTemplateLayout()
//        layout.image = iceCream.renderSticker(opaque: true)
//        layout.caption = caption
//        
//        let message = MSMessage(session: session ?? MSSession())
//        message.url = components.url!
//        message.layout = layout
//        
//        return message
//    }
    
}
