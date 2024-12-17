import SwiftUI
import CoreData

// DEFINITION OF THE ESTIMATES VIEW STRUCT
struct EstimatesView: View {
    
    // CORE DATA ENVIRONMENT VARIABLE
    @Environment(\.managedObjectContext) private var viewContext
    
    // FETCH REQUEST TO RETRIEVE CORE DATA ITEMS
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Estimate.issueDate, ascending: true)],
        animation: .default)
    private var estimates: FetchedResults<Estimate>
    
    // DATE FORMATTER FOR CORE DATA ITEMS
        private let estimateDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .medium
            return formatter
        }()
    
    // MAIN USER INTERFACE
    var body: some View {
        
        // NAVIGATION VIEW CONTAINER
        NavigationView {
                 
                 // GROUPED LIST OF CORE DATA ITEMS
                 List {
                     ForEach(months(estimates: estimates), id: \.self) { month in
                         Section(header: Text(monthTitle(from: month))) {
                             ForEach(estimates.filter { isSameMonth(date1: $0.issueDate!, date2: month) }) { estimate in
                                 NavigationLink(destination: EstimateDetailsView(estimate: estimate)) {
                                                                  Text(estimate.issueDate!, formatter: itemFormatter)
                                                              }
                             }
                             .onDelete(perform: deleteEstimate) // Add this line
                         }
                     }
                 }
                 .listStyle(InsetGroupedListStyle())
             }
         }

         // FUNCTION TO DELETE ITEMS FROM CORE DATA
         private func deleteEstimate(offsets: IndexSet) {
             withAnimation {
                 offsets.map { estimates[$0] }.forEach(viewContext.delete)

                 do {
                     try viewContext.save()
                 } catch {
                     let nsError = error as NSError
                     fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                 }
             }
         
    }

    // FUNCTION TO GET AN ARRAY OF UNIQUE MONTHS
    private func months(estimates: FetchedResults<Estimate>) -> [Date] {
        var uniqueMonths: Set<Date> = []
        let calendar = Calendar.current
        
        for estimate in estimates {
            if let month = calendar.dateInterval(of: .month, for: estimate.issueDate!)?.start {
                uniqueMonths.insert(month)
            }
        }
        
        return uniqueMonths.sorted()
    }

    // FUNCTION TO GET A MONTH TITLE FROM TIMESTAMP
    private func monthTitle(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    // FUNCTION TO CHECK IF TWO DATES ARE IN THE SAME MONTH
    private func isSameMonth(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, equalTo: date2, toGranularity: .month)
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
struct EstimatesView_Previews: PreviewProvider {
    static var previews: some View {
        EstimatesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
