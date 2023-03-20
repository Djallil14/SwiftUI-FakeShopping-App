//
//  LoggedInView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import SwiftUI
import MapKit

struct LoggedInView: View {
    @EnvironmentObject var users: UserViewModel
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    let user: User
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    HeaderLoggedInView(user: user)
                        .padding(.top)
                    ProfilButtons().environmentObject(users)
                    //Spacer()
                    MapView(region: $region, user: user)
                        .shadow(color: .darkText.opacity(0.2), radius: 4, x: 1, y: 2)
                    //Spacer()
                }
                .navigationBarBackButtonHidden(false)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear{
                    print("Lattitude : \(user.location.coordinates.latitude)")
                    print("Longitude : \(user.location.coordinates.longitude)")
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:Double( user.location.coordinates.latitude) ?? 0, longitude: Double( user.location.coordinates.longitude) ?? 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                }
            }.navigationBarHidden(true)
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(user: UserAPIResults.sampleUsers.results[0])
            .environmentObject(UserViewModel())
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
                    AsyncImage(url: URL(string:user.picture.large)!, scale: 3.0)
                      .scaledToFit()
                //}
            }
            .padding()
            VStack(alignment: .leading) {
                Text("\(user.name.first) \(user.name.last)")
                    .font(.title2)
                    .bold()
                Text("\(user.email)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(user.location.city)")
            }
            Spacer()
        }.padding()
        .onAppear{
            //imageLoader.loadImage(with: URL(string:user.picture.large)!)
        }
    }
}

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    let user: User
    @State var annotation: [UserLocation] = [UserLocation(name: "Default", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)), UserLocation(name: "Apple", coordinate: CLLocationCoordinate2D(latitude: 37.334722, longitude: -122.008889))]
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotation){
            MapAnnotation(coordinate: $0.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)){
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.red)
                    .imageScale(.large)
            }
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


