//
//  LoggedInView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import SwiftUI
import MapKit

struct LoggedInView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    let user: User
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                HeaderLoggedInView(user: user)
                    .padding(.bottom)
                Divider()
                VStack {
                    Button(action: {}){
                        HStack {
                            Text("Change Informations")
                            Image(systemName: "slider.horizontal.3")
                        }
                    }.buttonStyle(ProfilButtonMenu())
                    Button(action: {}){
                        HStack {
                            Text("History")
                            Image(systemName: "bag.circle")
                        }
                    }.buttonStyle(ProfilButtonMenu())
                    Button(action: {}){
                        HStack {
                            Text("Orders")
                            Image(systemName: "bag")
                        }
                    }.buttonStyle(ProfilButtonMenu())
                    Button(action: {}){
                        HStack {
                            Text("Settings")
                            Image(systemName: "gear")
                        }
                    }.buttonStyle(ProfilButtonMenu())
                }.padding()
                Spacer()
                MapView(region: $region, user: user)
                Spacer()
            }.navigationBarHidden(true)
            .onAppear{
                print(user.location.coordinates.latitude)
                print(user.location.coordinates.longitude)
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:Double( user.location.coordinates.latitude) ?? 0, longitude: Double( user.location.coordinates.longitude) ?? 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        }
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(user: User.sampleProducts.results[0])
    }
}

struct HeaderLoggedInView: View {
    @StateObject var imageLoader = ImageLoader()
    let user: User
    var body: some View {
        HStack {
            ZStack{
                Circle().fill(Color.secondaryBackground)
                    .frame(width: 90, height: 90)
                if let image = imageLoader.image{
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(8)
                }
            }
            .padding()
            Text("\(user.name.first) \(user.name.last)")
                .font(.title2)
                .bold()
            Spacer()
        }.padding()
        .onAppear{
            imageLoader.loadImage(with: URL(string:user.picture.large)!)
        }
    }
}

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    let user: User
    @State var annotation: [UserLocation] = [UserLocation(name: "Default", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))]
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotation){
            MapPin(coordinate: $0.coordinate)
        }
            .frame(height: 200)
        .cornerRadius(12)
        .padding(.horizontal)
            .onAppear{
                annotation = [UserLocation(name: user.name.first, coordinate: CLLocationCoordinate2D(latitude: Double(user.location.coordinates.latitude) ?? 0, longitude: Double(user.location.coordinates.longitude) ?? 0))]
            }
    }
}

struct UserLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
