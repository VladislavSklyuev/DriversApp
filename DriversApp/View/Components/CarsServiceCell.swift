//
//  CarsServiceView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 15.08.2023.
//

import SwiftUI

struct CarsServiceCell: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var carCVM: CarsCellViewModel
    @EnvironmentObject var carVM: CarsViewModel
    @State var showEditProbegTO = false
    @State var showEditProbeg = false
    @State var showEditBrakePads = false
    @State var showEditSparkPlugs = false
    @State var showEditLinks = false
    @State var showInfoAlert = false
    @State var showlastDateTO = false
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Следующее ТО через:")
                    Spacer()
                    Text("\((carCVM.position.lastProbegInTO + 15000) - carCVM.position.currentMileage) км.")
                        .foregroundColor(.black).bold()
                }
                HStack {
                    Text("Дата ТО:")
                    Spacer()
                    Button("\(carCVM.position.lastDateTO.format())") {
                        showlastDateTO.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                HStack {
                    Text("Текущий пробег")
                    Spacer()
                    Button("\(carCVM.position.currentMileage) км.") {
                        showEditProbeg.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                HStack {
                    Text("Пробег на ТО:")
                    Spacer()
                    Button("\(carCVM.position.lastProbegInTO) км.") {
                        showEditProbegTO.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                
                HStack {
                    Text("Замена масла:")
                    Spacer()
                    Text("\(carCVM.position.currentMileage - carCVM.position.lastProbegInTO) км. назад")
                        .foregroundColor(.blue)
                }
                HStack {
                    Text("Замена колодок:")
                        .frame(width: 135)
                    Spacer()
                    Button("\(carCVM.position.currentMileage - carCVM.position.brakePadsChange) км. назад") {
                        showEditBrakePads.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                
                HStack {
                    Text("Замена линков:")
                        .frame(width: 135)
                    Spacer()
                    Button("\(carCVM.position.currentMileage - carCVM.position.linksChange) км. назад") {
                        showEditLinks.toggle()
                    }
                    .buttonStyle(.borderless)
                }
                
                HStack {
                    Text("Замена свечей: ")
                        .frame(width: 135)
                    Spacer()
                    Button("\(carCVM.position.currentMileage - carCVM.position.sparkPlugChange) км. назад") {
                        showEditSparkPlugs.toggle()
                    }
                    .buttonStyle(.borderless)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.blue).bold()
                        Text(carCVM.position.number)
                    }
                }
            }
        }
        .onAppear {
            if (carCVM.position.currentMileage - carCVM.position.lastProbegInTO) >= 13000 {
                showInfoAlert.toggle()
            }
        }
        .alert("Внимание!", isPresented: $showInfoAlert) {
            Button(role: .cancel) {
            } label: {
                Text("ОК")
            }
        } message: {
            Text("До ТО осталось - \(carCVM.position.lastProbegInTO + 15000 - carCVM.position.currentMileage) км.")
        }
        .alert("Обновить текущий пробег", isPresented: $showEditProbeg) {
            TextField("Введите пробег", value: $carCVM.position.currentMileage, format: .number)

            Button {
                carCVM.save(id: carCVM.position.id)
                carVM.getCars()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальный пробег")
        }
        .alert("Обновить пробег", isPresented: $showEditProbegTO) {
            TextField("Введите пробег на ТО", value: $carCVM.position.lastProbegInTO, format: .number)

            Button {
                carCVM.save(id: carCVM.position.id)
                carVM.getCars()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальный пробег ТО")
        }
        
        .alert("Замена колодок", isPresented: $showEditBrakePads) {
            TextField("Введите пробег", value: $carCVM.position.brakePadsChange, format: .number)

            Button {
                carCVM.save(id: carCVM.position.id)
                carVM.getCars()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальный пробег замены колодок")
        }
        
        .alert("Замена линков", isPresented: $showEditLinks) {
            TextField("Введите пробег", value: $carCVM.position.linksChange, format: .number)

            Button {
                carCVM.save(id: carCVM.position.id)
                carVM.getCars()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальный пробег замены линков")
        }
        .alert("Замена свечей зажигания", isPresented: $showEditSparkPlugs) {
            TextField("Введите пробег", value: $carCVM.position.sparkPlugChange, format: .number)

            Button {
                carCVM.save(id: carCVM.position.id)
                carVM.getCars()
            } label: {
                Text("OK")
            }

            Button(role: .cancel) {
            } label: {
                Text("Отменить")
            }

        } message: {
            Text("Введите актуальный пробег замены свечей")
        }
        .sheet(isPresented: $showlastDateTO) {
            LastDateTOView()
                .environmentObject(carCVM)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
                .presentationBackground(.white)
                .padding(.top)
        }
    }
}

struct CarsServiceView_Previews: PreviewProvider {
    static var previews: some View {
        CarsServiceCell()
    }
}
