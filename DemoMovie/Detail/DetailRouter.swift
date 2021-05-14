
import UIKit

protocol DetailRouterProtocol: CommonRouterProtocol {
}

class DetailRouter {
    
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func getViewController(idMovie: Int) -> UIViewController {
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.presenter = DetailPresenter(view: vc,
                                       interactor: DetailInteractor(),
                                       router: self,
                                       idMovie: idMovie)
        return vc
    }
}

extension DetailRouter: DetailRouterProtocol {
    
}
