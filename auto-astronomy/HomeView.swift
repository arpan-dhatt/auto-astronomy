//
//  HomeView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var model: ViewModel
    @State var selection: String? = nil
    
    var body: some View {
        TabView(selection: $model.selectedHomeTab) {
            GallaryView(model: self.model).tabItem {
                Image(systemName: "plus").font(.system(size: 28, weight:.ultraLight))
                Text("Gallary")
            }.tag(Tab.gallary)
            GallaryView(model: self.model).tabItem {
                Image(systemName: "map.fill").font(.system(size: 28, weight:.ultraLight))
                Text("Map")
            }.tag(Tab.map)
            GallaryView(model: self.model).tabItem {
                Image(systemName: "list.bullet").font(.system(size: 28, weight:.ultraLight))
                Text("Orders")
            }.tag(Tab.orders)
        }
    }
}

extension HomeView{
    enum Tab: Hashable {
        case gallary
        case map
        case orders
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(model: ViewModel())
    }
}
