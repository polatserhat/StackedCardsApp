//
//  ContentView.swift
//  StackedCardsApp
//
//  Created by Serhat  on 20.05.24.
//

import SwiftUI

struct ContentView: View {
    ///View Properties
    @State private var isRotationEnabled:Bool = true
    @State private var showsIndicator:Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal){
                        HStack(spacing: 0) {
                            ForEach(items) { item in
                                CardView(item)
                                    .padding(.horizontal, 65)
                                    .frame(width: size.width)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                            .rotationEffect(rotation(geometryProxy, rotation: isRotationEnabled ? 5 : 0))
                                            .offset(x: minX(geometryProxy))
                                            .offset(x: excessMinX(geometryProxy, offset:isRotationEnabled ? 8: 10))
                                            
                                    }
                                    .zIndex(items.zIndex(item))
                                
                                
                            }
                            
                        }
                        .padding(.vertical, 15)
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(showsIndicator ? .visible : .hidden)
                    .scrollIndicatorsFlash(trigger: showsIndicator)
                }
                .frame(height: 410)
                .animation(.snappy, value: isRotationEnabled)
                
                VStack(spacing:10) {
                    Toggle("Rotation Enabled", isOn: $isRotationEnabled)
                    Toggle("Shows Scroll Indicator", isOn: $showsIndicator)
                }
                .padding(15)
                .background(.bar, in: .rect(cornerRadius:10))
                .padding(15)
                
            }
            .navigationTitle("Stacked Cards")
        }
    }
    /// Card View
    @ViewBuilder
    func CardView(_ item: Item) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(item.color.gradient)
        
    }
    /// Stacked Cards Animation
    
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
    
    func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        /// Converting into Progress
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress,limit)
        return cappedProgress
    }
    
    func scale(_ proxy:GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)
        
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        
        return progress * offset
    }
    
    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        
        return .init(degrees: progress * rotation)
    }

}

#Preview {
    ContentView()
}
