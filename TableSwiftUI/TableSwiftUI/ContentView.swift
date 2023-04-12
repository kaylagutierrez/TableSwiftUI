//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Gutierrez, Kayla M on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Bar 1919", neighborhood: "Blue Star Arts Complex", desc: "A trendy establishment with a speakeasy vibe, where nicely-dressed bartenders concoct award-winning cocktails.", lat: 29.409880, long: -98.495750, imageName: "1919"),
    Item(name: "Havana Bar", neighborhood: "Downtown", desc: "An intimate candle-lit bar featuring high end cocktails served in an old hotel basement.", lat: 29.430800, long: -98.489870, imageName: "havana"),
    Item(name: "The Modernist", neighborhood: "The Pearl", desc: "A speakeasy-style cocktail bar with 1960's Mid Century vibes & specialty drinks (and mocktails!)", lat: 29.443000, long: -98.474830, imageName: "modernist"),
    Item(name: "Bar Loretta", neighborhood: "King William District", desc: "A rustic bar & restaurant serving up modern American eats & creative cocktails. ", lat: 29.413990, long: -98.491240, imageName: "loretta"),
    Item(name: "The Moons Daughters", neighborhood: "The Riverwalk", desc: "A captivating rooftop lounge that overlooks downtown San Antonio. Offers custom drinks & bar bites with both indoor & outdoor seating.", lat: 29.431800, long: -98.489140, imageName: "moonsdaughters")
   
]

struct Item: Identifiable {
       let id = UUID()
       let name: String
       let neighborhood: String
       let desc: String
       let lat: Double
       let long: Double
       let imageName: String
   }


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.431000, longitude: -98.489140), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    var body: some View {
        
        
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                            .overlay(
                                Text(item.name)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .offset(y: 25)
                            )
                    }
                }
                .frame(height: 300)
                .padding(.bottom, -30)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Austin Restaurants")
        }
        
        
    }
}

struct DetailView: View {
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    let item: Item
            
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200)
            Text("Neighborhood: \(item.neighborhood)")
                .font(.subheadline)
            Text("Description: \(item.desc)")
                .font(.subheadline)
                .padding(10)
                }
                 .navigationTitle(item.name)
                 Spacer()
        Map(coordinateRegion: $region, annotationItems: [item]) { item in
               MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                   Image(systemName: "mappin.circle.fill")
                       .foregroundColor(.red)
                       .font(.title)
                       .overlay(
                           Text(item.name)
                               .font(.subheadline)
                               .foregroundColor(.black)
                               .fixedSize(horizontal: true, vertical: false)
                               .offset(y: 25)
                       )
               }
           }
               .frame(height: 300)
               .padding(.bottom, -30)
     }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
