//
//  FavouriteSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024.
//

import SwiftUI

struct FavouriteSwiftUIView: View {
    
    var favouriteArray = TipsModel().getAllTheInfoTips()
    
    var body: some View {
        
        NavigationView {
            
            // create List + array
            List(favouriteArray) { array in
                
                NavigationLink(destination: DetailScreen(favouriteItem: array)) {
                    
                    VStack {
                        Text(array.idDateString)
                            .padding(.trailing)
                    }
                    
                }
                
            }
            .navigationTitle("Favourite.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
            
        }
        
    }
    
}

struct DetailScreen: View {
    
    let favouriteItem: FavouriteObject
    
    var body: some View {
     
        VStack(alignment: .center) {
            
            Spacer()
            
            HStack {
                Text(favouriteItem.tipDate)
                    .font(.largeTitle)
                    .bold()
            }
            
            VStack {
            
                HStack {
                    
                    Text(Localize(key: "sMR-W3-hJp.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipBill)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack {
                    
                    Text(Localize(key: "DYB-h6-QW8.title", comment: "") + " (\(String(format: "%.0f", favouriteItem.tipPercent))%)")
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipTips)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack {
                    
                    Text(Localize(key: "gl0-kh-bjo.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipTotal)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack {
                    
                    Text(Localize(key: "1EH-gv-upV.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text(String(favouriteItem.tipPeople))
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack {
                    
                    Text(Localize(key: "qeQ-Lf-lwt.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipEachPay)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                Text("Favourite-Description".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                    .font(.subheadline)
                    .padding(.top, 10)
                
                HStack {
                
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable().renderingMode(.original).frame(width: 30, height: 30, alignment: .leading)
                    
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,
                                                                                               lineWidth: 2))
                    
                    Text("Saved by Tips")
                        .font(.subheadline)
                    
                }
                .padding(.top, 10)
                     
            }
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(favouriteItem.idDateString), displayMode: .inline)

    }
    
}

struct FavouriteObject: Identifiable {
    
    let id = UUID()
    let idDateString: String
    let tipDate: String
    let tipCurrency: String
    let tipBill: Double
    let tipPercent: Double
    let tipTips: Double
    let tipTotal: Double
    let tipPeople: Int
    let tipEachPay: Double
    
}

#Preview {
    FavouriteSwiftUIView()
}
