//
//  ContentView.swift
//  MusincClient2
//
//  Created by Lawrence Harrison on 08/12/2022.
//

import SwiftUI

var country: String = ""


struct ContentView: View {
    @State private var showingAccountSheet = false
    var body: some View {
        VStack {
            TabView() {
                    Text("Musinc")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.heavy/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.center)
                        .padding(.top, -360.0)
                
                .tabItem {
                    Label("", systemImage: "house")
                }.tag(1)
                List {
                    HStack() {
                        Button(action: {
                            print("account button")
                            showingAccountSheet.toggle()
                        }, label: {
                            Label("Account", systemImage: "person.crop.circle.fill").labelStyle(accLabelStyle())
                        })
                        .sheet(isPresented: $showingAccountSheet) {
                                    AccountView()
                                }
                    }.frame(height: 100.0)
                    HStack {
                        Button("Connect to Server") {
                            print("testAgain")
                            
                        }
                    }
                }.tabItem {
                    Label("", systemImage: "gear")
                }.tag(2)
                
            }
            .padding(.bottom, -20.0)
            .frame(
                width: UIScreen.main.bounds.width ,
                height: UIScreen.main.bounds.height
            )
            
        }
        .padding()
    }
}

struct accLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.icon
                    .scaleEffect(4, anchor: .center)
                    .padding(.horizontal, 25.0)
                configuration.title
                    .font(.system(size: 25))
            }
            .font(.caption)
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AccountView: View {
    var body: some View {
        Text("Example")
    }
}
