//
//  ContentView.swift
//  BucketList
//
//  Created by Naveed on 19/09/2024.
//

import SwiftUI

struct User : Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
}


struct ContentView: View {
    
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            List(users) { user in
                Text("\(user.lastName)")
            }
            Button("Compare 1st Two Users") {
                let firstUser = users[0]
                let secondUser = users[1]
               
                print(firstUser > secondUser)
            }
            
            Button("Write & Read File") {
                let documentDirectoryPath = URL.documentsDirectory
                let filePath = documentDirectoryPath.appending(path: "message.txt")
                let data = Data("Hello from the File Contnet".utf8)
                
                do {
                    try data.write(to: filePath, options: [.atomic, .completeFileProtection])
                    let input = try String(contentsOf: filePath)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
