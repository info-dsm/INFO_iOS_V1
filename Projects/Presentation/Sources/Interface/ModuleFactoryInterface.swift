import Foundation

public protocol ModuleFactoryInterface {
    func loginVC() -> LoginViewController
    func signupVC() -> SignupViewController
}
