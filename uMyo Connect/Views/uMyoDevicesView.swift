//
//  ContentView.swift
//  uMyo Connect
//
//  Created by Aahil Lakhani on 9/8/24.
//

import SwiftUI
import uMyoBleSdk

struct uMyoDevicesView: View {
    @StateObject var umyo = uMyoDevicesManager()
    
    var body: some View {
        NavigationStack {
            Group {
                switch umyo.bluetoothState {
                case .poweredOn:
                    if umyo.devices.isEmpty {
                        Text("No uMyo devices found.")
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(umyo.devices) { device in
                                NavigationLink {
                                    uMyoDeviceDetailView(device: device)
                                } label: {
                                    uMyoDeviceRow(device: device)
                                }
                            }
                        }
                    }
                case .poweredOff:
                    Text("Bluetooth is disabled.")
                        .foregroundColor(.gray)
                case .resetting:
                    Text("Bluetooth is resetting.")
                        .foregroundColor(.gray)
                case .unauthorized:
                    Text("Bluetooth permissions are disabled.")
                        .foregroundColor(.gray)
                case .unsupported:
                    Text("Bluetooth is unsupported on this device.")
                        .foregroundColor(.gray)
                default:
                    Text("Bluetooth status is unknown.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("uMyo Devices")
        }
    }
}

#Preview {
    uMyoDevicesView()
}
