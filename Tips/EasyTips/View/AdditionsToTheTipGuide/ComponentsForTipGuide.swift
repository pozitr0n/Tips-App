//
//  ComponentsForTipGuide.swift
//  EasyTips
//
//  Created by Raman Kozar on 03/04/2024.
//

import SwiftUI
import SwiftMessages

struct MessageStruct: Identifiable {
    
    let title: String
    let body: String
    let style: MessageView.Style

    var id: String {
        title + body
    }
    
}

// A message view with a title and message
//
struct MessageView: View {

    enum Style {
        case standard
        case card
        case tab
    }

    let message: MessageStruct
    let style: Style

    var body: some View {
        
        switch style {
        case .standard:
            content()
                // Mask the content and extend background into the safe area
                .mask {
                    Rectangle()
                        .edgesIgnoringSafeArea(.top)
                }
        case .card:
            content()
                // Mask the content with a rounded rectangle
                .mask {
                    RoundedRectangle(cornerRadius: 15)
                }
                // External padding around the card
                .padding(10)
        case .tab:
            content()
                // Mask the content with rounded bottom edge and extend background into the safe area
                .mask {
                    UnevenRoundedRectangle(bottomLeadingRadius: 15, bottomTrailingRadius: 15)
                        .edgesIgnoringSafeArea(.top)
                }
        }
    }
    
    @ViewBuilder private func content() -> some View {
       
        VStack(alignment: .leading) {
            Text(message.title).font(.system(size: 20, weight: .bold))
            Text(message.body)
        }
        .multilineTextAlignment(.leading)
        // Internal padding of the card
        .padding(30)
        // Greedy width
        .frame(maxWidth: .infinity)
        .background(.white)
        
    }
    
}

// A message view with a title, message and button
//
struct MessageWithButtonView<Button>: View where Button: View {

    enum Style {
        case standard
        case card
        case tab
    }

    init(message: MessageStruct, style: Style, @ViewBuilder button: @escaping () -> Button) {
        self.message = message
        self.style = style
        self.button = button
    }

    let message: MessageStruct
    let style: Style
    @ViewBuilder let button: () -> Button

    var body: some View {
        switch style {
        case .standard:
            content()
                // Mask the content and extend background into the safe area.
                .mask {
                    Rectangle()
                        .edgesIgnoringSafeArea(.top)
                }
        case .card:
            content()
                // Mask the content with a rounded rectangle
                .mask {
                    RoundedRectangle(cornerRadius: 15)
                }
                // External padding around the card
                .padding(10)
        case .tab:
            content()
                // Mask the content with rounded bottom edge and extend background into the safe area.
                .mask {
                    UnevenRoundedRectangle(bottomLeadingRadius: 15, bottomTrailingRadius: 15)
                        .edgesIgnoringSafeArea(.top)
                }
        }
    }

    @ViewBuilder private func content() -> some View {
        
        VStack() {
            Text(message.title).font(.system(size: 20, weight: .bold))
            Text(message.body)
            button()
        }
        .multilineTextAlignment(.center)
        // Internal padding of the card
        .padding(30)
        // Greedy width
        .frame(maxWidth: .infinity)
        .background(.white)
        
    }
    
}

extension MessageStruct: MessageViewConvertible {
    
    func asMessageView() -> MessageView {
        MessageView(message: self, style: style)
    }
    
}

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
    
    //var id = UUID()
    var id: String = UUID().uuidString
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
