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
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        //dump(notes)
        
        do {
            //1.- Convert the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            //2.- Create a new URL to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            //3.- Write the data to the given URL
            try data.write(to: url)
            
        } catch {
            print("Error al guardar notas!")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                //1.- Get the note URL path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                //2.- Create a new property fot the data
                let data = try Data(contentsOf: url)
                
                //3.- DEcode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                //do nothing
            }
        }
        
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
        .onAppear(perform: {
            load()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
