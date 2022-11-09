//
//  Profile.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var cardPosition = BOTTOM
    @State var profilePhotoIndex: Int = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    // Hero View
    @State var showPhotoDetailView: Bool = false
    @State var currentPost: Post?
    @Namespace var animation
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                
                let frame = proxy.frame(in: .global)
                
                ZStack {
                    Image(profilePics[profilePhotoIndex].name)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frame.width, height: frame.height)
                    
                    HStack {
                        Button(action: {
                            if self.profilePhotoIndex != 0 {
                                self.profilePhotoIndex -= 1
                            }
                        }) {
                            VStack {
                                Spacer()
                            }.frame(width: frame.width / 2, height: frame.height)
                        }
                        
                        Button(action: {
                            if self.profilePhotoIndex != profilePics.count - 1 {
                                self.profilePhotoIndex += 1
                            }
                        }) {
                            VStack {
                                Spacer()
                            }.frame(width: frame.width / 2, height: frame.height)
                        }
                    }
                }
                
                VStack {
                    HStack(alignment: .top, spacing: 5) {
                        Button(action: {}) {
                            Image(systemName: "rectangle.fill.on.rectangle.angled.fill")
                                .font(Font.title2.weight(.bold))
                                .imageScale(.small)
                                .foregroundColor(.black)
                                .padding(11)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }

                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .font(Font.title2.weight(.bold))
                                .imageScale(.small)
                                .foregroundColor(.black)
                                .padding(11)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }
                    }.padding(.horizontal, 12).padding(.top, 30)
                    Spacer()
                    ProfileFooter(profilePhotoIndex: $profilePhotoIndex, frameWidth: frame.width)
                }
            }
            .blur(radius: getBlurRadius())
            .ignoresSafeArea()
            
            GeometryReader { proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                let width = proxy.frame(in: .global).width
                
                return AnyView(
                    ZStack(alignment: .top) {
                        Color.white.opacity(0.92).cornerRadius(height < 760 ? 0 : 30).ignoresSafeArea()
                        
                        VStack {
                            ProfileHeader(cardPosition: $cardPosition, offset: offset, height: height)

                            ProfileContent(showPhotoDetailView: $showPhotoDetailView, currentPost: $currentPost, animation: animation)
                        }
                        
                    }.offset(y: height - 100)
                        .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0 )
                        .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                            
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            
                            withAnimation {
                                if cardPosition == BOTTOM {
                                    if -offset > height / 8 {
                                        offset = -height + 100
                                        cardPosition = TOP
                                    } else {
                                        offset = 0
                                        cardPosition = BOTTOM
                                    }
                                } else {
                                    if -offset > height / 1.3 {
                                        offset = -height + 100
                                        cardPosition = TOP
                                    } else {
                                        offset = 0
                                        cardPosition = BOTTOM
                                    }
                                }
                            }
                            
                            lastOffset = offset
                        }))
                )
            }.ignoresSafeArea(.all, edges: .bottom)
        }.overlay(
            DetailPage().edgesIgnoringSafeArea(.all)
        )
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        
        return progress * 10
    }
    
    @ViewBuilder
    func DetailPage() -> some View {
        if let currentPost = currentPost, showPhotoDetailView {
            ProfilePhotosDetailView(post: currentPost, animation: animation, showPhotoDetailView: $showPhotoDetailView)
                .matchedGeometryEffect(id: currentPost.id, in: animation)
        }
    }
}

struct ProfilePic: Identifiable {
    var id = UUID().uuidString
    var name: String
}

var profilePics: [ProfilePic] = [ProfilePic(name: "photo4"),
                               ProfilePic(name: "photo7"),
                               ProfilePic(name: "photo6")]

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
