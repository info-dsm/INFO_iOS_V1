import INFOKit
import UIKit
import Then
import SnapKit

public class TapBarViewController : UITabBarController {
    
    public var factory: ModuleFactoryInterface!
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeVC = UINavigationController(rootViewController: UIViewController())
        let tabOneBarItem = UITabBarItem(title: "회사목록",
                                         image: INFOKitAsset.Assets.companyList.image,
                                         tag: 1)
        
        homeVC.tabBarItem = tabOneBarItem
        
        let boardVC = UINavigationController(rootViewController: UIViewController())
        let tabTwoBarItem2 = UITabBarItem(title: "모집공고",
                                          image: INFOKitAsset.Assets.recruitmentAnnouncement.image,
                                          tag: 2)
        boardVC.tabBarItem = tabTwoBarItem2
        
        let tendinousVC = UINavigationController(rootViewController: UIViewController())
        let tabThrBarItem3 = UITabBarItem(title: "공지사항",
                                          image: INFOKitAsset.Assets.announcement.image,
                                          tag: 3)
        
        tendinousVC.tabBarItem = tabThrBarItem3
        
        let reviewVC = UINavigationController(rootViewController: UIViewController())
        let tabFouBarItem4 = UITabBarItem(title: "내정보",
                                          image: INFOKitAsset.Assets.myPage.image,
                                          tag: 4)
        
        reviewVC.tabBarItem = tabFouBarItem4
        
        
        self.tabBar.tintColor = INFOKitAsset.Colors.mainColor.color
        self.tabBar.unselectedItemTintColor = INFOKitAsset.Colors.thinGrayColor.color
        self.viewControllers = [homeVC, boardVC, tendinousVC, reviewVC]
        self.tabBar.backgroundColor = .white

        
    }
}
