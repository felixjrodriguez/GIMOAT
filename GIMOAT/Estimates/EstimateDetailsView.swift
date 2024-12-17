//
//  EstimateDetailsView.swift
//  GIMOAT
//
//  Created by Felix on 3/18/23.
//

import SwiftUI

struct EstimateDetailsView: View {
    let estimate: Estimate
    
    private let estimateDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .medium
            return formatter
        }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Fecha de emisión: \(estimate.issueDate!, formatter: estimateDateFormatter)")
                .font(.headline)
                .padding()
            
            // Aquí puedes agregar más información sobre el estimate
        }
        .navigationTitle("Detalles del Estimate")
    }
}


private func createSampleEstimate() -> Estimate {
    let sampleEstimate = Estimate(context: PersistenceController.preview.container.viewContext)
    sampleEstimate.issueDate = Date()
    // Añade más atributos aquí si es necesario
    return sampleEstimate
}

struct EstimateDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEstimate = createSampleEstimate()
        EstimateDetailsView(estimate: sampleEstimate)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

