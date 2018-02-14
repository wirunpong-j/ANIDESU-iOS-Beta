import UIKit
import Tabman
import Pageboy

class MyAnimeListMenuVC: TabmanViewController, PageboyViewControllerDataSource {

    // Constance
    let ALL_STATUS = [StatusType.PLAN_TO_WATCH, StatusType.WATCHING,
                      StatusType.COMPLETED, StatusType.DROPPED]
    
    // Variables
    var viewControllers = [UIViewController]()
    var allData = [MyAnimeList]()
    var planToWatch = [MyAnimeList]()
    var watching = [MyAnimeList]()
    var completed = [MyAnimeList]()
    var dropped = [MyAnimeList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearData()
        UserDataService.instance.fetchMyAnimeList { (allData) in
            self.allData = allData!
            self.splitAnimeStatusType()
        }
    }
    
    private func splitAnimeStatusType() {
        for myAnimeList in allData {
            switch myAnimeList.status {
                case StatusType.PLAN_TO_WATCH.rawValue:
                    planToWatch.append(myAnimeList)
                case StatusType.WATCHING.rawValue:
                    watching.append(myAnimeList)
                case StatusType.COMPLETED.rawValue:
                    completed.append(myAnimeList)
                case StatusType.DROPPED.rawValue:
                    dropped.append(myAnimeList)
                default:
                    break
            }
        }
        
        let planToWatchVC = self.getMyAnimeListVC(myAnimeList: self.planToWatch)
        let watchingVC = self.getMyAnimeListVC(myAnimeList: self.watching)
        let completedVC = self.getMyAnimeListVC(myAnimeList: self.completed)
        let droppedVC = self.getMyAnimeListVC(myAnimeList: self.dropped)
        
        self.viewControllers = [planToWatchVC, watchingVC, completedVC, droppedVC]
        self.reloadPages()
    }
    
    private func clearData() {
        planToWatch.removeAll()
        watching.removeAll()
        completed.removeAll()
        dropped.removeAll()
    }
    
    private func getMyAnimeListVC(myAnimeList: [MyAnimeList]) -> MyAnimeListVC {
        let myAnimeListVC = self.storyboard?.instantiateViewController(withIdentifier: "MyAnimeListVC") as? MyAnimeListVC
        myAnimeListVC?.allMyAnimeList = myAnimeList
        return myAnimeListVC!
    }
    
    private func setUpView() {
        // configure the bar
        self.bar.items = [Item(title: StatusType.PLAN_TO_WATCH.rawValue),
                          Item(title: StatusType.WATCHING.rawValue),
                          Item(title: StatusType.COMPLETED.rawValue),
                          Item(title: StatusType.DROPPED.rawValue)]
        
        self.bar.style = .scrollingButtonBar
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            
            // customize appearance here
            appearance.state.selectedColor = #colorLiteral(red: 0.2648853064, green: 0.8780197501, blue: 0.07720620185, alpha: 1)
            appearance.state.color = UIColor.white
            appearance.indicator.color = #colorLiteral(red: 0.2648853064, green: 0.8780197501, blue: 0.07720620185, alpha: 1)
            appearance.indicator.lineWeight = .thick
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
