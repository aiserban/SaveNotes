//
//  DetailView.swift
//  SaveNotes
//
//  Created by Andrei Serban on 23.02.2021.
//

import SwiftUI

struct DetailView: View {
    @State var note: Note
    @State var title: String
    @State var text: String
    private var isNew: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    // We use this to go into Edit mode, rather than create a new note
    init(note: Note) {
        _note = State(initialValue: note)
        _title = State(initialValue: note.title ?? "")
        _text = State(initialValue: note.text ?? "")
        isNew = false
    }
    
    // Used for creating a new note
    init() {
        _note = State(initialValue: Note())
        _title = State(initialValue: "")
        _text = State(initialValue: "")
        isNew = true
    }
    
    var body: some View {
            List {
                Section {
                    TextField("Title", text: $title)
                }
                Section {
                    TextEditor(text: $text)
                }
            }.navigationBarTitle("Add note").listStyle(GroupedListStyle())
            .navigationBarItems(trailing: Button("Save", action: saveNote).disabled(self.title.isEmpty))
    }
    
    func saveNote() {
        if isNew {
            let newNote = Note(context: viewContext)
            newNote.title = self.title
            newNote.text = self.text
            newNote.bookmarked = false
            newNote.timestamp = Date()
        } else {
            note.title = self.title
            note.text = self.text
        }
        
        
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let newNote = Note()
        newNote.title = "asd"
        newNote.text = "sadsa"
        
        return DetailView(note: newNote)
    }
}
