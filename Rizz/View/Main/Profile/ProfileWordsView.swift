//
//  ProfileWordsView.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ProfileWordsView: View {
    
    init(){
           UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
       }
    
    var body: some View {
        List {
            ForEach(wordPosts.numbered(), id: \.element.id) { index, post in
                ProfileWordsRowView(index: index, post: post)
            }
            .listRowSeparator(.hidden)
        }.edgesIgnoringSafeArea(.all).listStyle(.plain)
    }
}


struct WordPost: Identifiable {
    var id = UUID().uuidString
    var title: String
    var owner: String
    var text: String
    var timestamp: String
    var rizz: Int
    var imageName: String
}

var wordPosts: [WordPost] = [
    WordPost(title: "Like What...", owner: "Aaron Pray", text: "My portraits came out so good. Plus 1 if you want to see more from this shoot. bruh like what", timestamp: "5min", rizz: -5, imageName: ""),
    WordPost(title: "How to get away with murder", owner: "Aaron Pray", text: "Graduation day. Really was lit.", timestamp: "3D", rizz: 25, imageName: "photo4"),
    WordPost(title: "Big dawg", owner: "Aaron Pray", text: "How can I get some more pictures like this for me. I look good fr.", timestamp: "1W", rizz: 92, imageName: ""),
    WordPost(title: "...", owner: "Aaron Pray", text: "Haha I remember this day. I was really lit. Wish I could go back to those days. I cant believe people really doing all that. Like who does that. Go get a life.", timestamp: "3M", rizz: -14, imageName: ""),
    WordPost(title: "Look at this!", owner: "Aaron Pray", text: "Now this is a story all about how...who know that show?", timestamp: "3Y", rizz: 934, imageName: "photo2"),
    WordPost(title: "", owner: "Aaron Pray", text: "bruh🤯", timestamp: "2Y", rizz: 107, imageName: "")
]

struct ProfileWordsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileWordsView()
    }
}

var colors = [Color.orange, Color.purple, Color.blue, Color.yellow, Color.red]

struct ProfileWordsRowView: View {
    
    var index: Int
    var post: WordPost
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                HStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(colors[index % 5])
                        .frame(width: 4)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 5) {
                            if post.title != "" {
                                Text(post.title).font(.custom("Gilroy-SemiBold", size: 20)).foregroundColor(.black).lineLimit(1)
                                
                                Text("•").font(.custom("Gilroy-SemiBold", size: 19)).foregroundColor(.gray)
                                
                            }
                            
                            Text("\(post.timestamp)").font(.custom("Gilroy-SemiBold", size: 19)).foregroundColor(.gray)
                        }
                        HStack {
                            Text(post.text)
                                .font(.custom("Gilroy", size: 16))
                                .foregroundColor(Color.black.opacity(0.8)).padding(.top, 5)
                        }
                    }
                }
                
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
                }
            }.listRowInsets(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 10))
        }.listRowBackground(Color.white.opacity(0.9))
    }
}
