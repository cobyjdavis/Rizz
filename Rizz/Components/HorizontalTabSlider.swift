//
//  HorizontalTabSlider.swift
//  Rizz
//
//  Created by CJ Davis on 1/30/22.
//

import SwiftUI

extension HorizontalAlignment {
    private enum UnderlineLeading: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.leading]
        }
    }

    static let underlineLeading = HorizontalAlignment(UnderlineLeading.self)
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat(0)

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }

    typealias Value = CGFloat
}


struct GridViewHeader : View {

    @State private var activeIdx: Int = 0
    @State private var w: [CGFloat] = [0, 0, 0, 0]

    var body: some View {
        return VStack(alignment: .underlineLeading) {
            HStack(spacing: 15) {
                Text("popular")
                    .font(.custom("Gilroy-SemiBold", size: 18))
                    .foregroundColor(self.activeIdx == 0 ? .black : .gray)
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 0))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[0] = $0 })
                
                Text("subscribers")
                    .font(.custom("Gilroy-SemiBold", size: 18))
                    .foregroundColor(self.activeIdx == 1 ? .black : .gray)
                    .modifier(MagicStuff(activeIdx: $activeIdx, idx: 1))
                    .background(TextGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[1] = $0 })
            }
            
            Circle()
                .alignmentGuide(.underlineLeading) { d in d[.leading]  }
                .foregroundColor(.orange)
                .frame(width: w[activeIdx],  height: 5)
                .animation(.linear)
        }
    }
}

struct TextGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle().fill(Color.clear).preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}

struct MagicStuff: ViewModifier {
    @Binding var activeIdx: Int
    let idx: Int

    func body(content: Content) -> some View {
        Group {
            if activeIdx == idx {
                content.alignmentGuide(.underlineLeading) { d in
                    return d[.leading]
                }.onTapGesture { self.activeIdx = self.idx }

            } else {
                content.onTapGesture { self.activeIdx = self.idx }
            }
        }
    }
}

