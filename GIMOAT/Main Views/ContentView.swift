//
//  ContentView.swift
//  GIMOAT
//
//  Created by Felix on 3/9/23.
//

import SwiftUI
import CoreData

// DEFINITION OF THE MAIN STRUCT THAT CONTAINS THE USER INTERFACE AND FUNCTIONS THAT CONTROL ITS BEHAVIOR
struct ContentView: View {
    
    // CORE DATA ENVIRONMENT VARIABLE
        @Environment(\.managedObjectContext) private var viewContext
    
   
    // DEFINITION OF AN ENUMERATION THAT REPRESENTS EACH OF THE APPLICATION TABS
    enum Tab {
        case dashboard
        case invoices
        case estimates
        case clients
        case settings
        
    // FUNCTION TO GET THE TITLE OF THE TAB
        var title: String {
            
            switch self {
            case .dashboard:
                return "Dashboard"
            case .invoices:
                return "Invoices"
            case .estimates:
                return "Estimates"
            case .clients:
                return "Clients"
            case .settings:
                return "Settings"
            }
        }
    // FUNCTION TO GET THE IMAGE NAME OF THE TAB
        var imageName: String {
            switch self {
            case .dashboard:
                return "chart.bar.fill"
            case .invoices:
                return "doc.text.fill"
            case .estimates:
                return "doc.on.doc.fill"
            case .clients:
                return "person.2.fill"
            case .settings:
                return "gearshape.fill"
            }
        }
    }
    
    // VARIABLE TO STORE THE CURRENTLY SELECTED TAB
    @State private var selectedTab: Tab = .dashboard

    // DEFINITION OF THE MAIN USER INTERFACE
    var body: some View {
        
        // MAIN CONTAINER
        VStack{
            
            // HEADER
            HStack {
                
                // TITLE OF THE SELECTED TAB
                Text(selectedTab.title)
                
                    .font(.system(size: 44, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 1)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .padding(.leading, 16)
                
              
              
                Spacer()
                
                // Instantiate the AddButton, passing the addInvoice, addEstimate actions and the selectedTab
                // The AddButton will display different options based on the selected tab
                
                AddButton(addInvoiceAction: addInvoice, addEstimateAction: addEstimate, addClientAction: addClient, selectedTab: selectedTab)

            }
                    
            


            
            
            // TAB CONTAINER
            TabView(selection: $selectedTab) {
                
        //DASHBOARD TAB
                
                DashboardView().tabItem {
                    
                    
                    Label(Tab.dashboard.title, systemImage: Tab.dashboard.imageName)
                }.tag(Tab.dashboard)
                
                
        //INVOICES TAB
                
                InvoicesView().tabItem {
                    Label(Tab.invoices.title, systemImage: Tab.invoices.imageName)
                }.tag(Tab.invoices)
                
        //ESTIMATES TAB
                
                EstimatesView().tabItem {
                    Label(Tab.estimates.title, systemImage: Tab.estimates.imageName)
                }.tag(Tab.estimates)
                
        //CLIENTS TAB
                
                ClientsView().tabItem {
                    Label(Tab.clients.title, systemImage: Tab.clients.imageName)
                }.tag(Tab.clients)
                
        //SETTINGS TAB
                
                SettingsView().tabItem {
                    Label(Tab.settings.title, systemImage: Tab.settings.imageName)
                }.tag(Tab.settings)
                    .navigationBarTitle(Text(selectedTab.title), displayMode: .large)
            }
        }.background(Color.blue)
        
        
    }
    // FUNCTION TO HANDLE ADD ACTIONS
    func addAction(for tab: ContentView.Tab) {
        withAnimation {
            switch tab {
            case .invoices:
                addInvoice()
            case .estimates:
                addEstimate()
            default:
                break
            }
        }
    }

        // FUNCTION TO ADD A NEW INVOICE TO CORE DATA
         func addInvoice() {
            let newInvoice = Invoice(context: viewContext)
            newInvoice.issueDate = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }

        // FUNCTION TO ADD A NEW ESTIMATE TO CORE DATA
         func addEstimate() {
            let newEstimate = Estimate(context: viewContext)
            newEstimate.issueDate = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    
    // FUNCTION TO ADD A NEW CLIENT TO CORE DATA
    func addClient() {
        let newClient = Client(context: viewContext)
        let names = ["Alice", "Bob", "Charlie", "David", "Eva", "Frank", "Grace", "Helen"]
        newClient.name = names.randomElement()

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

        
        // ENUM TO REPRESENT ITEM TYPES
         enum ItemType {
            case invoice
            case estimate
        }
}



// ADD BUTTON VIEW
struct AddButton: View {
    let addInvoiceAction: () -> Void
    let addEstimateAction: () -> Void
    let addClientAction: () -> Void

    let selectedTab: ContentView.Tab

    var body: some View {
        // Use a Group to conditionally display the appropriate options based on the selected tab
        Group {
            // If the selected tab is Dashboard, display a menu with options for adding invoices and estimates
            if selectedTab == .dashboard {
                Menu {
                    Button(action: addInvoiceAction) {
                        Label("Add Invoice", systemImage: "doc.text.fill")
                    }

                    Button(action: addEstimateAction) {
                        Label("Add Estimate", systemImage: "doc.on.doc.fill")
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                }
            // If the selected tab is Invoices, display a button that directly adds a new invoice
            } else if selectedTab == .invoices {
                Button(action: addInvoiceAction) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                }
            // If the selected tab is Estimates, display a button that directly adds a new estimate
            } else if selectedTab == .estimates {
                Button(action: addEstimateAction) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                }
                
                // If the selected tab is Clients, display a button that directly adds a new client
                } else if selectedTab == .clients {
                    Button(action: addClientAction) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                    }

            // If the selected tab is neither Dashboard, Invoices, nor Estimates, display an empty view
            } else {
                EmptyView()
            }
        }
    }
}

// PREVIEW PROVIDER STRUCT
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
