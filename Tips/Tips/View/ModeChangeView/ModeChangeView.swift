//
//  ModeChangeView.swift
//  Tips
//
//  Created by Raman Kozar on 19/03/2024.
//

import SwiftUI

enum Mode: String, CaseIterable {
    
    case systemDefaultMode  = "Default"
    case lightMode          = "Light"
    case darkMode           = "Dark"
    
    // Getting color for mode change view
    //
    func getColor(_ scheme: ColorScheme) -> Color {
    
        switch self {
        case .systemDefaultMode:
            return scheme == .dark ? .moonMode : .sunMode
        case .lightMode:
            return .sunMode
        case .darkMode:
            return .moonMode
        }
        
    }
    
    var colorScheme: ColorScheme? {
    
        switch self {
        case .systemDefaultMode:
            return nil
        case .lightMode:
            return .light
        case .darkMode:
            return .dark
        }
        
    }
    
}

struct ModeChangeView: View {
    
    var scheme: ColorScheme
    @AppStorage("userTheme") private var userTheme: Mode = .systemDefaultMode
    
    // For sliding effect
    @Namespace private var animation
    
    // View properties
    @State private var circleOffset: CGSize
    
    init(scheme: ColorScheme) {
        self.scheme = scheme
        let isDark = scheme == .dark
        self._circleOffset = .init(initialValue: CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : -150))
    }
    
    var body: some View {
    
        VStack(spacing: 15) {
            
            Circle()
                .fill(userTheme.getColor(scheme).gradient)
                .frame(width: 150, height: 150)
                .mask {
                    
                    // Inverted mask
                    Rectangle()
                        .overlay {
                            Circle()
                                .offset(circleOffset)
                                .blendMode(.destinationOut)
                        }
                    
                }
            
            Text("Choose a Mode")
                .font(.title2.bold())
                .padding(.top, 25)
            
            Text("Pop or subtle, Day or Night.\nCustomize your interface.")
                .multilineTextAlignment(.center)
            
            // Custom segmented picker
            HStack(spacing: 0) {
                ForEach(Mode.allCases, id: \.rawValue) { mode in
                    
                    Text(mode.rawValue)
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .background {
                            ZStack {
                                
                                if userTheme == mode {
                                    Capsule()
                                        .fill(.modeBG)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                                
                            }
                            .animation(.snappy, value: userTheme)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            userTheme = mode
                        }
                    
                }
            }
            .padding(3)
            .background(.primary.opacity(0.06), in: .capsule)
            .padding(.top, 20)
            
        }
        
        // Maximum height = 410
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 410)
        .background(.modeBG)
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal, 15)
        .environment(\.colorScheme, scheme)
        .onChange(of: scheme, initial: false) { _, newValue in
        
            let isDark = newValue == .dark
            withAnimation(.bouncy) {
                
                circleOffset = CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : -150)
                
            }
            
        }
        
    }
    
}

#Preview {
    SettingsSwiftUIView()
}
