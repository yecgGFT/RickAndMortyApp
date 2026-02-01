//
//  DefaultImageCache.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 18/1/26.
//
import UIKit

protocol ImageCache: AnyObject {
    subscript(_ url: URL) -> UIImage? { get set }
    func removeAll()
}

public final class DefaultImageCache: ImageCache {
    public static let shared = DefaultImageCache(namespace: "default")
    private let cache = NSCache<NSURL, UIImage>()
    private let namespace: String

    public init(namespace: String) 
        {
            self.namespace = namespace
        }
    
    subscript(_ url: URL) -> UIImage? {
        get { cache.object(forKey: url as NSURL) }
        set {
            let key = url as NSURL
            if let image = newValue {
                cache.setObject(image, forKey: key)
            } else {
                cache.removeObject(forKey: key)
            }
        }
    }
    
    public func removeAll() {
        cache.removeAllObjects()
    }
}
