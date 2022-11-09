//
//  ScrollTest.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

struct ScrollTest: View {
    
    @State var offset: CGFloat = 0
    @State var dragOffset: CGFloat = 0
    @State var height: CGFloat = 0
    
    var body: some View {
        //GeometryReader { proxy in
        ZStack(alignment: .trailing) {
            TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset, contentHeight: $height) {
                HStack(alignment: .top) {
                    VStack {
                        ForEach(0..<100) { i in
                            Text("\(i)")
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 100)
                }.frame(width: UIScreen.main.bounds.width)
            }.edgesIgnoringSafeArea(.all)
            
            
            ZStack(alignment: .top) {
//                VStack {
//                    Text("\(UIScreen.main.bounds.height - 50)").padding().background(Color.orange)
//                    Text("\(offset)").padding().background(Color.orange)
//                    Text("\(calculateOffset())").padding().background(Color.orange)
//                }
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 3, height: UIScreen.main.bounds.height - 100)
                
                Capsule()
                    .fill(Color.orange)
                    .frame(width: 4, height: 60)
                    .offset(y: offset > 0 ? calculateOffset() : 0)
                    .offset(y: dragOffset)
                    .gesture(DragGesture().onChanged({ value in
                        if value.location.y > 50 && value.location.y <= UIScreen.main.bounds.height - 100 {
                            
                            dragOffset = value.location.y - 100
                        }
                    }).onEnded({ _ in
                        offset = dragOffset
                    }))
            }.padding(.trailing, 10)
        }.padding(.top, 50)
        //}
    }
    
    func calculateOffset() -> CGFloat {
        let barHeight = (UIScreen.main.bounds.height - 100).rounded()
        let indicator = (offset * barHeight).rounded()
        let trueOffset = (indicator / self.height).rounded()
        
        return trueOffset
    }
}


struct ScrollTest_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTest()
    }
}
