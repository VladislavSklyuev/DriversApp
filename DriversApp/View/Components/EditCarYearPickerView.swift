//
//  EditCarYearPickerView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 05.09.2023.
//

import SwiftUI

struct EditCarYearPickerView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var cCVM: CarsCellViewModel
    @EnvironmentObject var cVM: CarsViewModel
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Spacer()
                Button("Готово") {
                    cCVM.save(id: cCVM.position.id)
                    cVM.getCars()
                    dismiss()
                }
            }
            .bold()
            .padding(.horizontal, 15)
        }
        .padding(.vertical, 10)
        VStack(alignment: .center, spacing: 8) {
            Text("Измените год выпуска авто:")
                .foregroundStyle(.black).bold()
            
            Picker(selection: $cCVM.position.year) {
                ForEach(1990..<2024) { year in
                    Text("\(year)")
                 .tag(year)
                }
            } label: {
                Text("")
            }
            .pickerStyle(.wheel)
//                .padding(8)
//                .frame(maxWidth: .infinity)
//                .background(Color("c4").opacity(0.8))
//                .clipShape(Capsule())
//                .foregroundColor(.black)
                
        }
    }
}

struct EditCarYearPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EditCarYearPickerView()
    }
}
