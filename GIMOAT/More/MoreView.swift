//
//  MoreView.swift
//  GIMOAT
//
//  Created by Felix on 12/13/24.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    // Asumiendo que SettingsView ya existe en otro archivo
                    NavigationLink(destination: SettingsView()) {
                        Label("Settings", systemImage: "gear")
                    }

                    // ItemsView ahora está en su propio archivo (ItemsView.swift)
                    NavigationLink(destination: ItemsView()) {
                        Label("Items", systemImage: "bag")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("More")
        }
    }
}
