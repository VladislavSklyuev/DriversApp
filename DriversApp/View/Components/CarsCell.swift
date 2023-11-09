//
//  CarsCell.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import SwiftUI

struct CarsCell: View {
    
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var cVM: CarsViewModel
    @StateObject var viewModel: CarsCellViewModel
    @State private var showCarsService = false
    @State private var showCarStatement = false
    @State private var showDeleteDriver = false
    @State private var newValue: Int?
    @State private var showAlertBrand = false
    @State private var showAlertModel = false
    @State private var showAlertColor = false
    @State private var showAlertNumber = false
    @State private var showEditCarYear = false
    @State private var showAlertVin = false
    @State private var showAlertSts = false
    @State var showEditProbeg = false
    
    var body: some View {
            List {
                Section {
                    HStack {
                        Text("Марка:")
                        Spacer()
                        Text(viewModel.position.brand)
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showAlertBrand.toggle()
                            }
                    }
                    
                    HStack {
                        Text("Модель:")
                        Spacer()
                        Text(viewModel.position.model)
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showAlertModel.toggle()
                            }
                    }
                    
                    HStack {
                        Text("Цвет:")
                        
                        Spacer()
                        Text(viewModel.position.color)
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showAlertColor.toggle()
                            }
                    }
                }
                Section {
                    HStack {
                        Text("Гос. номер:")
                        Spacer()
                        Text(viewModel.position.number)
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showAlertNumber.toggle()
                            }
                    }
                    
                    HStack {
                        Text("Год выпуска:")
                        Spacer()
                        Text(String(viewModel.position.year))
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showEditCarYear.toggle()
                            }
                    }
                    
                    HStack {
                        Text("VIN номер:")
                        Spacer()
                        Text(viewModel.position.vinNumber)
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showAlertVin.toggle()
                            }
                    }
                    
                    HStack {
                        Text("Номер СТС:")
                        Spacer()
                        Text("\(viewModel.position.numberSts)")
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showAlertSts.toggle()
                            }
                    }
                }
                Section {
                    HStack {
                        Text("Текущий пробег:")
                        Spacer()
                        Text(String(viewModel.position.currentMileage))
                        //.padding(.horizontal, 15)
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showEditProbeg.toggle()
                            }
                    }
//                    HStack {
//                        
//                        NavigationLink {
//                            CarInspectionCell(viewModel: CarInspectionCellViewModel(position: viewModel.position))
//                                .environmentObject(cVM)
//                            
//                        } label: {
//                            Text("Данные осмотра:")
//                        }
//                    }
                    HStack {
                        Text("ТО:")
                        Spacer()
                            .overlay(alignment: .trailing) {
                                Button {
                                    showCarsService.toggle()
                                } label: {
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.blue)
                                        .offset(x: 9)
                                }
                            }
                    }
                    HStack {
                        Text("Ведомость:")
                        Spacer()
                            .overlay(alignment: .trailing) {
                                Button {
                                    showCarStatement.toggle()
                                } label: {
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.blue)
                                        .offset(x: 9)
                                }
                            }
                    }
                }
            }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDeleteDriver.toggle()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            cVM.getCars()
        }
        .alert("Удалить авто?", isPresented: $showDeleteDriver) {
            Button {
                print(viewModel.position.id)
                cVM.deleteCar(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Данное действие приведет к удалению автомобиля")
        }
        .alert("Марка", isPresented: $showAlertBrand) {
            TextField("Введите марку", text: $viewModel.position.brand)
            Button {
                viewModel.save(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Введите актуальную марку")
        }
        .alert("Модель", isPresented: $showAlertModel) {
            TextField("Введите модель", text: $viewModel.position.model)
            Button {
                viewModel.save(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Введите актуальную модель")
        }
        .alert("Цвет", isPresented: $showAlertColor) {
            TextField("Введите цвет", text: $viewModel.position.color)
            Button {
                viewModel.save(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Введите актуальный цвет")
        }
        .alert("Гос. номер", isPresented: $showAlertNumber) {
            TextField("Введите номер", text: $viewModel.position.number)
            Button {
                viewModel.save(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Введите актуальный номер")
        }
        .alert("VIN номер", isPresented: $showAlertVin) {
            TextField("Введите номер", text: $viewModel.position.vinNumber)
            Button {
                viewModel.save(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Введите актуальный VIN номер")
        }
        .alert("Номер СТС", isPresented: $showAlertSts) {
            TextField("Введите номер", value: $viewModel.position.numberSts, format: .number)
            Button {
                viewModel.save(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Введите актуальный номер СТС")
        }
        .alert("Обновить пробег?", isPresented: $showEditProbeg) {
            TextField("Введите текущий пробег", value: $viewModel.position.currentMileage, format: .number)
            Button {
                viewModel.save(id: viewModel.position.id)
                cVM.getCars()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Данное действие обновит текущий пробег")
        }
        .sheet(isPresented: $showEditCarYear) {
            EditCarYearPickerView()
                .environmentObject(viewModel)
                .environmentObject(cVM)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
                .presentationBackground(.white)
                .padding(.top)
        }
        .fullScreenCover(isPresented: $showCarsService) {
            CarsServiceCell()
                .environmentObject(viewModel)
                .environmentObject(cVM)
        }
        .fullScreenCover(isPresented: $showCarStatement) {
            CarStatementCell()
                .environmentObject(viewModel)
                .environmentObject(cVM)
        }
        .navigationTitle("\(viewModel.position.number)")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//struct CarsCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CarsCell()
//    }
//}
