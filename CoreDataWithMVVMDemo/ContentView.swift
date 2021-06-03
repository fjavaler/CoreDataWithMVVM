//
//  ContentView.swift
//  CoreDataWithMVVMDemo
//
//  Created by Fred Javalera on 6/3/21.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: Properties
  @StateObject var vm = ContentViewModel()
  @State var textFieldText: String = ""
  
  // MARK: Body
  var body: some View {
    
    NavigationView {
      
      VStack(spacing: 20) {
        
        TextField("Add fruit here...", text: $textFieldText)
          .font(.headline)
          .padding(.leading)
          .frame(height: 55)
          .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
          .cornerRadius(10)
          .padding(.horizontal)
        
        Button(action: {
          guard !textFieldText.isEmpty else { return }
          vm.addFruit(text: textFieldText)
          textFieldText = ""
        }, label: {
          Text("Save".uppercased())
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)))
            .cornerRadius(10)
        })
        .padding(.horizontal)
        
        List {
          
          ForEach(vm.savedEntities) { entity in
            Text(entity.name ?? "NO NAME")
              .onTapGesture {
                vm.updateFruit(entity: entity)
              }
          }//: End ForEach
          .onDelete(perform: vm.deleteFruit)
          
        }//: List
        .listStyle(PlainListStyle())
      
      }//: VStack
      .navigationTitle("Fruits")
    
    }//: NavigationView
  
  }//: Body

}//: View

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
