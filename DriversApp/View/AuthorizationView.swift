//
//  AuthorizationView.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 02.08.2023.
//

import SwiftUI

struct AuthorizationView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject var viewModel = AuthorizationViewModel()
    @EnvironmentObject var contentVM: ContentViewModel
    @State private var isAuth = true
    //@State private var isUnlocked = false
    
    var body: some View {
        
            VStack(spacing: 16) {
                
                Text(isAuth ? "Авторизация" : "Регистрация")
                    .font(.custom("Montserrat-Bold", size: 18))
                    .frame(width: 320)

                
                VStack(spacing: 8) {
                    TextField("Логин", text: $viewModel.login)
                        .font(.custom("Montserrat-Regular", size: 18))
                        .foregroundColor(.black)
                        .padding(12)
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    
                    SecureField("Пароль", text: $viewModel.password)
                        .font(.custom("Montserrat-Regular", size: 18))
                        .foregroundColor(.black)
                        .padding(12)
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    
                    if !isAuth {
                        SecureField("Повторите пароль", text: $viewModel.confirm)
                            .font(.custom("Montserrat-Regular", size: 18))
                            .foregroundColor(.black)
                            .padding(12)
                            .background(.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                }
                
                VStack {
                    Button(isAuth ? " Войти" : "Создать аккаунт") {

                        if isAuth {
                            viewModel.auth {
                                contentVM.currentUser = AuthService.shared.currentUser
                            }
                        } else {
                            viewModel.signUp {
                                contentVM.currentUser = AuthService.shared.currentUser
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .font(.custom("Montserrat-Regular", size: 18))
                    .frame(height: 40)
                    .background(.black)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    
                    Button(isAuth ? "Регистрация" : "Уже есть аккаунт") {
                        isAuth.toggle()
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .font(.custom("Montserrat-Regular", size: 18))
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1.5))
                    
                }
            }
            .frame(width: 320)
            .background(.white)
            .padding()
    }
    
    struct AuthorizationView_Previews: PreviewProvider {
        static var previews: some View {
            AuthorizationView()
        }
    }
}
