import Foundation
import SwiftUI

enum CalculatorService: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eigth = "8"
    case nine = "9"
    case sum = "+"
    case subtract = "-"
    case multi = "*"
    case divide = "/"
    case percent = "%"
    case dots = "."
    case equal = "="
    case clear = "AC"
    case del = "CE"
    var btnColor: Color {
        switch self {
        case .sum, .subtract, .multi, .divide:
            return Color.orange
        case .clear, .del, .percent: return Color.gray.opacity(0.9)
        case .equal: return Color.pink
        default: return Color.gray.opacity(0.3)
        }
    }
}


