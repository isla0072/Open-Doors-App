//
//  SideMenuView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var selectedSortOption: SortOption
    @Binding var selectedBuildingFeatures: [String: Bool]
    @Binding var selectedBuildingCategories: [String: Bool]
    var onApply: () -> Void
    
    @State private var isSortByExpanded = false
    @State private var isFeaturesExpanded = false
    @State private var isCategoryExpanded = false
    
    private let allFeatures = ["Wheelchair Accessible", "Shuttle Service", "Public Washrooms", "Free Parking", "Bike Parking", "Paid Parking", "Guided Tours", "Family Friendly", "OC Transpo Nearby"]
    
    private let allCategories = ["Community and/or Care centres", "Religious buildings", "Business and/or Foundations", "Embassies", "Museums, Archives and Historic Sites", "Academic Institutions", "Government buildings", "Functional buildings", "Galleries and Theatres", "Sports and Leisure buildings", "Other"]
    
    private let outerPadding: CGFloat = 16
    private let innerPadding: CGFloat = 12
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: outerPadding) {
                Text("Filter Options")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.vertical, innerPadding)
                
                GroupBox {
                    DisclosureGroup("Sort by", isExpanded: $isSortByExpanded) {
                        Picker("Sort by", selection: $selectedSortOption) {
                            Text("Name").tag(SortOption.name)
                            Text("Distance").tag(SortOption.distance)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .groupBoxStyle(SideMenuGroupBoxStyle())

                GroupBox {
                    DisclosureGroup("Building Features", isExpanded: $isFeaturesExpanded) {
                        ForEach(allFeatures, id: \.self) { feature in
                            Toggle(isOn: Binding<Bool>(
                                get: { self.selectedBuildingFeatures[feature, default: false] },
                                set: { self.selectedBuildingFeatures[feature] = $0 }
                            )) {
                                HStack {
                                    Image(Utilities.getIconName(for: feature, from: Utilities.amenityIcons))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text(feature)
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                    }
                }
                .groupBoxStyle(SideMenuGroupBoxStyle())

                GroupBox {
                    DisclosureGroup("Building Category", isExpanded: $isCategoryExpanded) {
                        ForEach(allCategories, id: \.self) { category in
                            Toggle(isOn: Binding<Bool>(
                                get: { self.selectedBuildingCategories[category, default: false] },
                                set: { self.selectedBuildingCategories[category] = $0 }
                            )) {
                                HStack {
                                    Image(Utilities.getIconName(for: category, from: Utilities.categoryIcons))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text(category)
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                    }
                }
                .groupBoxStyle(SideMenuGroupBoxStyle())
                
                Spacer()
                
                Button(action: onApply) {
                               Text("Apply")
                                   .frame(maxWidth: .infinity)
                                   .padding()
                                   .background(Color.blue)
                                   .foregroundColor(.white)
                                   .cornerRadius(10)
                           }
                           .padding(.horizontal, outerPadding)
                           .padding(.bottom, outerPadding)
            }
            .padding(outerPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
            .padding(.horizontal, outerPadding)
        }
    }
}

struct SideMenuGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .foregroundColor(.primary)
                .padding(.bottom, 8)
            configuration.content
                .padding(.top, 8)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
        .overlay(configuration.label.padding(.leading, 20), alignment: .topLeading)
    }
}
