//
//  ContentView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 15.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @EnvironmentObject var mVM: MainViewModel
    
    var body: some View {
        
        if let currentUser = viewModel.currentUser {
            
                MainView(viewModel: MainViewModel(user: currentUser))
                    .environmentObject(viewModel)
                    .animation(.easeInOut, value: viewModel.currentUser != nil)
        } else {
            AuthorizationView()
                .environmentObject(viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
