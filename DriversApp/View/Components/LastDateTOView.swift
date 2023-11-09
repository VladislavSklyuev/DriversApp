//
//  LastDateTOView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 24.08.2023.
//

import SwiftUI

struct LastDateTOView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var carsServiceVM: CarsCellViewModel
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Button("Готово") {
                    dismiss()
                    carsServiceVM.save(id: carsServiceVM.position.id)
                }
            }
            .padding(.horizontal, 15)
        }
        .padding(.vertical, 10)
        VStack(alignment: .center, spacing: 8) {
            Text("Выберите дату ТО:")
                .foregroundStyle(.gray)
            DatePicker(selection: $carsServiceVM.position.lastDateTO, displayedComponents: .date) {
                
            }
            .labelsHidden()
            .datePickerStyle(.wheel)
        }

    }
}

struct LastDateTOView_Previews: PreviewProvider {
    static var previews: some View {
        LastDateTOView()
    }
}
