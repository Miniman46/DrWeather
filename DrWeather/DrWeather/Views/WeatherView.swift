//
//  WeatherView.swift
//  DrWeather
//
//  Created by Chris Rea & Josiah Doles on 4/12/24.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("Weather in \(weather.name)")
                    .font(.title)
                    .bold()
                
                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "sun.rain")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                    Text(weather.weather[0].main)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Text("Temperature: \(weather.main.feelsLike.roundDouble())°F")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                AsyncImage(url: URL(string: "https://mssu.blackboard.com/branding/_1_1/loginLogo/CustomLoginLogo.png")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Additional Information")
                        .font(.title2)
                        .bold()
                    
                    WeatherRow(logo: "snowflake", name: "Daily Lows", value: "\(weather.main.tempMin.roundDouble())°F")
                    WeatherRow(logo: "exclamationmark.triangle", name: "Daily Highs", value: "\(weather.main.tempMax.roundDouble())°F")
                    WeatherRow(logo: "fan", name: "Wind speeds", value: "\(weather.wind.speed.roundDouble()) mph")
                    WeatherRow(logo: "humidity", name: "Outdoor Humidity", value: "\(weather.main.humidity.roundDouble())%")
                }
                .padding()
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(hue: 0.3, saturation: 0.8, brightness: 0.3))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
