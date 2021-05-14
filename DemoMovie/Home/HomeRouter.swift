
import UIKit

protocol HomeRouterProtocol: CommonRouterProtocol {
    func routeToDetail(withId idMovie: Int)
}

class HomeRouter {
    
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func getViewController() -> UIViewController {
        
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        vc.presenter = HomePresenter(view: vc,
                                     interactor: HomeInteractor(),
                                     router: self)
        return vc
    }
    
}

extension HomeRouter: HomeRouterProtocol {
    
    func routeToDetail(withId idMovie: Int) {
        let viewController = DetailRouter(navigation: navigation).getViewController(idMovie: idMovie)
        navigation.pushViewController(viewController, animated: true)
    }
    
}
