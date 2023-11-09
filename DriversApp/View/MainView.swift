//
//  MainView.swift
//  YandexAPI
//
//  Created by Владислав Склюев on 23.10.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @EnvironmentObject var contentVM: ContentViewModel
    var body: some View {
        
        TabView {
            if viewModel.isUnlocked {
                DriversView()
                    .environmentObject(viewModel)
                    .tint(.blue)
                    .tabItem { Label("Водители", systemImage: "person.3.fill")}
                CarsView()
                    .environmentObject(viewModel)
                    .tint(.blue)
                    .tabItem { Label("Водители", systemImage: "person.3.fill")}
            }
        }
        .onAppear(perform: viewModel.authenticate)
    }
}
//#Preview {
//    MainView()
//}
