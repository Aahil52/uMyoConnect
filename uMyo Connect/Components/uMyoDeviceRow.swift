//
//  SwiftUIView.swift
//  uMyo Connect
//
//  Created by Aahil Lakhani on 9/8/24.
//

import SwiftUI
import uMyoBleSdk
import BatteryView

struct uMyoDeviceRow: View {
    @ObservedObject var device: uMyoDevice
    
    var body: some View {
        VStack {
            HStack {
                Text(formatTime(device.lastDataTime))
                
                Spacer()
                
                Battery($device.batteryLevel)
                    .frame(width: 30)
            }
            
            HStack {
                Text("Data ID: \(device.lastDataID)")
                
                Spacer()
            }
            
            HStack {
                Text("Muscle Level: \(device.currentMuscleLevel)")
                
                Spacer()
            }
            
            HStack {
                Text("Spectrum: [\(device.currentSpectrum[0]), \(device.currentSpectrum[1]), \(device.currentSpectrum[2]), \(device.currentSpectrum[3])]")
                
                Spacer()
            }
            
            HStack {
                Text("Quaternion: [\(device.quaternion.w), \(device.quaternion.x), \(device.quaternion.y), \(device.quaternion.z)]")
                
                Spacer()
            }
        }
    }
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        return formatter.string(from: date)
    }
}

struct uMyoDeviceRow_Previews: PreviewProvider {
    static var previews: some View {
        let device = uMyoDevice(id: UUID(), lastDataTime: Date(), lastDataID: 1, batteryLevel: 0.32, currentSpectrum: [100, 111, 232, 232], currentMuscleLevel: 100, quaternion: uMyoDevice.Quaternion(w: 23, x: 231, y: 231, z: 232))
        
        uMyoDeviceRow(device: device)
    }
}
