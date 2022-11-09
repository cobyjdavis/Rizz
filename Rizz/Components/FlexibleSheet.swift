//
//  FlexibleSheet.swift
//  Rizz
//
//  Created by CJ Davis on 12/6/21.
//

import SwiftUI

enum SheetMode {
    case none
    case quarterLow
    case quarterHigh
    case low
    case half
    case full
}

struct FlexibleSheet<Content: View>: View {
    
    let content: () -> Content
    var sheetMode: Binding<SheetMode>
    
    init(sheetMode: Binding<SheetMode>, @ViewBuilder content: @escaping () -> Content) {
        
        self.content = content
        self.sheetMode = sheetMode
        
    }
    
    private func calculateOffset() -> CGFloat {
        
        switch sheetMode.wrappedValue {
            case .none:
                return UIScreen.main.bounds.height
            case .quarterHigh:
                return UIScreen.main.bounds.height / 6
            case .quarterLow:
                return UIScreen.main.bounds.height - 200
            case .low:
            return UIScreen.main.bounds.height / 1.15
            case .half:
                return UIScreen.main.bounds.height/2
            case .full:
                return 0
        }
        
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .animation(.default)
            .edgesIgnoringSafeArea(.all)
    }
}

struct FlexibleSheet_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleSheet(sheetMode: .constant(.low)) {
            VStack {
                Text("Hello World")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        }
    }
}
