//
//  ArtworkBriefListViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import Foundation
import Combine

@MainActor final class ArtworkBriefListViewModel: ObservableObject {
    @Published var briefs: [ArtworkBrief]
    let searchQuery: String
    let briefTapAction: (ArtworkBrief) -> Void
    
    init(searchQuery: String, briefs: [ArtworkBrief], briefTapAction: @escaping (ArtworkBrief) -> Void) {
        self.searchQuery = searchQuery
        self.briefs = briefs
        self.briefTapAction = briefTapAction
    }
}
