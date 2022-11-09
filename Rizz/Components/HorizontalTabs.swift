//
//  HorizontalTabs.swift
//  Rizz
//
//  Created by CJ Davis on 12/5/21.
//

import SwiftUI

struct HorizontalTabs: View {

  private let tabsSpacing = CGFloat(14)

  private func tabWidth(at index: Int) -> CGFloat {
    let label = UILabel()
    label.text = tabs[index]
    let labelWidth = label.intrinsicContentSize.width + 10
    return labelWidth
  }

  private var leadingPadding: CGFloat {
    var padding: CGFloat = 0
    for i in 0..<tabs.count {
      if i < selectedIndex {
        padding += tabWidth(at: i) + tabsSpacing
      }
    }
    return padding
  }

  let tabs: [String]

  @Binding var selectedIndex: Int

  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      HStack(spacing: tabsSpacing) {
        ForEach(0..<tabs.count, id: \.self) { index in
          Button(action: { self.selectedIndex = index }) {
            Text(self.tabs[index]).font(.custom("Gilroy-SemiBold", size: 20)).foregroundColor(self.selectedIndex == index ? .black : .gray)
          }
        }
      }
      Circle()
        .frame(width: tabWidth(at: selectedIndex), height: 5, alignment: .bottomLeading)
        .foregroundColor(.black)
        .padding(.leading, leadingPadding)
        .animation(Animation.spring())
    }
  }
}

struct HorizontalTabs_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalTabs(tabs: ["String"], selectedIndex: .constant(0))
    }
}
