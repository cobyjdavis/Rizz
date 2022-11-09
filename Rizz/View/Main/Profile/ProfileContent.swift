//
//  ProfileContent.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ProfileContent: View {
    
    @State var currentSelection: Int = 0
    @Binding var showPhotoDetailView: Bool
    @Binding var currentPost: Post?
    var animation: Namespace.ID

    var body: some View {
        PagerTabView(tint: .black, selection: $currentSelection) {
            Text("Photos")
                .font(.custom("Gilroy-Bold", size: 18))
                .foregroundColor(currentSelection == 0 ? .black : .gray)
                .pageLabel()
            
//            Text("Videos")
//                .font(.custom("Gilroy-Bold", size: 18))
//                .foregroundColor(currentSelection == 1 ? .black : .gray)
//                .pageLabel()
            
            Text("Words")
                .font(.custom("Gilroy-Bold", size: 18))
                .foregroundColor(currentSelection == 2 ? .black : .gray)
                .pageLabel()
        } content: {
            ProfilePhotosView(showPhotoDetailView: $showPhotoDetailView, currentPost: $currentPost)
                .pageView(ignoresSafeArea: true, edges: .bottom)
            
//            ProfilePhotosView(showPhotoDetailView: $showPhotoDetailView, currentPost: $currentPost)
//                .pageView(ignoresSafeArea: true, edges: .bottom)
            
            ProfileWordsView()
                .pageView(ignoresSafeArea: true, edges: .bottom)
        }.ignoresSafeArea(.container, edges: .bottom)
    }
}

//struct ProfileContent_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileContent()
//    }
//}
