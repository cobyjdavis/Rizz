//
//  OffsetPageTabView.swift
//  Rizz
//
//  Created by CJ Davis on 12/3/21.
//

import SwiftUI

// Custom View that will return offset for Paging Control....
struct OffsetPageTabView<Content: View>: UIViewRepresentable {
    
    var content: Content
    @Binding var offset: CGFloat
    @Binding var selection: Int
    
    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator(parent: self)
    }
    
    init(selection: Binding<Int>, offset: Binding<CGFloat>,@ViewBuilder content: @escaping ()->Content){
        
        self.content = content()
        self._offset = offset
        self._selection = selection
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        let scrollview = UIScrollView()
        
        // Extracting SwiftUI View and embedding into UIKit ScrollView...
        let hostview = UIHostingController(rootView: content)
        hostview.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
        
            hostview.view.topAnchor.constraint(equalTo: scrollview.topAnchor),
            hostview.view.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            hostview.view.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            hostview.view.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            
            // if you are using vertical Paging...
            // then dont declare height constraint...
            hostview.view.heightAnchor.constraint(equalTo: scrollview.heightAnchor)
        ]
        
        scrollview.addSubview(hostview.view)
        scrollview.addConstraints(constraints)
        
        // ENabling Paging...
        scrollview.isPagingEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        
        // setting Delegate...
        scrollview.delegate = context.coordinator
        
        return scrollview
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        // need to update only when offset changed manually...
        // just check the current and scrollview offsets...
        let currentOffset = uiView.contentOffset.x
        
        if currentOffset != offset{
        
            print("updating")
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    
    // Pager Offset...
    class Coordinator: NSObject,UIScrollViewDelegate{
        
        var parent: OffsetPageTabView
        
        init(parent: OffsetPageTabView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
//            print("offset: \(offset)")
//            let maxSize = scrollView.contentSize.width
//            print("maxSize: \(maxSize)")
//            let currentSelection = (offset / maxSize).rounded()
//            print("selection: \((offset / maxSize).rounded())")

//            parent.selection = Int(currentSelection)
            parent.offset = offset
        }
    }
}

struct PagerTabView<Content: View, Label: View>: View {
    
    var content: Content
    var label: Label
    var tint: Color
    @Binding var selection: Int
    
    init(tint: Color, selection: Binding<Int>, @ViewBuilder labels: @escaping ()-> Label, @ViewBuilder content: @escaping ()-> Content) {
        self.content = content()
        self.label = labels()
        self.tint = tint
        self._selection = selection
    }
    
    @State var offset: CGFloat = 0
    @State var maxTabs: CGFloat = 0
    @State var tabOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                label
            }
            .overlay(
                HStack(spacing: 0) {
                    ForEach(0..<Int(maxTabs), id: \.self) { index in
                        Rectangle()
                            .fill(Color.black.opacity(0.01))
                            .onTapGesture {
                                let newoffset = CGFloat(index) * getScreeenBounds().width
                                self.offset = newoffset
                            }
                    }
                }
            )
            .foregroundColor(selection == 0 ? .black : .gray)
            
            
            Capsule()
                .fill(tint)
                .frame(width: maxTabs == 0 ? 0 : (getScreeenBounds().width / maxTabs), height: 5)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: tabOffset)
            
            OffsetPageTabView(selection: $selection, offset: $offset) {
                HStack(spacing: 0) {
                    content
                }
                .overlay(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: TabPreferenceKey.self, value: proxy.frame(in: .global))
                    }
                )
                .onPreferenceChange(TabPreferenceKey.self) {proxy in
                    let minX = -proxy.minX
                    let maxWidth = proxy.width
                    let screenWidth = getScreeenBounds().width
                    let maxTabs = (maxWidth / screenWidth).rounded()
                    
                    let progress = minX / screenWidth
                    let tabOffset = progress * (screenWidth / maxTabs)
                    
                    self.selection = abs(Int(progress.rounded()))
                    self.tabOffset = tabOffset
                    self.maxTabs = maxTabs
                }
            }
        }
    }
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .init()
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    func pageLabel() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func pageView(ignoresSafeArea: Bool = false, edges: Edge.Set = []) -> some View {
        self
            .frame(width: getScreeenBounds().width, alignment: .center)
            .ignoresSafeArea(ignoresSafeArea ? .container : .init(), edges: edges)
    }
    
    func getScreeenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct OffsetPageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
