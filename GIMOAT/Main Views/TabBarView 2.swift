import SwiftUI
import CoreData

struct TabBarView: View {
    @Binding var selectedTab: ContentView.Tab
    @Binding var showingDetails: Bool
    @EnvironmentObject var detailsViewModel: DetailsViewModel
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(showingDetails: $showingDetails)
                .tabItem {
                    Label(ContentView.Tab.dashboard.title, systemImage: ContentView.Tab.dashboard.imageName)
                }
                .tag(ContentView.Tab.dashboard)

            EstimatesView(showingDetails: $showingDetails)
                .tabItem {
                    Label(ContentView.Tab.estimates.title, systemImage: ContentView.Tab.estimates.imageName)
                }
                .tag(ContentView.Tab.estimates)

            InvoicesView(showingDetails: $showingDetails)
                .tabItem {
                    Label(ContentView.Tab.invoices.title, systemImage: ContentView.Tab.invoices.imageName)
                }
                .tag(ContentView.Tab.invoices)

            ClientsView(showingDetails: $showingDetails)
                .tabItem {
                    Label(ContentView.Tab.clients.title, systemImage: ContentView.Tab.clients.imageName)
                }
                .tag(ContentView.Tab.clients)

            SettingsContainerView(selectedTab: $selectedTab)
                .environmentObject(detailsViewModel)
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label(ContentView.Tab.settings.title, systemImage: ContentView.Tab.settings.imageName)
                }
                .tag(ContentView.Tab.settings)
        }
        .onChange(of: selectedTab) { _ in
            if !detailsViewModel.isViewingDetails {
                detailsViewModel.reset()
            }
        }
    }
}