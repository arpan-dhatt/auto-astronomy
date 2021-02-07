//
//  MapView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: ViewModel
    @State var showLoader = false
    @State var message = ""
    @State var webTitle = ""
    
    var body: some View {
        ZStack {
            WebView(url: .localUrl, viewModel: viewModel)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: ViewModel())
    }
}
