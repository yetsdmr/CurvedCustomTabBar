//
//  Home.swift
//  CurvedCustomTabBar
//
//  Created by Yunus Emre Taşdemir on 26.06.2023.
//

import SwiftUI

struct Home: View {
    // View Properties
    @State private var activeTab: Tab = .home
    // For Smooth Shape Sliding Effect, We're going to use Matched Geometry Effect
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                Text("Home")
                    .tag(Tab.home)
                    // Hiding Native Tab Bar
                    .toolbar (.hidden, for: .tabBar)
                
                Text("Services")
                    .tag(Tab.services)
                    // Hiding Native Tab Bar
                    .toolbar (.hidden, for: .tabBar)
                
                Text("Partners")
                    .tag(Tab.partners)
                    // Hiding Native Tab Bar
                    .toolbar (.hidden, for: .tabBar)
                
                Text("Activity")
                    .tag(Tab.activity)
                    // Hiding Native Tab Bar
                    .toolbar (.hidden, for: .tabBar)
            }
            
            CustomTabBar()
        }
        
        
    }
    
    // Custom Tab Bar
    // With More Easy Customization
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color ("Blue"), _ inactiveTint: Color = .blue) -> some View {
        // Moving all the Remaining Tab Item's to Bottom
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                // Adding Blur + Shadow
                // For Shape Smoothening
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        // Addina Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

// Tab Bar Item
struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                // Increasing Size for the Active Tab
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor (activeTab == tab ? tint : .gray)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            activeTab = tab
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
