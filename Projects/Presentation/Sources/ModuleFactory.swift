import Foundation
import Presentation
//import Network

public class ModuleFactory {
    public static let shared = ModuleFactory()
    private init() { }
}

extension ModuleFactory: ModuleFactoryInterface {
    public func testVC() -> Presentation.ViewController2 {
        let vc = ViewController2()
        
        return vc
    }
    
    public func makeVC() -> Presentation.ViewController2 {
        let vc = ViewController2()
        
        return vc
    }
}
