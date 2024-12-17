//
//  DashboardView.swift
//  GIMOAT
//
//  Created by Felix on 3/9/23.
//

import SwiftUI
import CoreData


// DEFINITION OF THE DASHBOARD VIEW STRUCT
struct DashboardView: View {
    
    // CORE DATA ENVIRONMENT VARIABLE
    @Environment(\.managedObjectContext) private var viewContext
    
    // FETCH REQUEST TO RETRIEVE CORE DATA INVOICES
         @FetchRequest(
             sortDescriptors: [NSSortDescriptor(keyPath: \Invoice.issueDate, ascending: true)],
             animation: .default)
     
         private var invoices: FetchedResults<Invoice>
    
    // FETCH REQUEST TO RETRIEVE CORE DATA ESTIMATES
         @FetchRequest(
             sortDescriptors: [NSSortDescriptor(keyPath: \Estimate.issueDate, ascending: true)],
             animation: .default)
     
         private var estimates: FetchedResults<Estimate>
    
    // MAIN USER INTERFACE
    var body: some View {
        
        // NAVIGATION VIEW CONTAINER
                NavigationView {
                    
                    // SECTION OF LAST 5 CORE DATA INVOICES
                    List {
                           Section(header: Text("Recent Invoices")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .bold())
                        {
                               ForEach(invoices.prefix(5)) { invoice in
                                   NavigationLink(destination: InvoiceDetailsView(invoice: invoice)) {
                                       Text(invoice.issueDate!, formatter: itemFormatter)
                                   }
                               }
                               .onDelete(perform: deleteInvoice)
                           }
                           
                        // SECTION OF LAST 5 CORE DATA ESTIMATES
                           Section(header: Text("Recent Estimates")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .bold()){
                               ForEach(estimates.prefix(5)) { estimate in
                                   NavigationLink(
                                                               destination: EstimateDetailsView(estimate: estimate),
                                                               label: {
                                                                   Text(estimate.issueDate!, formatter: itemFormatter)
                                                               })
                                                       }
                               .onDelete(perform: deleteEstimate)
                           }
                       }
                    // TOOLBAR WITH EDIT BUTTON AND ADD ITEM BUTTON
//                    .toolbar {
//                        #if os(iOS)
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            EditButton()
//                        }
//                        #endif
//                        ToolbarItem {
//                            Button(action: addInvoice) {
//                                Label("Add Item", systemImage: "plus")
//                            }
//                        }
//                    }
                    
                }
            }
    // FUNCTION TO ADD A NEW ITEM TO CORE DATA
    private func addInvoice() {
        withAnimation {
            let newInvoice = Invoice(context: viewContext)
            newInvoice.issueDate = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    // FUNCTION TO DELETE ITEMS FROM CORE DATA
    private func deleteInvoice(offsets: IndexSet) {
        withAnimation {
            offsets.map { invoices[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // FUNCTION TO ADD A NEW ITEM TO CORE DATA
    private func addEstimate() {
        withAnimation {
            let newEstimate = Estimate(context: viewContext)
            newEstimate.issueDate = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    // FUNCTION TO DELETE ITEMS FROM CORE DATA
    private func deleteEstimate(offsets: IndexSet) {
        withAnimation {
            offsets.map { estimates[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



// DATE FORMATTER FOR CORE DATA ITEMS
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// PREVIEW PROVIDER STRUCT
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        
        DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



