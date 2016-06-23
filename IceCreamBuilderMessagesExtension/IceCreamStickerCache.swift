//
//  IceCreamStickerCache.swift
//  IceCreamBuilder
//
//  Created by Pete Callaway on 6/3/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit
import Messages

class IceCreamStickerCache {
    
    static let cache = IceCreamStickerCache()
    
    private let cacheURL: URL
    
    private let queue = OperationQueue()
    
    /**
        An `MSSticker` that can be used as a placeholder while a real ice cream
        sticker is being fetched from the cache.
    */
    let placeholderSticker: MSSticker = {
        let bundle = Bundle.main()
        guard let placeholderURL = bundle.urlForResource("sticker_placeholder", withExtension: "png") else { fatalError("Unable to find placeholder sticker image") }
        
        do {
            let description = NSLocalizedString("An ice cream sticker", comment: "")
            return try MSSticker(contentsOfFileURL: placeholderURL, localizedDescription: description)
        }
        catch {
            fatalError("Failed to create placeholder sticker: \(error)")
        }
    }()
    
    // MARK: Initialization
    
    private init() {
        let fileManager = FileManager.default()
        let tempPath = NSTemporaryDirectory()
        let directoryName = UUID().uuidString
        
        do {
            try cacheURL = URL(fileURLWithPath: tempPath).appendingPathComponent(directoryName)
            try fileManager.createDirectory(at: cacheURL, withIntermediateDirectories: true, attributes: nil)
        }
        catch {
            fatalError("Unable to create cache URL: \(error)")
        }
    }
    
    deinit {
        let fileManager = FileManager.default()
        do {
            try fileManager.removeItem(at: cacheURL)
        }
        catch {
            print("Unable to remove cache directory: \(error)")
        }
    }
    
    // MARK
    
    func sticker(for iceCream: IceCream, completion: (sticker: MSSticker) -> Void) {
        guard let base = iceCream.base, let scoops = iceCream.scoops, let topping = iceCream.topping else { fatalError("Stickers can only be created for completed ice creams") }

        // Determine the URL for the sticker.
        let fileName = base.rawValue + scoops.rawValue + topping.rawValue + ".png"
        guard let url = try? cacheURL.appendingPathComponent(fileName) else { fatalError("Unable to create sticker URL") }
        
        // Create an operation to process the request.
        let operation = BlockOperation { 
            // Check if the sticker already exists at the URL.
            let fileManager = FileManager.default()
            guard !fileManager.fileExists(atPath: url.absoluteString!) else { return }
            
            // Create the sticker image and write it to disk.
            guard let image = iceCream.renderSticker(opaque: false), let imageData = UIImagePNGRepresentation(image) else { fatalError("Unable to build image for ice cream") }
            
            do {
                try imageData.write(to: url, options: [.atomicWrite])
            } catch {
                fatalError("Failed to write sticker image to cache: \(error)")
            }
        }
        
        // Set the operation's completion block to call the request's completion handler.
        operation.completionBlock = {
            do {
                let sticker = try MSSticker(contentsOfFileURL: url, localizedDescription: "Ice Cream")
                completion(sticker: sticker)
            } catch {
                print("Failed to write image to cache, error: \(error)")
            }
        }

        // Add the operation to the queue to start the work.
        queue.addOperation(operation)
    }
}
