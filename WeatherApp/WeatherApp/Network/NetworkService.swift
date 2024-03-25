//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import Foundation
enum NetworkError: Error {
    case invalidURLComponents
    case invalidURL
    case weatherNotFound
    case unableToParseJSON
}

final class NetworkService {
    
    private let baseURLString = Constants.strings.baseURLString
    
    var baseQuery = Constants.strings.baseQuery
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weather {
        guard var urlComponents =  URLComponents(string: baseURLString) else {
            throw NetworkError.invalidURLComponents
        }
        baseQuery[Constants.strings.latitude] = String(latitude)
        baseQuery[Constants.strings.longitude] = String(longitude)
        urlComponents.queryItems = baseQuery.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == Constants.numbers.statusCode200 else {
            throw NetworkError.weatherNotFound
        }
        
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(Weather.self, from: data)
            return weather
        } catch {
            throw NetworkError.unableToParseJSON
        }
    }
}
