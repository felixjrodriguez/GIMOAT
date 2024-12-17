//
//  ClientsView.swift
//  GIMOAT
//
//  Created by Felix on 3/9/23.
//

import SwiftUI
import CoreData

// DEFINITION OF THE CLIENTS VIEW STRUCT
struct ClientsView: View {
    
    // CORE DATA ENVIRONMENT VARIABLE
    @Environment(\.managedObjectContext) private var viewContext
    
    // FETCH REQUEST TO RETRIEVE CORE DATA ITEMS
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Client.name, ascending: true)],
        animation: .default)
    private var clients: FetchedResults<Client>
    
    // MAIN USER INTERFACE
    var body: some View {
        
        // NAVIGATION VIEW CONTAINER
        NavigationView {
            
            // GROUPED LIST OF CORE DATA ITEMS
            List {
                
                // ITERATE THROUGH ALPHABETIC SECTIONS
                ForEach(alphabeticSections(clients: clients), id: \.self) { sectionLetter in
                    
                    // SECTION HEADER WITH LETTER
                    Section(header: Text(sectionLetter)) {
                        
                        // FILTER CLIENTS BY FIRST LETTER AND DISPLAY
                        ForEach(clients.filter { $0.name?.prefix(1).uppercased() == sectionLetter }) { client in
                            NavigationLink(destination: ClientDetailsView(client: client)) {
                                                        Text(client.name ?? "Unknown")
                                                    }
                

                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }

    // FUNCTION TO GET AN ARRAY OF UNIQUE FIRST LETTERS
    private func alphabeticSections(clients: FetchedResults<Client>) -> [String] {
        var uniqueLetters: Set<String> = []
        
        // ITERATE THROUGH CLIENTS TO GET UNIQUE FIRST LETTERS
        for client in clients {
            if let firstLetter = client.name?.prefix(1).uppercased() {
                uniqueLetters.insert(firstLetter)
            }
        }
        
        // RETURN SORTED ARRAY OF UNIQUE LETTERS
        return uniqueLetters.sorted()
    }
}

// PREVIEW PROVIDER STRUCT
struct ClientsView_Previews: PreviewProvider {
    static var previews: some View {
        ClientsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
