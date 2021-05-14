
import UIKit

protocol DetailInteractorProtocol: class {
    
    @discardableResult
    func getMovieDetail(byId idMovie: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) -> URLSessionTask
    @discardableResult
    func getMovieVideo(byId idMovie: Int, completion: @escaping (Result<MovieVideo, Error>) -> Void) -> URLSessionTask
    
}

class DetailInteractor {
    
}

extension DetailInteractor: DetailInteractorProtocol {
    
    @discardableResult
    func getMovieDetail(byId idMovie: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) -> URLSessionTask {
        return WebServiceManager.get(urlString: WebServicesURL.detailMovie(idMovie)) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                    completion(.success(movieDetail))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    func getMovieVideo(byId idMovie: Int, completion: @escaping (Result<MovieVideo, Error>) -> Void) -> URLSessionTask {
        return WebServiceManager.get(urlString: WebServicesURL.videoMovie(idMovie)) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movieVideos = try decoder.decode(MovieVideos.self, from: data)
                    completion(.success(movieVideos.listOfVideos.first!))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
