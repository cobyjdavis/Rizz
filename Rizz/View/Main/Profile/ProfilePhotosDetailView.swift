//
//  ProfilePhotosDetailView.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ProfilePhotosDetailView: View {
    
    var post: Post
    var animation: Namespace.ID
    @State var showMore = true
    @Binding var showPhotoDetailView: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(post.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getScreeenBounds().width, height: getScreeenBounds().height)
                .clipped()
                .onTapGesture {
                    withAnimation(.default) {
                        self.showMore.toggle()
                    }
                }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {self.showPhotoDetailView = false}) {
                        Image(systemName: "xmark")
                            .imageScale(.medium)
                            .font(Font.headline.bold())
                            .foregroundColor(.white)
                            .padding(14)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }.padding(.top, 40).padding(.trailing, 10)
                }
                    
                Spacer()
                
                if self.showMore {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(post.caption).foregroundColor(.white).font(.custom("Gilroy-SemiBold", size: 17)).lineLimit(3)
                            Text(post.timestamp).foregroundColor(.white).font(.custom("Gilroy-SemiBold", size: 15))
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {}) {
                                Image(systemName: "chevron.up")
                                    .resizable()
                                    .frame(width: 25, height: 13)
                                    .font(Font.title3)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 6)
                            }
                            
                            Text("\(post.rizz)").font(.custom("Gilroy-SemiBold", size: 18)).foregroundColor(.white)
                            
                            Button(action: {}) {
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .frame(width: 25, height: 13)
                                    .font(Font.title3)
                                    .foregroundColor(Color.white)
                            }
                        }
                    }.shadow(radius: 5).padding().padding(.top).padding(.bottom, 25).frame(width: getScreeenBounds().width).background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                }
            }
        }.edgesIgnoringSafeArea(.all)
        .matchedGeometryEffect(id: post.id, in: animation)
    }
}

//struct ProfilePhotosDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePhotosDetailView()
//    }
//}
