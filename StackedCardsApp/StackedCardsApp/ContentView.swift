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
                                            .offset(x: minX(geometryProxy))
                                    }
                                    
                                
                                
                            }
                            
                        }
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(showsIndicator ? .visible : .hidden)
                }
                .frame(height: 380)
                
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

}

#Preview {
    ContentView()
}
