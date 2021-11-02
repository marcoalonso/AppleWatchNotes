//
//  ContentView.swift
//  NOTAS WatchKit Extension
//
//  Created by marco rodriguez on 02/11/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    // MARK: - Function
    func save() {
        dump(notes)
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6){
                TextField("Agregar nueva", text: $text)
                
                Button {
                    //Action:
                    //1.- Only run the button´s action when the text field is not empty
                    guard text.isEmpty == false else { return }
                    
                    //2.- Create a new note item and initialize it whith the text value
                    let note = Note(id: UUID(), text: text)
                    
                    //3.- Add the new note item to the notes array (append)
                    notes.append(note)
                    
                    //4.- Make the textField empty
                    text = ""
                    
                    //5.- Save the notes (function)
                    
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                //.buttonStyle(BorderedButtonStyle(tint: .accentColor))
            }//: Hstack
            Spacer()
            Text("\(notes.count)")
        }//: Vstack
        .navigationTitle("Notas")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
