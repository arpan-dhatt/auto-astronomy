//
//  ViewModel.swift
//  auto-astronomy
//
//  Created by user175571 on 2/6/21.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var model:InfoModel = InfoModel()
    
    //transition variables
    @Published var page = "homme"
    @Published var selectedHomeTab: HomeView.Tab = .orders
    
    //constants
    let PrimaryColor = Color.init(red: 66/255, green: 165/255, blue: 245/255)
    let SecondaryColor = Color.init(red: 126/255, green: 87/255, blue: 194/255)
    let TertiaryColor = Color.init(red: 77/255, green: 182/255, blue: 172/255)
    
    //WebView
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
        var showWebTitle = PassthroughSubject<String, Never>()
        var showLoader = PassthroughSubject<Bool, Never>()
        var valuePublisher = PassthroughSubject<String, Never>()
}

enum WebViewNavigation {
    case backward, forward, reload
}

// For identifying what type of url should load into WebView
enum WebUrlType {
    case localUrl, publicUrl
}
