//
//  DataSourceable.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 01-09-21.
//

import Foundation

// MARK: - DataSourceable
protocol DataSourceable: AnyObject {
    var dataSource: DataSource? { get set }
    func set(dataSource: DataSource)
}

extension DataSourceable {
    func set(dataSource: DataSource) { self.dataSource = dataSource }
}

// MARK: - DataSource
protocol DataSource {}
