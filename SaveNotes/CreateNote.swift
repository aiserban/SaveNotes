//
//  CreateNote.swift
//  SaveNotes
//
//  Created by Andrei Serban on 22.02.2021.
//

import SwiftUI

struct CreateNote: View {
    @State var title: String = "title"
    @State var text: String = "note text"
    //    @State var bookmarked: Bool = false
    //    @State var timestamp: Date = Date.init()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Title", text: $title)
                }
                Section {
                    TextEditor(text: $text)
                }
            }.navigationBarTitle("Add note").listStyle(GroupedListStyle())
        }.navigationBarItems(trailing: Button("Save", action: saveNote).disabled(self.title.isEmpty))
    }
    
    
    func saveNote() {
        let newNote = Note(context: viewContext)
        newNote.title = self.title
        newNote.text = self.text
        newNote.bookmarked = false
        newNote.timestamp = Date()
        
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}


struct CreateNote_Previews: PreviewProvider {
    static var previews: some View {
        CreateNote().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
