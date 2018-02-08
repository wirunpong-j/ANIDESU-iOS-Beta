import UIKit
import Eureka

class AddToMyAnimeListVC: FormViewController {
    
    // Constance
    let HIGH_SCORE = 10
    let ALL_STATUS = [StatusType.PLAN_TO_WATCH.rawValue, StatusType.WATCHING.rawValue,
                      StatusType.COMPLETED.rawValue, StatusType.DROPPED.rawValue]
    
    // Variables
    var myAnime: MyAnimeList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setForm()
    }
    
    func setForm() {
        
        form +++ Section("Add To My Anime List *")
            <<< PickerInputRow<String>() {
                $0.tag = "Status"
                $0.title = "Status"
                $0.options = ALL_STATUS
                $0.value = myAnime?.status
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "Progress"
                $0.title = "Progress (EP)"
                $0.options = numberArray(end: (myAnime?.anime?.total_episodes)!)
                $0.value = 0
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "Score"
                $0.title = "Score"
                $0.options = numberArray(end: HIGH_SCORE)
                $0.value = 0
            }
            +++ Section("Notes (Optional)")
            <<< TextAreaRow() {
                $0.tag = "Notes"
                $0.placeholder = "Write your notes"
            }
            +++ Section()
            <<< ButtonRow ("Delete") {
                $0.title = "Delete"
            }.cellUpdate { cell, row in
                cell.isHidden = false
                cell.textLabel?.textColor = UIColor.red
            }.onCellSelection { cell, row in
                print("eiei")
            }
        
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 20
        navigationItem.title = "Add: \((myAnime?.anime?.title_romaji)!)"
    }
    
    private func numberArray(end: Int) -> [Int] {
        var numbers = [Int]()
        for num in 0...end {
            numbers.append(num)
        }
        
        return numbers
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let result = form.values()
        let status = result["Status"] as? String ?? ""
        let progress = result["Progress"] as? Int ?? 0
        let score = result["Score"] as? Int ?? 0
        let notes = result["Notes"] as? String ?? ""
        
        let newMyAnime = MyAnimeList(animeID: (myAnime?.animeID)!, score: score, progress: progress, note: notes, status: status)
        
        UserDataService.instance.addMyAnimeList(myAnimeList: newMyAnime) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
}
