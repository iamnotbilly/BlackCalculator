import SwiftUI

struct ContentView: View {
    let btnCal: [[CalculatorService]] = [
        [.clear, .percent, .del, .divide],
        [.seven, .eigth, .nine, .multi],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .sum],
        [.dots, .zero, .equal]
    ]
    let operators: [String] = ["/", "*", "-", "+"]
    @State var value: String = "0"
    @State var calValue: String = " "
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Spacer()
                    Text(calValue)
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                    
                }                 .padding(.horizontal, 15)
                HStack{
                    Spacer()
                    Text(value)
                        .font(.system(size: 65, weight: .bold, design: .rounded))
                    
                }
                .padding(.horizontal, 20)
                ForEach(btnCal, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self ) {
                            item in
                            Button {
                                tapBtn(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40, weight: .semibold, design: .monospaced))
                                    .foregroundStyle(.white).opacity(0.8)
                                    .frame(width: self.BtnWidth(item: item), height: self.BtnHeight(), alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 40.0)
                                        .fill(item.btnColor)
                                        .opacity(0.9)
                                    )
                            }
                        }
                    } .padding(.bottom, 3)
                }
            } .navigationTitle("Black Calculator")
        } .preferredColorScheme(.dark)
    }
    func BtnWidth(item: CalculatorService) -> CGFloat {
        if item == .equal {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func BtnHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func tapBtn(button: CalculatorService) {
        switch button {
        case .clear:
            self.calValue = " "
            self.value = "0"
        case .del:
            if(calValue.count == 1) {
                calValue = " "
            } else {
                calValue = String(calValue.dropLast())
            }
        case .equal:
            value = calResult()
        default:
            if(self.calValue == " ") {
                calValue = button.rawValue
            }
            else {
                calValue += button.rawValue
            }
        }
    }
    
    func invalidInput() -> Bool {
        let last = String(calValue.last!)
        if operators.contains(last) || calValue == " "{
            return false
        } else {
            return true
        }
    }

    func calResult() -> String {
        if invalidInput() {
            let working = calValue.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: working)
            guard let result = expression.expressionValue(with: nil, context: nil) as? Double else {
                return "ERROR"
            }
            let numberFormatter = NumberFormatter()
                numberFormatter.minimumFractionDigits = 0
                numberFormatter.maximumFractionDigits = 5
                return numberFormatter.string(from: NSNumber(value: result)) ?? "\(result)"
        }
        return "ERROR"
    }
}

#Preview {
    ContentView()
}
