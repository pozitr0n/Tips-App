//
//  ComponentsForTipGuide.swift
//  Tips
//
//  Created by Raman Kozar on 03/04/2024.
//

import SwiftUI

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 8, color: Color = Color(UIColor.separator)) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            line
            Text(label)
                .font(.callout)
                .foregroundColor(color)
                .lineLimit(1)
                .fixedSize()
                .offset(y: -1)
            line
        }
        
    }

    var line: some View {
        
        VStack() {
            Divider()
                .frame(height: 1)
                .background(color)
        }
        .padding(horizontalPadding)
        
    }
    
}

struct CountryInfo: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case countryNameEN
        case countryNamePL
        case countryNameRU
        case continentEN
        case continentPL
        case continentRU
        case countryCode
        case restaurantTipInitial
        case restaurantTipFinal
        case hotelTipInitialUSD
        case hotelTipFinalUSD
        case driverTipInitial
        case driverTipLimit
        
    }
    
    var id = UUID()
    var countryNameEN: String
    var countryNamePL: String
    var countryNameRU: String
    var continentEN: String
    var continentPL: String
    var continentRU: String
    var countryCode: String
    var restaurantTipInitial: String
    var restaurantTipFinal: String
    var hotelTipInitialUSD: String
    var hotelTipFinalUSD: String
    var driverTipInitial: String
    var driverTipLimit: String
    
}

class ReadCountryInfoFromJSON: ObservableObject {
    
    @Published var countriesWithTips: [CountryInfo]         = []
    @Published var filteredCountriesWithTips: [CountryInfo] = []
    
    init() {
        parseAndLoadData()
    }
    
    // function for parsing and loading data
    //
    func parseAndLoadData() {
        
        guard let localeURL = Bundle.main.url(forResource: "tips-worldwide", withExtension: "json") else {
            print(".json file is not found")
            return
        }
        
        guard let info = try? Data(contentsOf: localeURL) else {
            return
        }
        
        guard let countries = try? JSONDecoder().decode([CountryInfo].self, from: info) else {
            return
        }
        
        self.countriesWithTips = countries
        
    }
    
    // function for updating filter
    //
    func updateFilteredArray(_ currentSelectedCountry: String = "") {
        filteredCountriesWithTips = countriesWithTips.filter({ $0.countryCode == currentSelectedCountry })
    }
    
}
