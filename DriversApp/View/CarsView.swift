//
//  CarsView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import SwiftUI

struct CarsView: View {

@EnvironmentObject var contentVM: ContentViewModel
@EnvironmentObject var mainVM: MainViewModel
@Environment (\.dismiss) var dismiss
@StateObject var viewModel = CarsViewModel()
@State private var showAddCar = false

    var body: some View {
        
        NavigationView {
            List {
                ForEach(viewModel.cars) { car in
                    NavigationLink {
                        CarsCell(viewModel: CarsCellViewModel(position: car))
                            .environmentObject(viewModel)
                    } label: {
                        HStack(spacing: 3) {
                            Text(car.brand)
                            Text(car.model)
                            Text(car.number)
                        }
                    }
                    .overlay(alignment: .trailing) {
                        if (car.currentMileage - car.linksChange) >= 25000 {
                            Image(systemName: "steeringwheel.exclamationmark")
                                .foregroundColor(.red)
                                .offset(x: -20)
                        } else if (car.currentMileage - car.brakePadsChange) >= 30000 {
                            Image(systemName: "exclamationmark.brakesignal")
                                .foregroundColor(.red)
                                .offset(x: -20)
                        } else if (car.currentMileage - car.sparkPlugChange) >= 60000 {
                            Image(systemName: "engine.combustion.fill")
                                .foregroundColor(.red)
                                .offset(x: -20)
                        }
                    }
                }
            }
            .navigationBarTitle("Парковые авто")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddCar.toggle()
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
            viewModel.getCars()
        }
        .sheet(isPresented: $showAddCar) {
            AddCarView()
                .environmentObject(viewModel)
                .presentationCornerRadius(20)
                .presentationBackground(.white)
                .padding(.top)
            
        }
    }
}

struct CarsView_Previews: PreviewProvider {
    static var previews: some View {
        CarsView()
    }
}
