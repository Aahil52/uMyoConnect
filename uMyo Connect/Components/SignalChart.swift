//
//  SignalChart.swift
//  uMyo Connect
//
//  Created by Aahil Lakhani on 11/20/24.
//

import SwiftUI
import Charts

struct SignalChart<Data: Identifiable>: View {
    let data: [Data]
    let xKeyPath: KeyPath<Data, Date>
    let yKeyPath: KeyPath<Data, Int>

    var body: some View {
        Chart(data) {
            LineMark(x: .value("X-Axis", $0[keyPath: xKeyPath]),
                     y: .value("Y-Axis", $0[keyPath: yKeyPath]))
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 10)
        .frame(height: 200)
        .padding()
    }
}

struct SignalChart_Previews: PreviewProvider {
    struct ExampleData: Identifiable {
        let id = UUID()
        let dataTime: Date
        let example: Int
    }
    
    static var previews: some View {
        let data = [ExampleData(dataTime: Date.now, example: 1), ExampleData(dataTime: Date.now.advanced(by: 5), example: 2), ExampleData(dataTime: Date.now.advanced(by: 10), example: 0)]
        
        SignalChart(data: data, xKeyPath: \.dataTime, yKeyPath: \.example)
    }
}
