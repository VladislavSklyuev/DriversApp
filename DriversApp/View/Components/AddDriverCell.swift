//
//  AddDriverView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import SwiftUI

struct AddDriverCell: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var driversVM: DriversViewModel
    @StateObject var viewModel = AddDriverViewModel()
    @State var showDatePicker = false
    @State var showDateLicense = false
    @State var showDateExpLicense = false
    @State var showAlertEmptyUD = false
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Новый водитель")
                    .bold()
            }
            .padding()

            List {
                
                TextField("", text: $viewModel.surname, prompt: Text("Фамилия").font(.callout).foregroundColor(.gray))
                
                TextField("", text: $viewModel.name, prompt: Text("Имя").font(.callout).foregroundColor(.gray))
                
                TextField("", text: $viewModel.lastname, prompt: Text("Отчество").font(.callout).foregroundColor(.gray))
                
                TextField("", text: $viewModel.numberDriverLicense, prompt: Text("Номер и серия ВУ").font(.callout).foregroundColor(.gray))
                HStack {
                    Text("Дата рождения")
                        .font(.callout).foregroundColor(.gray)
                    Spacer()
                    Button("\(viewModel.birthday.format())") {
                        showDatePicker.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                
                HStack {
                    Text("Дата выдачи ВУ")
                        .font(.callout).foregroundColor(.gray)
                    Spacer()
                    Button("\(viewModel.dateOfdriverLic.format())") {
                        showDateLicense.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                
                HStack {
                    Text("Действует до")
                        .font(.callout).foregroundColor(.gray)
                    Spacer()
                    Button("\(viewModel.driverLicExpDate.format())") {
                        showDateExpLicense.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                
                TextField("", text: $viewModel.numberPhone, prompt: Text("Номер телефона без \("'+7'")").font(.callout).foregroundColor(.gray))
            }
            .listStyle(.inset)
            .listRowSeparator(.visible)
        }
        
        .sheet(isPresented: $showDatePicker) {
            BirthDayPickerView()
                .environmentObject(viewModel)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
                .presentationBackground(.white)
                .padding(.top)

        }
        
        .sheet(isPresented: $showDateLicense) {
            DateOfDriverLicenseView()
                .environmentObject(viewModel)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
                .presentationBackground(.white)
                .padding(.top)
        }
        
        .sheet(isPresented: $showDateExpLicense) {
            DateExpLicenseView()
                .environmentObject(viewModel)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
                .presentationBackground(.white)
                .padding(.top)
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
                guard viewModel.surname != "" && viewModel.name != "" && viewModel.lastname != "" && viewModel.numberDriverLicense != "" else {
                    showAlertEmptyUD.toggle()
                    return
                }
                    viewModel.save()
                    driversVM.getDrivers()
                    dismiss()
            } label: {
                Text("Готово")
                    .foregroundColor(.blue)
                    .offset(x: -12, y: 5)
            }
        }

    }
}

struct AddDriverView_Previews: PreviewProvider {
    static var previews: some View {
        AddDriverCell()
    }
}
