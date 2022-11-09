//
//  ExpandableButton.swift
//  Rizz
//
//  Created by CJ Davis on 12/5/21.
//

import SwiftUI

struct ExpandableButtonItem: Identifiable {
  let id = UUID()
  let label: String
  private(set) var action: (() -> Void)? = nil
}

struct ExpandableButtonPanel: View {

  let primaryItem: ExpandableButtonItem
  let secondaryItems: [ExpandableButtonItem]

  private let noop: () -> Void = {}
  private let size: CGFloat = 48
  private var cornerRadius: CGFloat {
    get { size / 2 }
  }
  private let shadowColor = Color.black.opacity(0.4)
  private let shadowPosition: (x: CGFloat, y: CGFloat) = (x: 2, y: 2)
  private let shadowRadius: CGFloat = 3

  @State private var isExpanded = false

  var body: some View {
    VStack {
      ForEach(secondaryItems) { item in
        Button(action: item.action ?? self.noop, label: {
            Image(systemName: item.label).foregroundColor(.black).font(Font.title2)
        }).disabled(self.isExpanded ? false : true)
          .frame(
            width: self.isExpanded ? self.size : 0,
            height: self.isExpanded ? self.size : 0)
      }
        
        Button(action: {
                withAnimation(.easeIn(duration: 0.15)) {
                    self.isExpanded.toggle()
                }
                self.primaryItem.action?()}, label: {
                    Image(systemName: primaryItem.label).foregroundColor(.black).font(Font.title2.weight(.bold))
        })
        .frame(width: size, height: size)
    }
    .background(Color.white)
    .cornerRadius(cornerRadius)
    .font(.title)
    .shadow(
      color: shadowColor,
      radius: shadowRadius,
      x: shadowPosition.x,
      y: shadowPosition.y
    )
  }
}
