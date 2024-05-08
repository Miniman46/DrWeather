//
//  WelcomeView.swift
//  DrWeather
//
//  Created by Chris Rea & Josiah Doles on 4/12/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Welcome to Dr. Weather!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("'Dr' stands for Doles & Rea Weather. The last names of the developers. MSSU is not affiliated with this product.")
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.body)
            }
            .padding(.vertical)
            
            AsyncImage(url: URL(string: "https://mssu.blackboard.com/branding/_1_1/loginLogo/CustomLoginLogo.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            } placeholder: {
                ProgressView()
            }
            .padding(.vertical)
            
            VStack(spacing: 10) {
                Text("We need access to your location in order to retrieve your current weather data.")
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.body)
                
                Text("We do not collect user data.")
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.body)
            }
            .padding(.vertical)
            
            Spacer()
            
            VStack {
                LocationButton(.currentLocation) {
                    locationManager.requestLocation()
                }
                .buttonStyle(LocationButtonStyle())
                .padding()
                .cornerRadius(30)
            }
        }
        .padding()
    }
}

struct LocationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .shadow(color: .black, radius: 3, x: 0, y: 2)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
