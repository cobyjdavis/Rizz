//
//  ProfileHeader.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ProfileHeader: View {
    
    @Binding var cardPosition: String
    @Namespace private var namespace
    var offset: CGFloat
    var height: CGFloat
    
    var body: some View {
        if cardPosition == BOTTOM {
            HStack {
                VStack(alignment: .leading) {
                    HStack(spacing: 1) {
                        Image(systemName: "bolt.fill").foregroundColor(.orange).font(.title2).imageScale(.large)
                        Text("2416").font(.custom("Gilroy-SemiBold", size: 28)).foregroundColor(.black)
                    }
                    Text("aaronprayiii").font(.custom("Gilroy-SemiBold", size: 16)).foregroundColor(.gray).padding(.leading)
                }
                Spacer()
                Button(action: {}) {
                    //                VStack {
                    //                    Text("\(offset)")
                    //                    Text("\(height)")
                    //                }
                    Text("Subscribe").font(.custom("Gilroy-SemiBold", size: 18)).foregroundColor(.white).padding(.vertical, 13).padding(.horizontal, 40).background(Color.black).cornerRadius(30).shadow(radius: 1)
                }
            }.padding().padding(.vertical, offset <= -height + 100 ? -12 : 7)
            .matchedGeometryEffect(id: "header", in: namespace)
            //.background(cardPosition == TOP ? .blue : .clear).cornerRadius(30)
        } else {
            VStack {
                HStack {
                    HStack(spacing: 0) {
                        Image(systemName: "bolt.fill").foregroundColor(.orange).font(.title3).imageScale(.medium)
                        Text("2416").font(.custom("Gilroy-SemiBold", size: 20)).foregroundColor(.black)
                    }
                    Spacer()
                    
                    Text("aaronprayiii").font(.custom("Gilroy-SemiBold", size: 25)).foregroundColor(.black).autocapitalization(.words)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .imageScale(.medium)
                            .foregroundColor(.black)
                            .shadow(radius: 1)
                            .padding(.leading, 25)
                    }
                }.padding().padding(.vertical, offset <= -height + 100 ? -12 : 7)
                
                Divider()
                    .opacity(0.5)
                    .frame(height: 1)
                    .padding(.bottom, 10)
            }.matchedGeometryEffect(id: "header", in: namespace)
        }
    }
    
    func getScale() -> Double {
        let maxHeight = height - 100
        let offset = -offset
        let scale = Double(offset / maxHeight)
        
        let progress = scale
        
        return progress
    }
}

//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeader(cardPosition: "BOTTOM", offset: ), height: <#CGFloat#>)
//    }
//}
