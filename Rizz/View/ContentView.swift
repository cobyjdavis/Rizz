//
//  ContentView.swift
//  Rizz
//
//  Created by CJ Davis on 12/3/21.
//

import SwiftUI
import Introspect
import SwiftUICharts
import UIKit

struct ContentView: View {
    var body: some View {
        ProfileView().background(Color.white.opacity(0.9))
        //ScrollTest()
    }
}

struct FeedView: View {
    
    @State var selectedTab = 0
    @State private var selectedTabIndex = 0
    @Namespace private var animation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<feedPosts.count) { index in
                        if feedPosts[index].type == "PHOTO" {
                            FeedPostRowView(index: index, post: feedPosts[index])
                        } else {
                            FeedWordsRowView(index: index, post: feedPosts[index])
                                .padding(.vertical, 2)
                        }
                    }
                }.padding(.top, 50)
                .padding(.bottom, 100)
                .padding(.leading, 2)
                .padding(.trailing, 10)
            }
            
            HStack(alignment: .top) {
                GridViewHeader()
                
                Spacer()
                
                HStack(spacing: 1) {
                    Image(systemName: "bolt.fill").foregroundColor(.orange).font(.title3).imageScale(.small)
                    Text("2416").font(.custom("Gilroy-SemiBold", size: 20)).foregroundColor(.black)
                }
            }.padding(.bottom, 30).padding(.top, 20).padding(.horizontal).background(Color.white.opacity(0.95).edgesIgnoringSafeArea(.bottom))
        }.background(Color.white.opacity(0.9)).edgesIgnoringSafeArea(.all)
    }
}

struct FeedWordsRowView: View {
    
    var index: Int
    var post: FeedPost
    
    @State var color = Color.clear.opacity(0.4)
    @State var colorOpacity = 0.4
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    @State var hasError = false
    
    var body: some View {
        
        ZStack {
            color.opacity(self.colorOpacity)
            
            VStack(alignment: .leading) {
                HStack {
                    Image("photo\(index + 1)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                    
                    
                    HStack(spacing: 5) {
                        if post.title != "" {
                            Text(post.title).font(.custom("Gilroy-SemiBold", size: 20)).foregroundColor(.black).lineLimit(1)
                            
                            Text("•").font(.custom("Gilroy-SemiBold", size: 19)).foregroundColor(.gray)
                            
                        }
                        
                        Text("\(post.timestamp)").font(.custom("Gilroy-SemiBold", size: 19)).foregroundColor(.gray)
                    }
                }
                
                HStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 4)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack {
                            Text(post.caption)
                                .font(.custom("Gilroy", size: 16))
                                .foregroundColor(Color.black.opacity(0.8))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }.padding(.leading, 10)
                
                HStack {
                    HStack(spacing: 3) {
                        Image(systemName: "message.fill")
                            .imageScale(.small)
                            .font(Font.title3.bold())
                            .foregroundColor(Color.gray.opacity(0.4))
                        
                        Text("Comments")
                            .font(.custom("Gilroy-Semibold", size: 16))
                            .foregroundColor(Color.gray.opacity(0.8))
                    }
                    .frame(width: 130, height: 35)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.small)
                            .font(Font.title3.bold())
                            .foregroundColor(Color.gray.opacity(0.4))
                        
                        Text("Share")
                            .font(.custom("Gilroy-Semibold", size: 16))
                            .foregroundColor(Color.gray.opacity(0.8))
                    }
                    .frame(width: 90, height: 35)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "bolt.fill")
                            .imageScale(.small)
                            .font(Font.body.bold())
                            .foregroundColor(Color.orange)
                        
                        Text("\(post.rizz)")
                            .font(.custom("Gilroy-Semibold", size: 16))
                            .foregroundColor(post.rizz > 0 ? Color.gray.opacity(0.7) : Color.red.opacity(0.5))
                    }
                    .frame(width: 70, height: 35)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "ellipsis")
                            .imageScale(.small)
                            .font(Font.title3.bold())
                            .foregroundColor(Color.gray.opacity(0.4))
                    }
                    .frame(width: 50, height: 35)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }.padding(.leading, 8)
            }
        }
        .gesture(DragGesture()
                    .onChanged { gesture in
                        if self.isSwipping {
                            self.startPos = gesture.location
                            self.isSwipping.toggle()
                        }
                    }
                    .onEnded { gesture in
                        let xDist =  abs(gesture.location.x - self.startPos.x)
                        let yDist =  `abs`(gesture.location.y - self.startPos.y)
                    
        //                if self.startPos.y <  gesture.location.y && yDist > xDist {
        //                    self.direction = "Down"
        //                    self.color = Color.green.opacity(0.4)
        //                }
        //                else if self.startPos.y >  gesture.location.y && yDist > xDist {
        //                    self.direction = "Up"
        //                    self.color = Color.blue.opacity(0.4)
        //                }
                        if self.startPos.x > gesture.location.x && yDist < xDist {
                            self.color = Color.red.opacity(0.4)
                            withAnimation(Animation.easeIn.delay(0.3)) {
                                self.colorOpacity = 0
                            }
                        }
                        else if self.startPos.x < gesture.location.x && yDist < xDist {
                            self.color = Color.green.opacity(0.4)
                            withAnimation {
                                self.colorOpacity = 0
                            }
                        }
                    
                        self.isSwipping.toggle()
                        self.colorOpacity = 0.1
                    }
            )
    }
}

