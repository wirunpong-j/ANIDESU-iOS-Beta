import UIKit
import Tabman
import Pageboy

class DiscoverAnimeMenuVC: TabmanViewController, PageboyViewControllerDataSource {
    
    var viewControllers = [UIViewController]()
    var winter = [Anime]()
    var spring = [Anime]()
    var fall = [Anime]()
    var summer = [Anime]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        setUpView()
        
        var responseCount = 0
        
        for season in [SeasonType.WINTER, SeasonType.SPRING, SeasonType.FALL, SeasonType.SUMMER] {
            AniListService.instance.fetchAnimeDataBySeason(season: season) { (animeList) in
                switch season {
                    case .WINTER:
                        self.winter = animeList!
                    case .SPRING:
                        self.spring = animeList!
                    case .FALL:
                        self.fall = animeList!
                    case .SUMMER:
                        self.summer = animeList!
                }
                responseCount += 1
                
                if responseCount >= 4 {
                    let winterDiscoveryVC = self.getDiscoverAnimeVC(anime: self.winter)
                    let springDiscoveryVC = self.getDiscoverAnimeVC(anime: self.spring)
                    let fallDiscoveryVC = self.getDiscoverAnimeVC(anime: self.fall)
                    let summerDiscoveryVC = self.getDiscoverAnimeVC(anime: self.summer)
                    
                    self.viewControllers = [winterDiscoveryVC, springDiscoveryVC, fallDiscoveryVC, summerDiscoveryVC]
                    self.reloadPages()
                }
            }
        }
        
    }
    
    private func getDiscoverAnimeVC(anime: [Anime]) -> DiscoverAnimeVC {
        let discoverAnimeVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverAnimeVC") as? DiscoverAnimeVC
        discoverAnimeVC?.allAnime = anime
        return discoverAnimeVC!
    }
    
    private func setUpView() {
        // configure the bar
        self.bar.items = [Item(title: "WINTER"),
                          Item(title: "SPRING"),
                          Item(title: "FALL"),
                          Item(title: "SUMMER")]
        
        self.bar.style = .scrollingButtonBar
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            
            // customize appearance here
            appearance.state.selectedColor = #colorLiteral(red: 0.2648853064, green: 0.8780197501, blue: 0.07720620185, alpha: 1)
            appearance.state.color = UIColor.white
            appearance.indicator.color = #colorLiteral(red: 0.2648853064, green: 0.8780197501, blue: 0.07720620185, alpha: 1)
            appearance.style.background = .solid(color: #colorLiteral(red: 0.1336952448, green: 0.1932881773, blue: 0.2481227517, alpha: 1))
            appearance.text.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
            appearance.layout.minimumItemWidth = 100
        })
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

}
