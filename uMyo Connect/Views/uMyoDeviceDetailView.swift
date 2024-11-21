//
//  uMyoDeviceDetailView.swift
//  uMyo Connect
//
//  Created by Aahil Lakhani on 11/19/24.
//

import SwiftUI
import uMyoBleSdk
import BatteryView
import Charts

struct uMyoDeviceDetailView: View {
    @ObservedObject private var device: uMyoDevice
    @StateObject private var dataViewModel = uMyoDataViewModel()
    
    enum Charts: String, CaseIterable {
        case muscleLevel = "Muscle Level"
        case emgSP0 = "EMG SP0"
        case emgSP1 = "EMG SP1"
        case emgSP2 = "EMG SP2"
        case emgSP3 = "EMG SP3"
        case quaternionW = "Quaternion W"
        case quaternionX = "Quaternion X"
        case quaternionY = "Quaternion Y"
        case quaternionZ = "Quaternion Z"
    }
    
    @State private var selectedChart = Charts.muscleLevel
    
    init(device: uMyoDevice) {
        self.device = device
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Status:")
                    Spacer()
                    Text(device.isConnected ? "Connected" : "Disconnected")
                }
                HStack {
                    Text("Battery:")
                    Spacer()
                    Text(String(Int(device.currentBatteryLevel * 100)) + "%")
                }
            }
            
            Section {
                Button {
                    if !dataViewModel.isRecording {
                        dataViewModel.startRecording(device: device)
                    } else {
                        dataViewModel.stopRecording()
                    }
                } label: {
                    if !dataViewModel.isRecording {
                        Text("Start Recording")
                    } else {
                        Text("Stop Recording")
                    }
                }
                .disabled(!device.isConnected)
            }
            
            Section {
                if !dataViewModel.data.isEmpty {
                    Picker("Chart", selection: $selectedChart) {
                        ForEach(Charts.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    switch selectedChart {
                    case .muscleLevel:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.muscleLevel)
                    case .emgSP0:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.spectrum.sp0)
                    case .emgSP1:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.spectrum.sp1)
                    case .emgSP2:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.spectrum.sp2)
                    case .emgSP3:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.spectrum.sp3)
                    case .quaternionW:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.quaternion.w)
                    case .quaternionX:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.quaternion.x)
                    case .quaternionY:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.quaternion.y)
                    case .quaternionZ:
                        SignalChart(data: dataViewModel.data, xKeyPath: \.dataTime, yKeyPath: \.quaternion.z)
                    }
                }
            }
            
            Section {
                if !dataViewModel.data.isEmpty && (!dataViewModel.isRecording || !device.isConnected) {
                    Button {
                        
                    } label: {
                        Text("Export Recording")
                    }
                }
            }
        }
        .navigationTitle(device.id.uuidString)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct uMyoDeviceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let device = uMyoDevice(id: UUID(), currentDataTime: Date(), currentDataID: 1, currentBatteryLevel: 0.32, currentSpectrum: Spectrum(sp0: 100, sp1: 111, sp2: 232, sp3: 232), currentMuscleLevel: 100, currentQuaternion: Quaternion(w: 23, x: 231, y: 231, z: 232))
        
        NavigationStack{
            uMyoDeviceDetailView(device: device)
        }
    }
}