struct FeedPost: Identifiable {
    var id = UUID().uuidString
    var owner: String
    var imageName: String
    var caption: String
    var title: String
    var type: String
    var rizz: Int
    var timestamp: String
}

var feedPosts: [FeedPost] = [
    FeedPost(id: "", owner: "Aaron Pray", imageName: "photo2", caption: "How is it that they make this stuff? I be so confused bruh..", title: "", type: "PHOTO", rizz: 342, timestamp: "5min"),
    FeedPost(id: "", owner: "CJ Davis", imageName: "", caption: "On who they rl jst made the superbowl?! I really thought they were done for. Ik we seeing them next year though.😈", title: "No wayyy", type: "WORD", rizz: -22, timestamp: "17min"),
    FeedPost(id: "", owner: "DevoG", imageName: "", caption: "Lets freaking go", title: "", type: "WORD", rizz: 7, timestamp: "1h"),
    FeedPost(id: "", owner: "CJ Davis", imageName: "photo3", caption: "This is how we do it", title: "I freaking knew it", type: "PHOTO", rizz: 81, timestamp: "1d"),
    FeedPost(id: "", owner: "Aaron Pray", imageName: "photo1", caption: "How is it that they make this stuff?", title: "", type: "PHOTO", rizz: 5932, timestamp: "5min"),
    FeedPost(id: "", owner: "CJ Davis", imageName: "", caption: "On who they rl jst made the superbowl?!", title: "Im rl the best", type: "WORD", rizz: 65, timestamp: "17min"),
    FeedPost(id: "", owner: "DevoG", imageName: "", caption: "Lets freaking go", title: "No wayyy", type: "WORD", rizz: -3, timestamp: "1h"),
    FeedPost(id: "", owner: "CJ Davis", imageName: "photo3", caption: "This is how we do it", title: "", type: "WORD", rizz: 420, timestamp: "1d")
]


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        FeedView()
        //ProfileWordsView()
        //ScrollTest()
    }
}

struct Tab: Identifiable {
    var id = UUID().uuidString
    var index: Int
    var text: String
    var image: String
    var color: Color
}

var tabs: [Tab] = [
    Tab(index: 0, text: "popular", image: "", color: .red),
    Tab(index: 1, text: "subscribers", image: "", color: .blue)
]

extension Sequence {
    /// Numbers the elements in `self`, starting with the specified number.
    /// - Returns: An array of (Int, Element) pairs.
    func numbered(startingAt start: Int = 0) -> [(number: Int, element: Element)] {
        Array(zip(start..., self))
    }
}


struct FeedPostRowView: View {
    
    var index: Int
    var post: FeedPost
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                Image("photo\(index + 1)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .shadow(radius: 3)
                
                if post.title == "" {
                    Text(post.owner)
                        .font(.custom("Gilroy-SemiBold", size: 20))
                        .foregroundColor(.gray)
                } else {
                    Text(post.title)
                        .font(.custom("Gilroy-SemiBold", size: 20))
                        .foregroundColor(.black)
                }
                
                Text("• \(post.timestamp)")
                    .font(.custom("Gilroy-SemiBold", size: 20))
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                
                Spacer()
                
            }
            
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 4)
                
                VStack(alignment: .leading) {
                    Image(post.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                        .clipped()
                        .cornerRadius(20)
                    
                    HStack {
                        Text(post.caption)
                            .font(.custom("Gilroy", size: 16))
                            .foregroundColor(Color.black.opacity(0.8))
                    }
                }
            }.padding(.leading, 10)
            
            HStack {
                HStack(spacing: 3) {
                    Image(systemName: "message.fill")
                        .imageScale(.small)
                        .font(Font.title3.bold())
                        .foregroundColor(Color.gray.opacity(0.4))
                    
                    Text("Comments")
                        .font(.custom("Gilroy-Semibold", size: 16))
                        .foregroundColor(Color.gray.opacity(0.8))
                }
                .frame(width: 130, height: 35)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                HStack(spacing: 3) {
                    Image(systemName: "paperplane.fill")
                        .imageScale(.small)
                        .font(Font.title3.bold())
                        .foregroundColor(Color.gray.opacity(0.4))
                    
                    Text("Share")
                        .font(.custom("Gilroy-Semibold", size: 16))
                        .foregroundColor(Color.gray.opacity(0.8))
                }
                .frame(width: 90, height: 35)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                HStack(spacing: 3) {
                    Image(systemName: "bolt.fill")
                        .imageScale(.small)
                        .font(Font.body.bold())
                        .foregroundColor(Color.orange)
                    
                    Text("\(post.rizz)")
                        .font(.custom("Gilroy-Semibold", size: 16))
                        .foregroundColor(post.rizz > 0 ? Color.gray.opacity(0.7) : Color.red.opacity(0.5))
                }
                .frame(width: 70, height: 35)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                HStack(spacing: 3) {
                    Image(systemName: "ellipsis")
                        .imageScale(.small)
                        .font(Font.title3.bold())
                        .foregroundColor(Color.gray.opacity(0.4))
                }
                .frame(width: 50, height: 35)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }.padding(.leading, 8)
        }.padding(.vertical, 2)
        .padding(.leading, 3)
    }
}
