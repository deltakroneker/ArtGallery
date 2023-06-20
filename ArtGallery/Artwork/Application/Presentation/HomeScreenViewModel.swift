//
//  HomeScreenViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/11/23.
//

import Foundation
import Combine

final class HomeScreenViewModel: ObservableObject {
    private var bag = Set<AnyCancellable>()
    
    @Published var queryText: String = ""
    let searchButtonAction: (String) -> Void
    
    var isPerformSearchDisabled: Bool {
        return queryText.isEmpty
    }
    
    init(searchButtonAction: @escaping (String) -> Void) {
        self.searchButtonAction = searchButtonAction
    }
    
    func performSearch() {
        guard !isPerformSearchDisabled else {
            return
        }
        self.searchButtonAction(self.queryText)
    }
}
