//
//  DateExpLicense.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 22.08.2023.
//

import SwiftUI

struct DateExpLicenseView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var addDVM: AddDriverViewModel
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Spacer()
                Button("Готово") {
                    dismiss()
                }
            }
            .bold()
            .padding(.horizontal, 15)
        }
        .padding(.vertical, 10)
        VStack(alignment: .center, spacing: 8) {
            Text("Выберите дату выдачи ВУ:")
                .foregroundStyle(.gray)
            DatePicker(" ", selection: $addDVM.driverLicExpDate, displayedComponents: .date).foregroundColor(.gray)
                .labelsHidden()
                .datePickerStyle(.wheel)
        }
    }
}

struct DateExpLicense_Previews: PreviewProvider {
    static var previews: some View {
        DateExpLicenseView()
    }
}
