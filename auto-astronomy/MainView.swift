//
//  MainView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var model: ViewModel = ViewModel()
    
    var body: some View {
        VStack{
            if model.page == "home"{
                HomeView(model: self.model)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
