//
//  ContentView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import SwiftUI

struct DriversView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var addDriverVM: AddDriverViewModel
    @EnvironmentObject var contentVM: ContentViewModel
    @EnvironmentObject var mainVM: MainViewModel
    @StateObject var viewModel = DriversViewModel()
    @State private var showAddDriver = false
    @State private var showDriver = false
    
    var body: some View {
        
            NavigationView {
                List {
                    ForEach(viewModel.drivers) { driver in
                        NavigationLink {
                            DriverCell(viewModel: DriverCellViewModel(position: driver))
                                .environmentObject(viewModel)
                        } label: {
                            HStack(spacing: 3) {
                                Text(driver.surname)
                                Text(driver.name)
                                Text(driver.lastname)
                            }
                        }
                    }
//                    Button {
//                        print(viewModel.drivers.count)
//                    } label: {
//                        Text("Кол-во водителей")
//                    }
                }

                .navigationTitle("Водители")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddDriver.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            mainVM.signOut {
                                contentVM.currentUser = nil
                            }
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                                .rotationEffect(.degrees(180))
                        }
                        
                    }
                }
            }
            .onAppear {
                viewModel.getDrivers()
            }
            .sheet(isPresented: $showAddDriver) {
                AddDriverCell()
                    .environmentObject(viewModel)
                    .presentationCornerRadius(20)
                    .presentationBackground(.white)
                    .padding(.top)
            }
        }
}

struct DriversView_Previews: PreviewProvider {
    static var previews: some View {
        DriversView()
            .preferredColorScheme(.dark
)
    }
}
