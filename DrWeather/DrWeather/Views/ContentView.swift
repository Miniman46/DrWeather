//
//  ContentView.swift
//  DrWeather
//
//  Created by Chris Rea & Josiah Doles on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State private var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            await fetchWeatherData(latitude: location.latitude, longitude: location.longitude)
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.3, saturation: 0.8, brightness: 0.3))
        .preferredColorScheme(.dark)
        
    }
    
    private func fetchWeatherData(latitude: Double, longitude: Double) async {
        do {
            weather = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
        } catch {
            print("Error fetching weather data: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
