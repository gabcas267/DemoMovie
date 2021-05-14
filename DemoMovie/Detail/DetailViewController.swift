
import UIKit
import WebKit

protocol DetailViewControllerProtocol: class{
    func loadMovieDetail()
    func loadMovieVideo(withURL url: URL)
}

class DetailViewController: UIViewController{
    
    @IBOutlet weak var webViewVideo         : WKWebView!
    @IBOutlet weak var lblTitle             : UILabel!
    @IBOutlet weak var lblOverview          : UILabel!
    @IBOutlet weak var lblReleaseDate       : UILabel!
    @IBOutlet weak var lblVoteAverage       : UILabel!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    
    var presenter: DetailPresenterProtocol?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.navigationItem.title = "Detail Movie"
        webViewVideo.navigationDelegate = self
        presenter?.getMovieDetail()
        presenter?.getMovieVideo()
        
    }
    
}

extension DetailViewController: DetailViewControllerProtocol{
    
    func loadMovieDetail() {
        lblTitle.text = presenter?.getMovieTitle()
        lblOverview.text = presenter?.getMovieOverview()
        lblReleaseDate.text = presenter?.getMovieReleaseDate()
        lblVoteAverage.text = presenter?.getMovieVoteAverage()
    }
    
    func loadMovieVideo(withURL url: URL) {
        self.webViewVideo.load(URLRequest(url: url))
    }

}

extension DetailViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 1) {
            self.webViewVideo.alpha = 1
        }
    }
    
}
