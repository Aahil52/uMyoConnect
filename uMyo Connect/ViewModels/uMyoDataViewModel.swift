//
//  uMyoDeviceDataViewModel.swift
//  uMyo Connect
//
//  Created by Aahil Lakhani on 11/19/24.
//

import Foundation
import uMyoBleSdk
import Combine

class uMyoDataViewModel: ObservableObject {
    @Published var data: [uMyoData] = []
    @Published var isRecording = false
    
    private var cancellable: Cancellable?
    
    func startRecording(device: uMyoDevice) {
        if !isRecording {
            data = []
            
            cancellable = device.updates
                .map { updatedDevice in
                    uMyoData(id: UUID(), dataTime: updatedDevice.currentDataTime, dataID: updatedDevice.currentDataID, spectrum: updatedDevice.currentSpectrum, muscleLevel: updatedDevice.currentMuscleLevel, quaternion: updatedDevice.currentQuaternion)
                }
                .sink { [weak self] dataPoint in
                    guard let self = self else {
                        return
                    }
                    
                    self.data.append(dataPoint)
                }
            isRecording = true
        }
    }
    
    func stopRecording() {
        if isRecording {
            cancellable?.cancel()
            isRecording = false
        }
    }
    
}
