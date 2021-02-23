//
//  DetailView.swift
//  SaveNotes
//
//  Created by Andrei Serban on 23.02.2021.
//

import SwiftUI

struct DetailView: View {
    @State var title: String
    @State var text: String
    
    init(note: Note) {
        _title = State(initialValue: note.title ?? "")
        _text = State(initialValue: note.text ?? "")
    }
    
    var body: some View {
        TextField("Title", text: $title)
        TextEditor(text: $text)
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
