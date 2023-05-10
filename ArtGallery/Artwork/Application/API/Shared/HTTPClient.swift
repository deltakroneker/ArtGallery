//
//  HTTPClient.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation
import Combine

protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}
