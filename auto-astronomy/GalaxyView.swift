//
//  GalaxyView.swift
//  auto-astronomy
//
//  Created by Arpan Dhatt on 2/7/21.
//

import SwiftUI

struct GalaxyView : View {
    
    @State var data = [
        Card(id: 0, image: "galaxies/1", name: "M31", title: "Andrometa Galaxy", details: "Also Known as Messier 31, is a barred spiral galaxy that is located around 2.5 million light years from Earth, and it happend to be the nearest galay to the Milky Way. It is named after the region of the sky in which it appears, the name of which is derived from the Ethiopian princess who was the wife of Perseus in Greek Mythology. Though uncertain, it is estimated to be about the size of our Milky way, or up to 50% larger, however, it is estimated to have twice the number of stars as the Milky Way.", expand: false),
        Card(id: 1, image: "galaxies/2", name: "M104", title: "Sombrero Galaxy", details: "The Sombrero Galaxy is a spiral galaxy located on the borders of Virgo and Corvus, around 31.5 million light years from our galaxy. It has a diameter about 30% the size of the Milky Way, and is know for its unusually large central bulge. Due to its unique characteristiscs, its also easily visisble with a telescope from earth and it also contains a supermassive black hole in the center.", expand: false),
        Card(id: 2, image: "galaxies/3", name: "M31", title: "Australia", details: "Australia, officially the Commonwealth of Australia, is a sovereign country comprising the mainland of the Australian continent, the island of Tasmania, and numerous smaller islands. It is the largest country in Oceania and the world's sixth-largest country by total area.", expand: false),
        Card(id: 3, image: "galaxies/4", name: "M51a", title: "Whirlpool Galaxy", details: "The Whirlpool galaxy is an interaccting grand-design spiral galaxy at the center of the Canes Venatici Constellation. It was the first galaxy to be classified as a spiral galaxy and is estimated to be 31 million light-years from earth. This galaxy is also know for its ease fof being viewed by telescopes and even binoculars, and is heavily studied in academia due to its unique spiral arms.", expand: false),
        Card(id: 4, image: "galaxies/5", name: "M31", title: "Dubai", details: "Dubai is a city and emirate in the United Arab Emirates known for luxury shopping, ultramodern architecture and a lively nightlife scene. Burj Khalifa, an 830m-tall tower, dominates the skyscraper-filled skyline. At its foot lies Dubai Fountain, with jets and lights choreographed to music. On artificial islands just offshore is Atlantis, The Palm, a resort with water and marine-animal parks.", expand: false),
        Card(id: 5, image: "galaxies/6", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 6, image: "galaxies/7", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 7, image: "galaxies/8", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 8, image: "galaxies/9", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 9, image: "galaxies/10", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false),
        Card(id: 10, image: "galaxies/11", name: "M31", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false)
    ]
    
    @State var hero = false
    @Binding var heroBinding: Bool
    
    var body: some View{
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    ForEach(0..<self.data.count){i in
                        GeometryReader{g in
                            CardView(data: self.$data[i], hero: self.$hero, heroBinding: self.$heroBinding)
                                .offset(y: self.data[i].expand ? -g.frame(in: .global).minY : 0)
                                .opacity(self.hero ? (self.data[i].expand ? 1 : 0) : 1)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){if !self.data[i].expand{
                                            self.hero.toggle()
                                            self.heroBinding.toggle()
                                            self.data[i].expand.toggle()
                                        }
                                    }
                                }
                            }
                        .frame(height: self.data[i].expand ? UIScreen.main.bounds.height : 250)
                        .simultaneousGesture(DragGesture(minimumDistance: self.data[i].expand ? 0 : 500).onChanged({ (_) in
                            print("dragging")
                        }))
                    }
                }.padding(.bottom)
            }
        }
    }
}


struct GalaxyView_Previews: PreviewProvider {
    static var previews: some View {
        GalaxyView(heroBinding: .constant(false))
    }
}
