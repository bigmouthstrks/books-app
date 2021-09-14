//
//  File.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 07-09-21.
//

import UIKit
import Kingfisher

// MARK: - setImage
extension UIImageView {
    func setImage(with url: URL?) {
        guard let url = url else { return }
        self.kf.setImage(with: url)
    }
}
