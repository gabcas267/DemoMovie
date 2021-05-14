
import UIKit

protocol DetailPresenterProtocol: class {
    func getMovieDetail()
    func getMovieVideo()
    func getMovieTitle() -> String?
    func getMovieOverview() -> String?
    func getMovieReleaseDate() -> String?
    func getMovieVoteAverage() -> String?
}

class DetailPresenter {
    
    private unowned let view: DetailViewControllerProtocol
    private let interactor: DetailInteractorProtocol
    private let router: DetailRouterProtocol
    private let idMovie: Int
    
    private var movieDetail : MovieDetail?
    
    init(view: DetailViewControllerProtocol,
         interactor: DetailInteractorProtocol,
         router: DetailRouterProtocol,
         idMovie: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.idMovie = idMovie
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func getMovieDetail() {
        interactor.getMovieDetail(byId: self.idMovie) { [weak self] (result) in
            switch result {
            case .success(let movieDetail):
                self?.movieDetail = movieDetail
                self?.view.loadMovieDetail()
            case .failure(let error):
                self?.router.showAlertView(withMessage: error.localizedDescription)
            }
        }
    }
    
    func getMovieVideo() {
        interactor.getMovieVideo(byId: self.idMovie) { [weak self] (result) in
            switch result {
            case .success(let movieVideo):
                guard let url = URL(string: WebServicesURL.youtubeURl(movieVideo.key)) else { return }
                self?.view.loadMovieVideo(withURL: url)
            case .failure(let error):
                self?.router.showAlertView(withMessage: error.localizedDescription)
            }
        }
    }
    
    func getMovieTitle() -> String? {
        movieDetail?.title
    }
    
    func getMovieOverview() -> String? {
        movieDetail?.overview
    }
    
    func getMovieReleaseDate() -> String? {
        movieDetail?.releaseDate
    }
    
    func getMovieVoteAverage() -> String? {
        "\(movieDetail?.voteAverage ?? 0.0)"
    }
    
}
