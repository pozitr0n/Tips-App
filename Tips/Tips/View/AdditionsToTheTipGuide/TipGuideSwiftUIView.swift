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
    
    @State private var searchText = ""
        
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
                            
                            VStack {
                                
                                Text(currentCountry.restaurantTipInitial)
                                    .padding(.trailing)
                                Text(currentCountry.restaurantTipFinal)
                                    .padding(.trailing)
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Hotel.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            VStack {
                                
                                Text(currentCountry.hotelTipInitialUSD)
                                    .padding(.trailing)
                                Text(currentCountry.hotelTipFinalUSD)
                                    .padding(.trailing)
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Driver.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                        List(countryInfo.filteredCountriesWithTips) { currentCountry in
                            
                            VStack {
                                
                                Text(currentCountry.driverTipInitial)
                                    .padding(.trailing)
                                Text(currentCountry.driverTipLimit)
                                    .padding(.trailing)
                                
                            }
                            
                        }
                    }
                    
                }
                .navigationTitle("Tip-Guide.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                
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
