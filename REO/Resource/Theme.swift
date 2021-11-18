//
//  Theme.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import SwiftUI

struct Theme {
    var font: CustomFont
}

protocol CustomFont {
    func regular(size: CGFloat) -> Font
    func bold(size: CGFloat) -> Font
}

struct SystemFont: CustomFont {
    func regular(size: CGFloat) -> Font {
        Font.custom("Helvetica-Bold", size: size)
    }
    
    func bold(size: CGFloat) -> Font {
        Font.custom("Helvetica", size: size)
    }
}

extension Theme {
    static var global: Theme {
        .init(font: SystemFont())
    }
}
