//
//  auto_astronomyApp.swift
//  auto-astronomy
//
//  Created by Arpan Dhatt on 2/6/21.
//

import SwiftUI

@main
struct auto_astronomyApp: App {
    var body: some Scene {
        WindowGroup {
            checkWebsite()
        }
    }
    
    func checkWebsite(completion: @escaping (Bool) -> Void ) {
        guard let url = URL(string: "http://47.37.119.216:8080") else { return }

        var request = URLRequest(url: url)
        request.timeoutInterval = 1.0

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(false)
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                completion(true)

            }
        }
        task.resume()
    }

}
