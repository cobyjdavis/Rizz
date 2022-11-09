//
//  ProfilePhotoView.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ProfilePhotosView: View {
    
    @Binding var showPhotoDetailView: Bool
    @Binding var currentPost: Post?
    @Namespace var animation
    
    public init (showPhotoDetailView: Binding<Bool>, currentPost: Binding<Post?>) {
            self._showPhotoDetailView = showPhotoDetailView
            self._currentPost = currentPost
    }
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 3) {
                ForEach(posts) { post in
                    ZStack(alignment: .bottomTrailing) {
                        Image(post.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width / 3, height: 180)
                            .clipped()
                        
                        HStack(spacing: 0) {
                            Spacer()
                            Image(systemName: "bolt.fill").foregroundColor(post.rizz > 0 ? .green : .red).font(.caption).imageScale(.large).shadow(radius: 3)
                            Text("\(post.rizz)").font(.custom("Gilroy-SemiBold", size: 20)).foregroundColor(.white).shadow(radius: 3).padding(.trailing, 5)
                            //Spacer()
                        }.shadow(radius: 5).padding(.top).background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
                    }.onTapGesture {
                        withAnimation(.spring()) {
                            currentPost = post
                            showPhotoDetailView = true
                        }
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
        .overlay(
            DetailPage()
        )
    }
    
    @ViewBuilder
    func DetailPage() -> some View {
        if let currentPost = currentPost, showPhotoDetailView {
            ProfilePhotosDetailView(post: currentPost, animation: animation, showPhotoDetailView: $showPhotoDetailView)
                .matchedGeometryEffect(id: currentPost.id, in: animation)
        }
    }
}

struct Post: Identifiable {
    var id = UUID().uuidString
    var owner: String
    var imageName: String
    var caption: String
    var type: String
    var timestamp: String
    var rizz: Int
}

var posts: [Post] = [
    Post(owner: "Aaron Pray", imageName: "photo2", caption: "Graduation day. Really was lit.", type: "PHOTO", timestamp: "5 minutes ago", rizz: 492),
    Post(owner: "Aaron Pray", imageName: "photo1", caption: "How can I get some more pictures like this for me. I look good fr.", type: "PHOTO", timestamp: "5 minutes ago", rizz: 55),
    Post(owner: "Aaron Pray", imageName: "photo3", caption: "Haha I remember this day. I was really lit. Wish I could go back to those days.", type: "PHOTO", timestamp: "5 minutes ago", rizz: -24),
    Post(owner: "Aaron Pray", imageName: "photo4", caption: "Now this is a story all about how...who know that show?", type: "PHOTO", timestamp: "5 minutes ago", rizz: 2013),
    Post(owner: "Aaron Pray", imageName: "photo5", caption: "My portraits came out so good. Plus 1 if you want to see more from this shoot.", type: "PHOTO", timestamp: "5 minutes ago", rizz: 1783),
    Post(owner: "Aaron Pray", imageName: "photo6", caption: "Graduation day. Really was lit.", type: "PHOTO", timestamp: "5 minutes ago", rizz: 7),
    Post(owner: "Aaron Pray", imageName: "photo9", caption: "How can I get some more pictures like this for me. I look good fr.", type: "PHOTO", timestamp: "5 minutes ago", rizz: -3),
    Post(owner: "Aaron Pray", imageName: "photo7", caption: "Haha I remember this day. I was really lit. Wish I could go back to those days.", type: "PHOTO", timestamp: "5 minutes ago", rizz: 14),
    Post(owner: "Aaron Pray", imageName: "photo8", caption: "Now this is a story all about how...who know that show?", type: "PHOTO", timestamp: "5 minutes ago", rizz: 246),
    
]

//struct ProfilePhotosView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePhotosView()
//    }
//}
