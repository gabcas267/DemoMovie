
import UIKit

protocol HomeViewControllerProtocol: class {
    func removeCellsTableView()
    func reloadTableView()
}

class HomeViewController: UIViewController{
    
    @IBOutlet weak var segmentedControl     : UISegmentedControl!
    @IBOutlet weak var tblvMovie            : UITableView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    
    var presenter: HomePresenterProtocol?
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .default
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar una pélicula"
        
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies"
        tblvMovie.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        presenter?.getMovies(by: .popular)
        
        let searchBar = searchController.searchBar
        searchController.searchResultsUpdater = self
        tblvMovie.tableHeaderView = searchBar
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func actionSelectMovieState(_ sender: UISegmentedControl) {
        if let movieState = MovieState(rawValue: sender.selectedSegmentIndex) {
            presenter?.getMovies(by: movieState)
            searchController.searchBar.text = ""
            searchController.dismiss(animated: true, completion: nil)
            activityIndicator.startAnimating()
        }
    }
    
}

extension HomeViewController: HomeViewControllerProtocol{
    
    func removeCellsTableView() {
        DispatchQueue.main.async {
            self.tblvMovie.reloadData()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tblvMovie.reloadSections(IndexSet(integer: 0), with: .automatic)
            self.activityIndicator.stopAnimating()
        }
    }
    
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            presenter?.getMoviesFiltered(by: searchText)
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.arrayMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell, let presenter = presenter else { return UITableViewCell() }
        cell.lblTitle.text = presenter.getTitleMovie(by: indexPath.row)
        cell.lblDescp.text = presenter.getDescMovie(by: indexPath.row)
        cell.imgMovie.imageFromServerURL(urlString: presenter.getImageMovie(by: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.dismiss(animated: true, completion: nil)
        guard let presenter = self.presenter else { return }
        presenter.actionGoToDetail(withId: presenter.getMovieId(by: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
