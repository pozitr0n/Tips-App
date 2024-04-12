//
//  TipGuideSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024.
//

import SwiftUI

fileprivate let maximumAllowedScaleForScreen = 8.0

struct TipGuideSwiftUIView: View {
    
    @State private var clickedMainPath = PathOfTheInformation()
    @FocusState private var focused: Bool
    
    @ObservedObject var countryInfo = ReadCountryInfoFromJSON()
    @State var clickedCountry: String = ""
            
    @State var currentLanguageCode: String = Languages().languagesValuesWithCodes[CurrentLanguage.shared.currentLanguage.rawValue]!
        
    var body: some View {
        
        CommonContainerForZoom {
        
            GeometryReader { geometry in
                
                VStack {
                    
                    MapInteractive(nameOtTheSVG: "world-low") { pathInfoData in
                        
                        // is a ShapeInteractive with pathInfoData
                        ShapeInteractive(pathInfoData)
                            
                            .stroke(clickedMainPath == pathInfoData ? .guideFocused : .guideUnfocused, lineWidth: 0.5)
                            .shadow(color: clickedMainPath == pathInfoData ? .guideFocused : .guideUnfocused,  radius: 3)
                        
                            // to increase the glow amount
                            .shadow(color: clickedMainPath == pathInfoData ? .guideFocused : .clear , radius: 3)
                        
                            // filling the shapes
                            .background(ShapeInteractive(pathInfoData).fill(clickedMainPath == pathInfoData ? .guideFocused : .guideCountryBackground))
                        
                            // for depth
                            // .shadow(color: clickedMainPath == pathInfoData ? .guideFocused : .clear , radius: 0.1, y: 0.1)
                        
                            .onTapGesture {
                                
                                if clickedMainPath != pathInfoData {
                                    
                                    clickedMainPath = pathInfoData
                                    focused = true
                                    clickedCountry = clickedMainPath.id

                                } else {
                                    
                                    clickedMainPath = PathOfTheInformation()
                                    focused = false
                                    clickedCountry = ""
                                    
                                }
                                
                                countryInfo.updateFilteredArray(clickedCountry)
                                
                            }
                            
                            //  this is required (ShapeInteractive overlap)
                            //  resulting in an ugly appearance
                            .zIndex(clickedMainPath == pathInfoData ? 2 : 1)
                            .animation(.easeInOut(duration: 0.3), value: clickedMainPath)
                            .padding([.leading, .trailing], geometry.size.width * 0.01)
                            .padding([.top, .bottom], geometry.size.height * 0.15)
                        
                        
                    }
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    // do without .clipped()
                    
                }
                
            }
            .background(.guideBackground)
            
        }
        .background(.guideBackground)
        
        LabelledDivider(label: "☟")
        
        if clickedCountry.isEmpty {
        
            NavigationView {
                
                Group {
                    
                    VStack {
                    
                        Text("Choose-country-start".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                            .frame(width: 300, height: 180, alignment: .center)
                            .padding([.leading, .trailing], 15)
                            .background(.guideBackground)
                            .foregroundStyle(.guideCountryBackground)
                            .multilineTextAlignment(.center)
                            .bold()
                            .font(.system(size: 19))
                            .clipShape(.rect(cornerRadius: 20))
                            .opacity(0.6)

                    }
                    
                }
                .navigationTitle("Tip-Guide-Welcome.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                
            }
            
        } else {
        
            NavigationView {
                
                Form {
                    
                    Section(header: Text("Country.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            VStack {
                                
                                if currentLanguageCode == "en" {
                                    Text(currentCountry.countryNameEN)
                                        .padding(.trailing)
                                }
                                
                                if currentLanguageCode == "pl" {
                                    Text(currentCountry.countryNamePL)
                                        .padding(.trailing)
                                }
                                
                                if currentLanguageCode == "ru" {
                                    Text(currentCountry.countryNameRU)
                                        .padding(.trailing)
                                }
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Continent.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            VStack {
                                
                                if currentLanguageCode == "en" {
                                    Text(currentCountry.continentEN)
                                        .padding(.trailing)
                                }
                                
                                if currentLanguageCode == "pl" {
                                    Text(currentCountry.continentPL)
                                        .padding(.trailing)
                                }
                                
                                if currentLanguageCode == "ru" {
                                    Text(currentCountry.continentRU)
                                        .padding(.trailing)
                                }
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Country-Code.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            VStack {
                                
                                Text(currentCountry.countryCode)
                                    .padding(.trailing)
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Restaurant.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            if currentCountry.restaurantTipInitial != "NoTip" &&
                                currentCountry.restaurantTipInitial != "ServiceIncluded" &&
                                currentCountry.restaurantTipInitial != "NoInfo" {
                            
                                if currentCountry.restaurantTipInitial == currentCountry.restaurantTipFinal {
                                
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("Restaurant tips are usually \(currentCountry.restaurantTipInitial)% of the order price")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Napiwki restauracyjne wynoszą zazwyczaj \(currentCountry.restaurantTipInitial)% ceny zamówienia")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Чаевые в ресторане обычно составляют \(currentCountry.restaurantTipInitial)% от стоимости заказа")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                    
                                } else {
                                
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("Restaurant tips typically range from \(currentCountry.restaurantTipInitial)% to \(currentCountry.restaurantTipFinal)% of the order price")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Napiwki dla restauracji zazwyczaj wahają się od \(currentCountry.restaurantTipInitial)% do \(currentCountry.restaurantTipFinal)% ceny zamówienia")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Чаевые в ресторане обычно составляют от \(currentCountry.restaurantTipInitial)% до \(currentCountry.restaurantTipFinal)% от стоимости заказа")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
                                if currentCountry.restaurantTipInitial == "NoTip" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("In this country, it is not customary to leave tips for restaurants")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("W tym kraju nie ma zwyczaju zostawiania restauracji napiwków")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("В этой стране не принято оставлять чаевые ресторанам")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                    
                                }
                                
                                if currentCountry.restaurantTipInitial == "ServiceIncluded" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("In this country, everything is included in the price of the service (restaurants)")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("W tym kraju wszystko jest wliczone w cenę usługi (restauracje)")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("В этой стране все включено в стоимость услуги (рестораны)")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                
                                if currentCountry.restaurantTipInitial == "NoInfo" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("There is no reliable and accurate information on the amount of tips for restaurants located in this country")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Nie ma wiarygodnych i dokładnych informacji na temat wysokości napiwków dla restauracji znajdujących się w tym kraju")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Достоверной и точной информации о сумме чаевых в ресторанах, расположенных в этой стране, нет")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Hotel.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            if currentCountry.hotelTipInitialUSD != "NoTip" &&
                                currentCountry.hotelTipInitialUSD != "NoInfo" {
                                
                                let hotelTipCurrentCurrInitial: String = Currencies().convertAmountToAnotherCurrency(currentCountry.hotelTipInitialUSD)
                                let hotelTipCurrentCurrFinal: String = Currencies().convertAmountToAnotherCurrency(currentCountry.hotelTipFinalUSD)
                                
                                if currentCountry.hotelTipInitialUSD == currentCountry.hotelTipFinalUSD {
      
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("The approximate tip amount in hotels in this country is: $\(currentCountry.hotelTipInitialUSD) or \(hotelTipCurrentCurrInitial) \(CurrentCurrency.shared.currentCurrency)")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Przybliżona wysokość napiwku w hotelach w tym kraju wynosi: \(currentCountry.hotelTipInitialUSD) dolarów lub \(hotelTipCurrentCurrInitial) \(CurrentCurrency.shared.currentCurrency)")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Ориентировочная сумма чаевых в отелях данной страны составляет: $\(currentCountry.hotelTipInitialUSD) или \(hotelTipCurrentCurrInitial) \(CurrentCurrency.shared.currentCurrency)")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                    
                                } else {
                                
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("The approximate tip amount in hotels in this country ranges from $\(currentCountry.hotelTipInitialUSD) to $\(currentCountry.hotelTipFinalUSD) (from \(hotelTipCurrentCurrInitial) \(CurrentCurrency.shared.currentCurrency) to \(hotelTipCurrentCurrFinal) \(CurrentCurrency.shared.currentCurrency))")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Przybliżona wysokość napiwku w hotelach w tym kraju waha się od \(currentCountry.hotelTipInitialUSD) dolarów do $\(currentCountry.hotelTipFinalUSD) dolarów (od \(hotelTipCurrentCurrInitial) \(CurrentCurrency.shared.currentCurrency) do \(hotelTipCurrentCurrFinal) \(CurrentCurrency.shared.currentCurrency))")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Ориентировочная сумма чаевых в отелях данной страны находится в диапазоне от $\(currentCountry.hotelTipInitialUSD) до $\(currentCountry.hotelTipFinalUSD) (от \(hotelTipCurrentCurrInitial) \(CurrentCurrency.shared.currentCurrency) до \(hotelTipCurrentCurrFinal) \(CurrentCurrency.shared.currentCurrency))")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
                                if currentCountry.hotelTipInitialUSD == "NoTip" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("In this country, it is not customary to leave tips for hotels")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("W tym kraju nie jest zwyczajem dawanie napiwków w hotelach")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("В этой стране не принято оставлять чаевые в отелях")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                
                                if currentCountry.hotelTipInitialUSD == "NoInfo" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("There is no reliable and accurate information on the amount of tips for hotels located in this country")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Nie ma wiarygodnych i dokładnych informacji na temat wysokości napiwków dla hoteli w tym kraju")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Достоверной и точной информации о сумме чаевых для отелей, расположенных в этой стране, нет")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Driver.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            if currentCountry.driverTipInitial != "NoTip" &&
                                currentCountry.driverTipInitial != "RoundUp" &&
                                currentCountry.driverTipInitial != "NoInfo" {
                                
                                if currentCountry.driverTipInitial == currentCountry.driverTipLimit {
                                
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("Driver tips are usually \(currentCountry.driverTipInitial)% of the order price")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Napiwki dla kierowców wynoszą zazwyczaj \(currentCountry.driverTipInitial)% ceny zamówienia")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Чаевые водителям обычно составляют \(currentCountry.driverTipInitial)% от стоимости заказа")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                    
                                } else {
                                
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("Driver tips typically range from \(currentCountry.driverTipInitial)% to \(currentCountry.driverTipLimit)% of the order price")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Napiwki dla kierowców zazwyczaj wahają się od \(currentCountry.driverTipInitial)% do \(currentCountry.driverTipLimit)% ceny zamówienia")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Чаевые водителям обычно составляют от \(currentCountry.driverTipInitial)% до \(currentCountry.driverTipLimit)% от стоимости заказа")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
                                if currentCountry.driverTipInitial == "NoTip" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("In this country, it is not customary to leave tips for drivers")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("W tym kraju nie ma zwyczaju dawania kierowcom napiwków")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("В этой стране не принято оставлять чаевые водителям")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                
                                if currentCountry.driverTipInitial == "NoInfo" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("There is no reliable and accurate information on the amount of tips for drivers located in this country")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("Nie ma wiarygodnych i dokładnych informacji na temat wysokości napiwków dla kierowców w tym kraju")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("Достоверной и точной информации о сумме чаевых для водителей, расположенных в этой стране, нет")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                
                                if currentCountry.driverTipInitial == "RoundUp" {
                                    VStack {
                                        
                                        if currentLanguageCode == "en" {
                                            Text("In this country, rounding up the order amount is calculated as a tip")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "pl" {
                                            Text("W tym kraju zaokrąglenie kwoty zamówienia liczone jest jako napiwek")
                                                .padding(.trailing)
                                        }
                                        
                                        if currentLanguageCode == "ru" {
                                            Text("В этой стране округление суммы заказа в большую сторону считается чаевыми")
                                                .padding(.trailing)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                }
                .navigationTitle("Tip-Guide.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                .onAppear(perform: {
                    if countryInfo.filteredCountriesWithTips.isEmpty {
                     
                        // !!!!!!
                        
                    }
                })
            }
            
        }
        
    }
    
}

struct CommonContainerForZoom <Content: View>: View {
    
    let content: Content

    @State private var currentScale: CGFloat = 1.0
    @State private var tapLocation: CGPoint = .zero

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func doubleTapAction(location: CGPoint) {
        
        tapLocation = location
        currentScale = currentScale == 1.0 ? maximumAllowedScaleForScreen : 1.0
        
    }

    var body: some View {
        
        ScrollViewContainerForZoom(scale: $currentScale, tapLocation: $tapLocation) {
            content
        }
        .onTapGesture(count: 2, perform: doubleTapAction)
        
    }

    fileprivate struct ScrollViewContainerForZoom: UIViewRepresentable {
        
        private var content: Content
        
        @Binding private var currentScale: CGFloat
        @Binding private var tapLocation: CGPoint

        init(scale: Binding<CGFloat>, tapLocation: Binding<CGPoint>, @ViewBuilder content: () -> Content) {
            _currentScale = scale
            _tapLocation = tapLocation
            self.content = content()
        }

        func makeUIView(context: Context) -> UIScrollView {
            
            // Setup the UIScrollView
            let scrollView = UIScrollView()
            
            scrollView.delegate = context.coordinator
            
            // for viewForZooming(in:)
            scrollView.maximumZoomScale = maximumAllowedScaleForScreen
            scrollView.minimumZoomScale = 1
            scrollView.bouncesZoom = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.clipsToBounds = true

            // Create a UIHostingController to hold our SwiftUI content
            let hostedView = context.coordinator.hostingController.view!
            
            hostedView.translatesAutoresizingMaskIntoConstraints = true
            hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostedView.frame = scrollView.bounds
            scrollView.addSubview(hostedView)

            return scrollView
            
        }

        func makeCoordinator() -> ZoomCoordinator {
            return ZoomCoordinator(hostingController: UIHostingController(rootView: content), scale: $currentScale)
        }

        func updateUIView(_ uiView: UIScrollView, context: Context) {
            
            // Update the hosting controller's SwiftUI content
            context.coordinator.hostingController.rootView = content

            if uiView.zoomScale >= uiView.minimumZoomScale {
                
                // Scale out
                uiView.setZoomScale(currentScale, animated: true)
                
            } else if tapLocation != .zero {
                
                // Scale in to a specific point
                uiView.zoom(to: rectangleZoom(for: uiView, 
                                              scale: uiView.maximumZoomScale,
                                              center: tapLocation), animated: true)
                
                // Reset the location to prevent scaling to it in case of a negative scale (manual pinch)
                // Using the main thread to prevent unexpected behavior
                DispatchQueue.main.async {
                    tapLocation = .zero
                }
                
            }

            assert(context.coordinator.hostingController.view.superview == uiView)
            
        }

        // Utils for zooming
        //
        func rectangleZoom(for scrollView: UIScrollView, scale: CGFloat, center: CGPoint) -> CGRect {
            
            let scrollViewSize = scrollView.bounds.size

            let width = scrollViewSize.width / scale
            let height = scrollViewSize.height / scale
            
            let x = center.x - (width / 2.0)
            let y = center.y - (height / 2.0)

            return CGRect(x: x, y: y, width: width, height: height)
            
        }

        // Coordinator for zooming
        //
        class ZoomCoordinator: NSObject, UIScrollViewDelegate {
            
            var hostingController: UIHostingController<Content>
            @Binding var currentScale: CGFloat

            init(hostingController: UIHostingController<Content>, scale: Binding<CGFloat>) {
                self.hostingController = hostingController
                _currentScale = scale
            }

            func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                return hostingController.view
            }

            func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
                currentScale = scale
            }
            
        }
        
    }
    
}

#Preview {
    TipGuideSwiftUIView()
}
