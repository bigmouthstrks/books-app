//
//  Viewlifecycable.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//

import Foundation

// MARK: - ViewLifecycable
protocol Viewlifecycleable: AnyObject {
    func onViewDidLoad()
    func onViewWillAppear()
    func onViewWillLayoutSubviews()
    func onViewDidLayoutSubviews()
    func onViewDidAppear()
    func onViewWillDisappear()
}

// MARK: - Default Impl
extension Viewlifecycleable {
    func onViewDidLoad() {}
    func onViewWillAppear() {}
    func onViewWillLayoutSubviews() {}
    func onViewDidLayoutSubviews() {}
    func onViewDidAppear() {}
    func onViewWillDisappear() {}
}
