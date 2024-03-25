//
//  SearchCache.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import Foundation

final class SearchCache {
    
    private(set) var searchResults: [SearchResult] = []
     
    func addAndSaveNewResult(_ result: SearchResult) {
        if !searchResults.contains(where: { $0.title == result.title }) {
            searchResults.insert(result, at: Constants.numbers.zeroIndex)
        }
        
        if searchResults.count > Constants.numbers.maxNumberOfSearchResults {
            searchResults.removeLast()
        }
        saveAllresults()
    }
    
    private func saveAllresults(to file: String = Constants.strings.searchResultsFile)  {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first!
        let archieveURL = documentsDirectory.appendingPathComponent(Constants.strings.searchResultsPathComponents).appendingPathExtension(Constants.strings.searcResultsPathExtension)
        let propertyListEncoder = PropertyListEncoder()
        let encodedPlaces = try? propertyListEncoder.encode(searchResults)
        
        try? encodedPlaces?.write(to: archieveURL, options: .noFileProtection)
    }
    
    func loadAllSearchPlaces(from file: String = Constants.strings.searchResultsFile) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first!
        let archieveURL = documentsDirectory.appendingPathComponent(Constants.strings.searchResultsPathComponents).appendingPathExtension(Constants.strings.searcResultsPathExtension)
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedNotesData = try? Data.init(contentsOf: archieveURL), let decodedPlaces = try? propertyListDecoder.decode(Array<SearchResult>.self, from: retrievedNotesData) {
            self.searchResults = decodedPlaces
        }
    }
}
