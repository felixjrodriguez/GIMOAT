//
//  InvoiceDetailsView.swift
//  GIMOAT
//
//  Created by Felix on 3/18/23.
//

import SwiftUI

struct InvoiceDetailsView: View {
    let invoice: Invoice
    
    private let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .medium
            return formatter
        }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Fecha de emisión: \(invoice.issueDate!, formatter: itemFormatter)")
                .font(.headline)
                .padding()
            
            // Aquí puedes agregar más información sobre el invoice
        }
        .navigationTitle("Detalles del Invoice")
    }
}


private func createSampleInvoice() -> Invoice {
    let sampleInvoice = Invoice(context: PersistenceController.preview.container.viewContext)
    sampleInvoice.issueDate = Date()
    // Añade más atributos aquí si es necesario
    return sampleInvoice
}

struct InvoiceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleInvoice = createSampleInvoice()
        InvoiceDetailsView(invoice: sampleInvoice)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

