//
//  ProfileFooter.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ProfileFooter: View {
    
    @Binding var profilePhotoIndex: Int
    var frameWidth: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Aaron Pray").font(.custom("Gilroy-Bold", size: 30)).foregroundColor(.white).shadow(radius: 1)
                    Image(systemName: "checkmark.seal.fill").foregroundColor(.blue).imageScale(.large).shadow(radius: 0)
                }.lineLimit(1)
                Text("PG County, MD").foregroundColor(.white).font(.custom("Gilroy-SemiBold", size: 18))
                Text("I am a 23 year old singer born in California. Currently signed to No Limit Record Label. I love all my supporters! Giveaways every month.").foregroundColor(.white).font(.custom("Gilroy-SemiBold", size: 18)).padding(.trailing).padding(.top, 5).lineLimit(3)
                HStack {
                    Spacer()
                    ForEach(0..<3) { index in
                        RoundedRectangle(cornerRadius: 10).frame(width: 50, height: 7).foregroundColor(profilePhotoIndex == index ? Color.white : Color.gray.opacity(0.5))
                    }
                    Spacer()
                }.padding()
            }.shadow(radius: 5).padding(.horizontal, 9).frame(width: frameWidth).padding(.bottom, 100).background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom))
        }
    }
}

//struct ProfileFooter_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileFooter()
//    }
//}
