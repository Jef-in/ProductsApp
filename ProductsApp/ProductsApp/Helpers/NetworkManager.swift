//
//  NetworkManager.swift
//  ProductsApp
//
//  Created by Jefin on 21/05/22.
//

import Combine
import Network

public protocol NetworkObserveable: AnyObject{
    func statusDidChange(status: NWPath.Status)
}

public protocol NetworkManageable {
    func startMonitoring()
    func stopMonitoring()
    func addObserver(observer: NetworkObserveable)
    var currentStatus: NWPath.Status { get }
}

struct NetworkChangeObservation {
    weak var observer: NetworkObserveable?
}

class NetworkManager: NetworkManageable {
    static let shared = NetworkManager()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private var currentPath: NWPath?
    var cancellables = Set<AnyCancellable>()
    private var observations = [ObjectIdentifier: NetworkChangeObservation]()
    var currentStatus: NWPath.Status {
        get {
            return monitor.currentPath.status
        }
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [unowned self] path in
            for (id, observations) in self.observations {
                
                //If any observer is nil, remove it from the list of observers
                guard let observer = observations.observer else {
                    self.observations.removeValue(forKey: id)
                    continue
                }
                
                DispatchQueue.main.async(execute: {
                    observer.statusDidChange(status: path.status)
                })
            }
        }
    }
    
    public func stopMonitoring() {
        
        monitor.cancel()
    }
    
    public func addObserver(observer: NetworkObserveable) {
           let id = ObjectIdentifier(observer)
           observations[id] = NetworkChangeObservation(observer: observer)
       }

       func removeObserver(observer: NetworkObserveable) {
           let id = ObjectIdentifier(observer)
           observations.removeValue(forKey: id)
       }
}
