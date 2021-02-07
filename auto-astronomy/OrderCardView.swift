//
//  OrderCardView.swift
//  auto-astronomy
//
//  Created by Arpan Dhatt on 2/7/21.
//

import SwiftUI
import MapKit

struct JobCardView: View {
    
    struct Marker: Identifiable {
        let id = UUID()
        var location: MapMarker
    }
    
    var object: String
    var image: UIImage
    var updates: [String]
    var timeRemaining: Int
    var status: String
    var location: String
    var weather: String
    
    @Namespace private var animation
    @State private var expanded = false
    
    @State var markers: [Marker] = [Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389), tint: .red))]
    
    @State private var coordinateRegion = MKCoordinateRegion(
          center: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389),
          span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        VStack {
            if !expanded {
                HStack(alignment: .top) {
                    Image(uiImage: image).resizable().matchedGeometryEffect(id: "image", in: animation).frame(width:100, height:100).aspectRatio(contentMode: .fit).cornerRadius(10.0).shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                    Spacer()
                    VStack(alignment: .center) {
                        Text(object).matchedGeometryEffect(id: "name", in: animation).font(.system(size: 28, weight: .bold)).foregroundColor(Color.white)
                        Text(updates.last!).matchedGeometryEffect(id: "lastupdate", in: animation).font(.headline).foregroundColor(Color.white)
                    }
                    Spacer()
                }
                HStack {
                    Image(systemName: "timer").font(.system(size: 20, weight: .bold)).matchedGeometryEffect(id: "timeicon", in: animation).foregroundColor(Color.white)
                    Text("\(timeRemaining/3600):\(timeRemaining/60 % 60):\(timeRemaining % 60)").matchedGeometryEffect(id: "time", in: animation)
                    Spacer()
                    Text(status).matchedGeometryEffect(id: "status", in: animation)
                    Image(systemName: "play.fill").font(.system(size: 20, weight: .bold)).matchedGeometryEffect(id: "statusicon", in: animation).foregroundColor(Color.green)
                }

            } else {
                VStack(alignment: .center) {
                    Text(object).font(.system(size: 28, weight: .bold)).matchedGeometryEffect(id: "name", in: animation).foregroundColor(Color.white)
                    Text(updates.last!).matchedGeometryEffect(id: "lastupdate", in: animation).font(.headline).foregroundColor(Color.white)
                }
                HStack {
                    Image(systemName: "timer").font(.system(size: 20, weight: .bold)).matchedGeometryEffect(id: "timeicon", in: animation).foregroundColor(Color.white)
                    Text("\(timeRemaining/3600):\(timeRemaining/60 % 60):\(timeRemaining % 60)").matchedGeometryEffect(id: "time", in: animation)
                    Spacer()
                    Text(status).matchedGeometryEffect(id: "status", in: animation)
                    Image(systemName: "play.fill").font(.system(size: 20, weight: .bold)).matchedGeometryEffect(id: "statusicon", in: animation).foregroundColor(Color.green)
                }
                HStack(alignment: .top) {
                    Image(uiImage: image).resizable().matchedGeometryEffect(id: "image", in: animation).frame(width:UIScreen.main.bounds.width-60, height:UIScreen.main.bounds.width-80).aspectRatio(contentMode: .fit).cornerRadius(10.0).shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                }
                HStack {
                    Image(systemName: "location.fill").font(.system(size: 20, weight: .bold)).foregroundColor(Color.orange)
                    Text("\(location)")
                    Spacer()
                    Text("Weather: \(weather)")
                    Image(systemName: "moon.stars.fill").font(.system(size: 20, weight: .bold)).foregroundColor(Color.white)
                }
                Map(coordinateRegion: $coordinateRegion, annotationItems: markers){
                    marker in marker.location
                }.frame(minHeight: 150, maxHeight: 150).cornerRadius(10).shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
            }
        }.onTapGesture {
            withAnimation(.spring()) {
                expanded.toggle()
            }
        }.padding(20).frame(width: UIScreen.main.bounds.width-30).background(LinearGradient(gradient: Gradient(colors: [.init(.sRGB, red: 0.1, green: 0.1, blue: 0.4, opacity: 1.0),.init(.sRGB, red: 0.3, green: 0.0, blue: 0.4, opacity: 1.0)]), startPoint: .top, endPoint: .bottom)).foregroundColor(Color.white).cornerRadius(10.0).onAppear {
            getCoordinate(addressString: location, completionHandler: {coordinateRegion.center = $0; print($1 ?? "none"); markers.append(Marker(location: MapMarker(coordinate: $0)))})
        }
    }
    
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}

struct JobCardView_Previews: PreviewProvider {
    static var previews: some View {
        JobCardView(object: "M31", image: UIImage(named: "galaxies/1")!, updates: ["Cooling Telescope", "Aligning Telescope", "Calibrating Focus", "Beginning Exposure"], timeRemaining: 1600, status: "Running", location: "Southlake, TX", weather: "Clear")
    }
}
