import UIKit
import Process

//struct ChangePasswordCreator: Creator {
//  let gate: Gate
//
//  func build(state: ChangePasswordState) -> UIViewController {
//    let vc = ChangePasswordViewController()
//
//    vc.output = ChangePasswordOutput(
//      close: {
//        gate.transition(to: state.cancel())
//      }, submit: { password async in
//        gate.transition(to: await state.submit(password: password))
//      })
//
//    return vc
//  }
//}
