//
//  StoryboardLiterals.swift
//  Core
//
//  Created by 박준하 on 2023/04/17.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import UIKit

public enum Storyboards: String {
    case sample = "Sample"
}

extension UIStoryboard{
    static func list(_ name : Storyboards) -> UIStoryboard{
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }
}

