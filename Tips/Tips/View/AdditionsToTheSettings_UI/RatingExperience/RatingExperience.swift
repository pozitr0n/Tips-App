//
//  RatingExperience.swift
//  Tips
//
//  Created by Raman Kozar on 05/04/2024.
//

import SwiftUI

struct PersonalIconShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        let iconWidth = rect.size.width
        let iconHeight = rect.size.height
        
        path.move(to: CGPoint(x: 0, y: 0.5 * iconHeight))
        path.addCurve(to: CGPoint(x: 0.01522 * iconWidth, y: 0.26261 * iconHeight), control1: CGPoint(x: 0, y: 0.37048 * iconHeight), control2: CGPoint(x: 0.00677 * iconWidth, y: 0.26486 * iconHeight))
        path.addLine(to: CGPoint(x: 0.9674 * iconWidth, y: 0.00869 * iconHeight))
        path.addCurve(to: CGPoint(x: iconWidth, y: 0.5 * iconHeight), control1: CGPoint(x: 0.98531 * iconWidth, y: 0.00392 * iconHeight), control2: CGPoint(x: iconWidth, y: 0.22528 * iconHeight))
        path.addLine(to: CGPoint(x: iconWidth, y: 0.5 * iconHeight))
        path.addCurve(to: CGPoint(x: 0.9674 * iconWidth, y: 0.99131 * iconHeight), control1: CGPoint(x: iconWidth, y: 0.77473 * iconHeight), control2: CGPoint(x: 0.98531 * iconWidth, y: 0.99608 * iconHeight))
        path.addLine(to: CGPoint(x: 0.01522 * iconWidth, y: 0.73739 * iconHeight))
        path.addCurve(to: CGPoint(x: 0, y: 0.5 * iconHeight), control1: CGPoint(x: 0.00677 * iconWidth, y: 0.73514 * iconHeight), control2: CGPoint(x: 0, y: 0.62952 * iconHeight))
        path.addLine(to: CGPoint(x: 0, y: 0.5 * iconHeight))
        path.closeSubpath()
        
        return path
        
    }
    
}

struct RatingExperience: View {
    
    @State private var dragOffset: CGFloat = 0.0
    @State private var initDragOffset: CGFloat = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    private var widthOfSlider: CGFloat = 220.0
    private var spacingOfCircle: CGFloat = 44.0
    
    @Environment(\.openURL) var open_URL
    @State private var showEmailAddress = false
    @State private var email = ReviewEmail(toEmailAddress: "pozitr0n.kozarroman@gmail.com",
                                           currentsubject: "Feedback-about".localizedSwiftUI(CurrentLanguage.shared.currentLanguage),
                                           mainMessageHeader: "Feedback-text".localizedSwiftUI(CurrentLanguage.shared.currentLanguage),
                                           mainBodyOfTheMail: """
                                                 Application Name: \(Bundle.main.displayingName)
                                                 iOS: \(UIDevice.current.systemVersion)
                                                 App Version: \(Bundle.main.displayingAppVersion)
                                                 App Build: \(Bundle.main.displayingAppBuild)
                                                 \("Feedback-text".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                                 --------------------------------------
                                                 """)
    
    // Main struct SectionEmojies for emojies info
    //
    struct SectionEmojies {
        
        let emojiName:         String
        let emojiDescription:  String
        let rangeOfEmoji:      ClosedRange<Double>
        
    }
    
    private let allEmojiSections: [SectionEmojies] = [
        
        SectionEmojies(emojiName: "\u{1F621}", emojiDescription: "Angry.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), rangeOfEmoji: 0...0.2),
        SectionEmojies(emojiName: "\u{1F615}", emojiDescription: "Confused.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), rangeOfEmoji: 0.2...0.4),
        SectionEmojies(emojiName: "\u{1F60A}", emojiDescription: "Happy.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), rangeOfEmoji: 0.4...0.6),
        SectionEmojies(emojiName: "\u{1F603}", emojiDescription: "Excited.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), rangeOfEmoji: 0.6...0.8),
        SectionEmojies(emojiName: "\u{1F60D}", emojiDescription: "In-Love.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), rangeOfEmoji: 0.8...1)
        
    ]
    
    var body: some View {
        
        let mainProgress = dragOffset / widthOfSlider
        let currentEmojiSection = allEmojiSections.first(where: { $0.rangeOfEmoji.contains(Double(mainProgress)) }) ?? allEmojiSections.last
        
        ZStack {
                        
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Rate-your-experience.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                        .bold()
                        .font(.title3)
                        .foregroundStyle(Color("TextRateColor"))
                    Text(currentEmojiSection?.emojiDescription ?? "")
                        .font(.system(size: 15))
                        .foregroundStyle(Color("TextRateColor"))
                }
                
                HStack {
                    Text(currentEmojiSection?.emojiName ?? "")
                        .font(.system(size: 40))
                        .transition(.scale)
                        .animation(.easeOut(duration: 0.3), value: currentEmojiSection?.emojiName)
                    
                    ZStack(alignment: .leading) {
                        
                        PersonalIconShape().frame(width: 230, height: 15)
                            .foregroundStyle(Color("RateColor"))
                        
                        PersonalIconShape().frame(width: CGFloat(dragOffset) + 10, height: 15)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.red .opacity(0.8), .yellow]), startPoint: .leading, endPoint: .trailing))
                        
                        HStack(spacing: spacingOfCircle) {
                            
                            ForEach(0..<allEmojiSections.count, id: \.self) { currentIndex in
                                
                                Circle().frame(width: 6 + CGFloat(currentIndex) * 1, height: 6 + CGFloat(currentIndex) * 1)
                                    .foregroundStyle(Color("TextRateColorInvert"))
                                
                            }
                            
                        }
                        .offset(x: 5)
                        
                        Circle().frame(width: 30, height: 30)
                            .offset(x: dragOffset)
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
                            .gesture(
                                
                                DragGesture()
                                    .onChanged({ currentValue in
                                        
                                        let currentChange = currentValue.translation.width
                                        let updatingValue = min(max(initDragOffset + currentChange, 0), self.widthOfSlider - 15)
                                        self.dragOffset = updatingValue
                                        
                                    })
                                    .onEnded({ currentValue in
                                        self.initDragOffset = dragOffset
                                    })
                                
                            )
                            .onAppear{
                                self.initDragOffset = dragOffset
                            }
                        
                    }
                    
                }
                
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    VStack {
                    
                        Button("Send.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)) {
                            
                            email.changeBody(changings: "\("Email-text".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)) -  \(currentEmojiSection?.emojiDescription ?? "") \(currentEmojiSection?.emojiName ?? "")")
                            email.sendMailUsingURL(open_URL: open_URL)
                            dismiss()
                            
                        }
                        .bold()
                        .foregroundStyle(Color("TextRateColor"))
                    
                    }
                    
                    Spacer()
                    
                }
                
            }
            .frame(width: 300, height: 150)
            .padding([.leading, .trailing], 25)
            .background(Color("TextRateColorInvert"), in: RoundedRectangle(cornerRadius: 25, style: .continuous))
            .sheet(isPresented: $showEmailAddress, content: {
            
                MailSwiftUIView(supportDataIfEmail: $email) { result in
                    switch result {
                    case .success:
                        print("Email sent")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            })
            
        }
        
    }
    
}

#Preview {
    SettingsSwiftUIView()
}
