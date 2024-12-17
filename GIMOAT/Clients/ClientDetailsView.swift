//
//  ClientDetailsView.swift
//  GIMOAT
//
//  Created by Felix on 3/18/23.
//

import SwiftUI

struct ClientDetailsView: View {
    let client: Client
      
      var body: some View {
          VStack(alignment: .leading) {
              Text(client.name ?? "Unknown")
                  .font(.largeTitle)
                  .padding()
              
              // Aquí puedes agregar más información sobre el cliente
          }
          .navigationTitle("Detalles del Cliente")
      }
}
private func createSampleClient() -> Client {
    let sampleClient = Client(context: PersistenceController.preview.container.viewContext)
    sampleClient.name = "Cliente de Muestra"
    // Añade más atributos aquí si es necesario
    return sampleClient
}

struct ClientDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleClient = createSampleClient()
        ClientDetailsView(client: sampleClient)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

