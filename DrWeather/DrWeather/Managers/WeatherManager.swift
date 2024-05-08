//
//  WeatherManager.swift
//  DrWeather
//
//  Created by Chris Rea & Josiah Doles on 4/12/24.
//

import Foundation
import CoreLocation

class WeatherManager {
    private let apiKeyTesting = "48532a5e16bd27acbb55cf0c9b778afc"
    private let apiKeyNew = "88346b78f218700ac2a166146e0f5982"
    
    enum WeatherError: Error {
        case missingAPIURL
        case invalidResponse
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKeyNew)&units=imperial") else {
            throw WeatherError.missingAPIURL
        }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw WeatherError.invalidResponse
            }
            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
