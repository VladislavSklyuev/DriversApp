//
//  EditBirthDayPickerView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 30.08.2023.
//

import SwiftUI

struct EditBirthDayPickerView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var dcVM: DriverCellViewModel
    @EnvironmentObject var dVM: DriversViewModel
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Spacer()
                Button("Готово") {
                    dcVM.save(id: dcVM.position.id)
                    dVM.getDrivers()
                    dismiss()
                }
            }
            .bold()
            .padding(.horizontal, 15)
        }
        .padding(.vertical, 10)
        
        VStack(alignment: .center, spacing: 8) {
            Text("Измените дату рождения:")
                .foregroundStyle(.gray)
            DatePicker(" ", selection: $dcVM.position.birthDay, displayedComponents: .date).foregroundColor(.gray)
            .labelsHidden()
                .datePickerStyle(.wheel)
        }

    }
}

struct EditBirthDayPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EditBirthDayPickerView()
    }
}
