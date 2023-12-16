//
//  BuildingView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-24.
//

import SwiftUI

struct BuildingView: View {
    var building: Building
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    @State private var isFavorite: Bool = false
    @State private var showMoreDescription = false
    @State private var showMoreAmenities = false
    
    private var shareContent: String {
        var content = "\(building.name)\n\(building.address)"
        content += "\n\(building.description)"
        if let website = building.website {
            content += "\nMore info: \(website)"
        }
        return content
    }
    
    var formattedOpenHours: String {
        func formatTime(_ time: String) -> String {
            guard !time.isEmpty, let date = DateFormatter.iso8601Full.date(from: time) else { return "Closed" }
            return DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
        }
        
        let saturday = "Saturday: \(formatTime(building.saturdayStart)) to \(formatTime(building.saturdayClose))"
        let sunday = "Sunday: \(formatTime(building.sundayStart)) to \(formatTime(building.sundayClose))"
        return "\(building.isOpenSaturday ? saturday : "Saturday: Closed")\n\(building.isOpenSunday ? sunday : "Sunday: Closed")"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(building.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                HStack {
                    FavoriteButton(building: building, favoritesManager: favoritesManager)
                    ShareButton(building: building)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Text(building.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack {
                    Image(Utilities.getIconName(for: building.category, from: Utilities.categoryIcons))
                        .resizable()
                        .frame(width: 24, height: 26)
                    Text(building.category)
                        .bold()
                }
                .padding(.bottom, 1)
                
                Divider()
                
                Text("Open Hours")
                    .foregroundColor(.blue)
                Text(formattedOpenHours)
                
                Divider()
                
                Text("Description")
                    .foregroundColor(.blue)
                Text(building.description)
                    .lineLimit(showMoreDescription ? nil : 3)
                Button(showMoreDescription ? "Less" : "More") {
                    showMoreDescription.toggle()
                }
                
                Divider()
                
                if let website = building.website, let url = URL(string: website) {
                    Text("Website")
                        .foregroundColor(.blue)
                    Link(website, destination: url)
                } else {
                    Text("Website")
                        .foregroundColor(.blue)
                    Text("No website")
                }

                
                Divider()
                

                Text("Amenities")
                    .foregroundColor(.blue)

                if showMoreAmenities {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(visibleAmenities, id: \.self) { amenity in
                            amenityView(name: amenity.name, imageName: amenity.imageName)
                        }
                    }
                    Button("Less") {
                        showMoreAmenities.toggle()
                    }
                } else {
                    HStack {
                        ForEach(amenities.prefix(6), id: \.self) { amenity in
                            if amenity.isVisible {
                                Image(amenity.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 20)
                            }
                        }
                        Button("More") {
                            showMoreAmenities.toggle()
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(building.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    
    private func amenityView(name: String, imageName: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.trailing, 20)
            Text(name)
        }
    }

    private var visibleAmenities: [Amenity] {
        amenities.filter { $0.isVisible }
    }



    private var amenities: [Amenity] {
        [Amenity(name: "Wheelchair Accessible", imageName: "accessibility", isVisible: building.isAccessible),
         Amenity(name: "Shuttle Service", imageName: "shuttle", isVisible: building.isShuttle),
         Amenity(name: "Public Washrooms", imageName: "washroom", isVisible: building.isPublicWashrooms),
         Amenity(name: "Free Parking", imageName: "freeParking", isVisible: building.isFreeParking),
         Amenity(name: "Bike Parking", imageName: "bikeracks", isVisible: building.isBikeParking),
         Amenity(name: "Paid Parking", imageName: "paidParking", isVisible: building.isPaidParking),
         Amenity(name: "Guided Tours", imageName: "guidedTour", isVisible: building.isGuidedTour),
         Amenity(name: "Family Friendly", imageName: "familyFriendly", isVisible: building.isFamilyFriendly),
         Amenity(name: "OC Transpo Nearby", imageName: "ocTranspo", isVisible: building.isOCTranspoNearby)
        ]
    }
    }
