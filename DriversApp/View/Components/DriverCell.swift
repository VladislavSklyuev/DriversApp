//
//  DriverCell.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import SwiftUI

struct DriverCell: View {
    @Environment (\.dismiss) var dismiss
    @StateObject var viewModel: DriverCellViewModel
    @EnvironmentObject var dVM: DriversViewModel
    @State var showEditView = false
    @State var showAlertSurname = false
    @State var showAlertName = false
    @State var showAlertLastName = false
    @State var showEditBirthDay = false
    @State var showAlertNumberPhone = false
    @State var showAlertNumberDriverLic = false
    @State var showDeleteDriver = false
    
    var body: some View {
        
        List {
            Section {
                HStack {
                    Text("Фамилия:")
                    Spacer()
                    Text(viewModel.position.surname)
                        .foregroundColor(.gray)
                        .onLongPressGesture {
                            showAlertSurname.toggle()
                        }
                }

                HStack {
                    Text("Имя:")
                    Spacer()
                    Text(viewModel.position.name)
                        .foregroundColor(.gray)
                        .onLongPressGesture {
                            showAlertName.toggle()
                        }
                }
                
                HStack {
                    Text("Отчество:")
                    Spacer()
                    Text(viewModel.position.lastname)
                        .foregroundColor(.gray)
                        .onLongPressGesture {
                            showAlertLastName.toggle()
                        }
                }
                
                HStack {
                    Text("Дата рождения:")
                    Spacer()
                    Text("\(viewModel.position.birthDay.format())")
                        .foregroundColor(.gray)
                        .onLongPressGesture {
                            showEditBirthDay.toggle()
                        }
                }
                
                HStack {
                    Text("Номер телефона:")
                    Spacer()
                    Button {
                        dVM.callForHelp(viewModel.position.numberPhone)
                    } label: {
                        Text("\(viewModel.position.numberPhone.formattedMask(viewModel.position.numberPhone, mask: "+7 (XXX) XXX-XX-XX"))")
                            .foregroundColor(.gray)
                            .onLongPressGesture {
                                showAlertNumberPhone.toggle()
                            }
                    }
                }
                
            }
 
            Section {
                HStack {
                    Text("Номер и серия ВУ:")
                    Spacer()
                    Text(viewModel.position.numberDriverLicense)
                        .foregroundColor(.gray)
                        .onLongPressGesture {
                            showAlertNumberDriverLic.toggle()
                        }
                }
                
                HStack {
                    Text("Дата выдачи ВУ:")
                    Spacer()
                    Text("\(viewModel.position.dateOfdriverLic.format())")
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Действует до:")
                    Spacer()
                    Text("\(viewModel.position.driverLicExpDate.format())")
                        .foregroundColor(.gray)
                }
            }
           
            Section {
                HStack {
                    Text("Рейтинг в ЯндексТакси:")
                    Spacer()
                    Text(String(viewModel.position.raiting))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Авто:")
                    Spacer()
                }
               
                HStack {
                    Text("Дата осмотра авто:")
                    Spacer()
                    Text("")
                        .foregroundColor(.gray)
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
            dVM.getDrivers()
        }
        .alert("Удалить водителя?", isPresented: $showDeleteDriver) {
            Button {
                dVM.deleteDriver(id: viewModel.position.id)
                dVM.getDrivers()
            } label: {
                Text("OK")
            }
            Button(role: .cancel) {
                
            } label: {
                Text("Отменить")
            }
        } message: {
            Text("Данное действие приведет к удалению водителя")
        }
        .alert("Фамилия", isPresented: $showAlertSurname) {
            TextField("Введите имя", text: $viewModel.position.surname)

            Button {
                viewModel.save(id: viewModel.position.id)
                dVM.getDrivers()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
                
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальную фамилию")
        }
        .alert("Имя", isPresented: $showAlertName) {
            TextField("Введите имя", text: $viewModel.position.name)

            Button {
                viewModel.save(id: viewModel.position.id)
                dVM.getDrivers()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
                
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальное имя")
        }
        .alert("Отчество", isPresented: $showAlertLastName) {
            TextField("Введите отчество", text: $viewModel.position.lastname)

            Button {
                viewModel.save(id: viewModel.position.id)
                dVM.getDrivers()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
                //dismiss()
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальное отчество")
        }
        .alert("Номер телефона", isPresented: $showAlertNumberPhone) {
            TextField("Введите номер телефона", text: $viewModel.position.numberPhone)
                .keyboardType(.numberPad)

            Button {
                viewModel.save(id: viewModel.position.id)
                dVM.getDrivers()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
                
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальный номер телефона")
        }
        .alert("Номер и серия ВУ", isPresented: $showAlertNumberDriverLic) {
            TextField("Введите Номер и серию ВУ", text: $viewModel.position.numberDriverLicense)

            Button {
                viewModel.save(id: viewModel.position.id)
                dVM.getDrivers()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
               
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальные номер и серию ВУ")
        }
        .sheet(isPresented: $showEditBirthDay) {
            EditBirthDayPickerView()
                .environmentObject(viewModel)
                .environmentObject(dVM)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
                .presentationBackground(.white)
                .padding(.top)
        }
        .navigationTitle("\(viewModel.position.name)")
        
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct DriverCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DriverCell()
//    }
//}
