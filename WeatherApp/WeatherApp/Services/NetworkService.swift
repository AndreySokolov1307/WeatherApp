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

class NetworkService {
    
    private let baseURLString = "https://api.open-meteo.com/v1/forecast"
    
    var baseQuery: [String : String] = [
        "current" : "temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m",
        "daily" : "weather_code,temperature_2m_max,temperature_2m_min,uv_index_max",
        "timezone" : "auto"
    ]
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weaher {
        guard var urlComponents =  URLComponents(string: baseURLString) else {
            throw NetworkError.invalidURLComponents
        }
        baseQuery["latitude"] = String(latitude)
        baseQuery["longitude"] = String(longitude)
        urlComponents.queryItems = baseQuery.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.weatherNotFound
        }
        
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(Weaher.self, from: data)
            return weather
        } catch {
            throw NetworkError.unableToParseJSON
        }
    }
}
