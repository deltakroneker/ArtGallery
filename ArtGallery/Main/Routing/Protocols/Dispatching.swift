//
//  Dispatching.swift
//  ArtGallery
//
//  Created by nikolamilic on 6/5/23.
//

import Foundation

protocol Dispatching {
    func async(execute workItem: DispatchWorkItem)
}

extension DispatchQueue: Dispatching {}
