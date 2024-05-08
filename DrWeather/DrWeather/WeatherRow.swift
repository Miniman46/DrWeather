//
//  WeatherRow.swift
//  DrWeather
//
//  Created by Chris Rea & Josiah Doles on 4/12/24.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            WeatherIcon(systemName: logo)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 1) {
                Text(name)
                    .font(.caption)
                    .bold()
                
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
        .foregroundColor(.white)
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(color: .black, radius: 3, x: 0, y: 2)
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "snowflake", name: "Daily Lows", value: "-12°F")
    }
}

struct WeatherIcon: View {
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .font(.title2)
            .foregroundColor(.white)
    }
}
