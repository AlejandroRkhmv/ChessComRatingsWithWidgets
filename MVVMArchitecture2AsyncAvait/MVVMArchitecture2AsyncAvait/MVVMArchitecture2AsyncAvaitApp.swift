//
//  MVVMArchitecture2AsyncAvaitApp.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import SwiftUI

@main
struct MVVMArchitecture2AsyncAvaitApp: App {
    let navigationState = NavigationState()
    var body: some Scene {
        WindowGroup {
            ContainerView().environmentObject(navigationState)
        }
    }
}
