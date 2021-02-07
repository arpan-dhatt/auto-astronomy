//
//  GallaryView.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI

struct GallaryView: View {
    @ObservedObject var model: ViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GallaryView_Previews: PreviewProvider {
    static var previews: some View {
        GallaryView(model: ViewModel())
    }
}
