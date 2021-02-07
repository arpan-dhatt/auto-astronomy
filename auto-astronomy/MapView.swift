//
//  MapView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var model: ViewModel
    @State var showLoader = false
    @State var message = ""
    @State var webTitle = ""
    
    var body: some View {
        WebView(url: .localUrl, viewModel: model).overlay (RoundedRectangle(cornerRadius: 4, style: .circular).stroke(Color.gray, lineWidth: 0.5)).padding(.leading, 20).padding(.trailing, 20)    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(model: ViewModel())
    }
}