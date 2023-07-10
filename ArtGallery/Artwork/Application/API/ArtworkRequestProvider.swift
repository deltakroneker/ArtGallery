//
//  ArtworkRequestProvider.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation

typealias Query = String
typealias Page = Int
typealias PageSize = Int
typealias ObjectNumber = String

typealias CollectionParams = (q: Query, p: Page, ps: PageSize)
typealias ObjectParams = ObjectNumber

enum ArtworkRequestProvider {
    case collection(CollectionParams)
    case object(ObjectParams)
    
    private var baseURL: String { "https://www.rijksmuseum.nl/api" }
    
    var path: String {
        switch self {
        case .collection(let params):
            let urlEncodedQuery = params.q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return baseURL + "/en/collection?format=json&p=\(params.p)&ps=\(params.ps)&q=\(urlEncodedQuery)&imgonly=true&toppieces=true"
        case .object(let param):
            return baseURL + "/en/collection/\(param)?format=json"
        }
    }
    
    var makeRequest: URLRequest {
        guard let url = URL(string: path) else {
            preconditionFailure("URL is not valid")
        }
        return URLRequest(url: url)
    }
}
