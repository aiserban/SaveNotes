//
//  ContentView.swift
//  SaveNotes
//
//  Created by Andrei Serban on 18.02.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.timestamp, ascending: true)],
        animation: .default)
    private var notes: FetchedResults<Note>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    Text("Item at \(note.timestamp!, formatter: itemFormatter)")
                }.onDelete(perform: deleteNotes)
            }
            .toolbar {
                //                #if os(iOS)
                ToolbarItem(placement: .primaryAction, content: ({
                    NavigationLink("Add", destination: CreateNote())
                }))
                ToolbarItem(placement: .bottomBar, content: ({
                    EditButton()
                }))
                
            }.navigationBarTitle("Notes")
//            .navigationBarBackButtonHidden(true)
            //                #endif
            
        }
        
        
    }
    

    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)
            
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
