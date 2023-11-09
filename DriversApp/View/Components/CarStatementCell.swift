//
//  CarStatementView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 31.08.2023.
//

import SwiftUI

struct CarStatementCell: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var carCVM: CarsCellViewModel
    @EnvironmentObject var carVM: CarsViewModel
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("За все время:")
                    Spacer()
                    Text("450000 руб")
                }
                
                HStack {
                    Text("За месяц:")
                    Spacer()
                    Text("45044 руб")
                }
                
                HStack {
                    Text("За неделю:")
                    Spacer()
                    Text("10012 руб")
                }
            }
            .navigationTitle("Заработок авто")
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
    }
}

struct CarStatementView_Previews: PreviewProvider {
    static var previews: some View {
        CarStatementCell()
    }
}
