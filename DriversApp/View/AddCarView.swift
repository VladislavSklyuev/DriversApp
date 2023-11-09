//
//  AddCarView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 02.08.2023.
//

import SwiftUI

struct AddCarView: View {
    
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var carsVM: CarsViewModel
    @StateObject var viewModel = AddCarViewModel()
    @State private var showAlertEmptyUD = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Новый авто")
                    .bold()
            }
            .padding()

            List {
                TextField("", text: $viewModel.brand, prompt: Text("Марка:").font(.callout).foregroundColor(.gray))
                
                TextField("", text: $viewModel.model, prompt: Text("Модель:").font(.callout).foregroundColor(.gray))
                
                TextField("", text: $viewModel.color, prompt: Text("Цвет:").font(.callout).foregroundColor(.gray))

                TextField("", text: $viewModel.number, prompt: Text("Гос. номер:").font(.callout).foregroundColor(.gray))
                
                TextField("", value: $viewModel.year, format: .number, prompt: Text("Год выпуска:").font(.callout).foregroundColor(.gray)).keyboardType(.numberPad)
                
                TextField("", text: $viewModel.vinNumber, prompt: Text("VIN-номер:").font(.callout).foregroundColor(.gray))
                
                TextField("", value: $viewModel.numberSts, format: .number, prompt: Text("Номер СТС:").font(.callout).foregroundColor(.gray)).keyboardType(.numberPad)
                
                TextField("", value: $viewModel.currentMileage, format: .number, prompt: Text("Текущий пробег:").font(.callout).foregroundColor(.gray)).keyboardType(.numberPad)
            }
            .listStyle(.inset)
            .listRowSeparator(.visible)

        }
        
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Text("Отменить")
                    .foregroundColor(.blue)
                    .offset(x: 12, y: 5)
            }
        }
        .alert("Введите все данные!", isPresented: $showAlertEmptyUD) {
            Button("OK", role: .cancel) { }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                guard viewModel.brand != "" && viewModel.model != "" && viewModel.color != "" && viewModel.number != "" && viewModel.year != 0 && viewModel.vinNumber != "" && viewModel.numberSts != 0 else {
                    showAlertEmptyUD.toggle()
                    return
                }
                viewModel.save()
                carsVM.getCars()
                dismiss()
            } label: {
                Text("Готово")
                    .foregroundColor(.blue)
                    .offset(x: -12, y: 5)
            }
        }
    }
}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView()
    }
}
