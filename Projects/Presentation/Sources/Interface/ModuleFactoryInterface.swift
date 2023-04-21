import Foundation

public protocol ModuleFactoryInterface {
    func makeVC() -> ViewController2
    func loginVC() -> LoginViewController
}
