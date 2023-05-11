//
//  AuthenticatedHTTPClientDecorator.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/11/23.
//

import Foundation
import Combine

class AuthenticatedHTTPClientDecorator: HTTPClient {
    let httpClient: HTTPClient
    let apiKey: String
    
    init(httpClient: HTTPClient, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        var authenticatedRequest = request
        authenticatedRequest.url?.append(queryItems: [URLQueryItem(name: "key", value: apiKey)])
        return httpClient.publisher(request: authenticatedRequest)
    }
}
