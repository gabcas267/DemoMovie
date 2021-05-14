
import UIKit

protocol HomePresenterProtocol: class {
    func actionGoToDetail(withId idMovie: Int)
    func getMovies(by movieState: MovieState)
    func getMoviesFiltered(by searchText: String)
    func arrayMoviesCount() -> Int
    func getTitleMovie(by index: Int) -> String
    func getDescMovie(by index: Int) -> String
    func getImageMovie(by index: Int) -> String
    func getMovieId(by index: Int) -> Int
}

class HomePresenter {
    
    private unowned let view: HomeViewControllerProtocol
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    
    private var arrayMovie = [Movie]()
    private var arrayMovieFiltered = [Movie]()
    private var dataTask : URLSessionTask?
    
    init(view: HomeViewControllerProtocol,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func actionGoToDetail(withId idMovie: Int) {
        router.routeToDetail(withId: idMovie)
    }
    
    func getMovies(by movieState: MovieState) {
        arrayMovie.removeAll()
        arrayMovieFiltered.removeAll()
        view.removeCellsTableView()
        self.dataTask != nil ? self.dataTask?.cancel() : nil
        self.dataTask = interactor.getMovies(withUrl: movieState.getUrlString()) { [weak self] (result) in
            switch result {
            case .success(let arrayMovie):
                self?.arrayMovie = arrayMovie
                self?.arrayMovieFiltered = arrayMovie
                self?.view.reloadTableView()
            case .failure(let error):
                self?.router.showAlertView(withMessage: error.localizedDescription)
            }
        }

    }
    
    func getMoviesFiltered(by searchText: String) {
        if searchText.count == 0 {
            arrayMovieFiltered = arrayMovie
        } else {
            arrayMovieFiltered = arrayMovie.filter { $0.title.contains(searchText) }
        }
        view.reloadTableView()
    }
    
    func arrayMoviesCount() -> Int {
        arrayMovieFiltered.count
    }
    
    func getTitleMovie(by index: Int) -> String {
        arrayMovieFiltered[index].title
    }
    
    func getDescMovie(by index: Int) -> String {
        arrayMovieFiltered[index].sinopsis
    }
    
    func getImageMovie(by index: Int) -> String {
        WebServicesURL.urlImages(arrayMovieFiltered[index].image)
    }
    
    func getMovieId(by index: Int) -> Int {
        arrayMovieFiltered[index].movieID
    }
    
}
