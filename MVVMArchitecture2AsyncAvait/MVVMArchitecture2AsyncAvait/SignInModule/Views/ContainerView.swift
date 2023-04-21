//
//  ContainerView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import SwiftUI

struct ContainerView: View {
    
    @EnvironmentObject private var navigationState: NavigationState
    
    var body: some View {
        NavigationStack(path: $navigationState.path) {
            SignInView()
                .withNavigationDestination()
        }
    }
}
