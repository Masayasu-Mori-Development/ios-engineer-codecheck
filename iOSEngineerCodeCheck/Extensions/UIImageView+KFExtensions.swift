//
//  UIImageView+KFExtensions.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        kf.setImage(with: url)
    }
}
