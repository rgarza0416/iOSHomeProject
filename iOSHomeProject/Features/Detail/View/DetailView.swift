//
//  DetailView.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/20/24.
//

import SwiftUI

struct DetailView: View {
    
    let userId: Int
    @StateObject private var vm = DetailViewModel()
    
    var body: some View {
        ZStack {
            background
            
            if vm.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        
                        avatar
                        
                        Group {
                            general
                            link
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 18)
                        .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                        
                    }
                    .padding()
                }
        }
        }
        .navigationTitle("Details")
        .task {
           await vm.fetchDetails(for: userId)
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
//            Button("Retry") {
//                vm.fetchDetails(for: userId)
//            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    private static var previewUserId: Int {
        let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        return users.data.first!.id
    }
    static var previews: some View {
        NavigationView {
            DetailView(userId: previewUserId)
        }
    }
}

private extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
        
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = vm.userInfo?.data.avatar,
           let avatarURL = URL(string: avatarAbsoluteString) {
            
            AsyncImage(url: avatarURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = vm.userInfo?.support.url,
           let supportURL = URL(string: supportAbsoluteString),
           let supportTxt = vm.userInfo?.support.text {
            
            Link(destination: supportURL , label: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(supportTxt)
                        .foregroundStyle(Theme.text)
                        .font(.system(.body, design: .rounded).weight(.semibold))
                        .multilineTextAlignment(.leading)
                    
                    Text(supportAbsoluteString)
                }
                
                Spacer()
                
                Symbols
                    .link
                    .font(.system(.title3, design: .rounded))
            })
        }
    }
}

private extension DetailView {
    
    var general: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            PillView(id: vm.userInfo?.data.id ?? 0 )
            
            Group {
                firstName
                lastName
                email
            }
            .foregroundStyle(Theme.text)
        }
    }
    
    @ViewBuilder
    var firstName: some View {
        Text("First Name")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(vm.userInfo?.data.firstName ?? "")
            .font(.system(.subheadline, design: .rounded).weight(.semibold))
        
        Divider()
    }
    
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(vm.userInfo?.data.lastName ?? "")
            .font(.system(.subheadline, design: .rounded).weight(.semibold))
        
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(vm.userInfo?.data.email ?? "")
            .font(.system(.subheadline, design: .rounded).weight(.semibold))
    }
}
