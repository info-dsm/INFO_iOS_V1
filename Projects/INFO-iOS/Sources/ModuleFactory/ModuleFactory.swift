import Foundation
import Presentation

public class ModuleFactory {
    public static let shared = ModuleFactory()
    private init() { }
}

extension ModuleFactory: ModuleFactoryInterface {
    public func makeVC() -> Presentation.ViewController2 {
        let vc = ViewController2()
        
        return vc
    }
    
    public func loginVC() -> Presentation.LoginViewController {
        let loginVC = LoginViewController()
        
        return loginVC
    }
}
