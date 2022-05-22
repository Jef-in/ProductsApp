//
//  MockNetworkManager.swift
//  ProductsApp
//
//  Created by Jefin on 22/05/22.
//

import Network
class MockNetworkManager: NetworkManageable {
    var isStartMonitoringCalled = false
    
    var isStopMonitoringCalled = false
    
    var isaddObserverCalled = false
    
    var currentPathStatus: NWPath.Status = .unsatisfied
    
    func startMonitoring() {
        isStartMonitoringCalled = true
    }
    
    func stopMonitoring() {
        isStopMonitoringCalled = true
    }
    
    var currentStatus: NWPath.Status {
        currentPathStatus
    }
    
    func addObserver(observer: NetworkObserveable) {
        isaddObserverCalled = true
    }
}
