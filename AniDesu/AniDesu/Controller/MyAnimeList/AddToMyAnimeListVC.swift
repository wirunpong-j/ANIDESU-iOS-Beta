import UIKit
import Eureka

class AddToMyAnimeListVC: FormViewController {
    
    // Constance
    let HIGH_SCORE = 10
    let ALL_STATUS = [StatusType.PLAN_TO_WATCH.rawValue, StatusType.WATCHING.rawValue,
                      StatusType.COMPLETED.rawValue, StatusType.DROPPED.rawValue]
    
    // Variables
    var myAnimeList: MyAnimeList?
    
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
                $0.value = myAnimeList?.status
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "Progress"
                $0.title = "Progress (EP)"
                $0.options = numberArray(end: (myAnimeList?.anime?.total_episodes)!)
                $0.value = (myAnimeList?.progress)!
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "Score"
                $0.title = "Score"
                $0.options = numberArray(end: HIGH_SCORE)
                $0.value = (myAnimeList?.score)!
            }
            +++ Section("Notes (Optional)")
            <<< TextAreaRow() {
                $0.tag = "Notes"
                $0.placeholder = "Write your notes"
                $0.value = (myAnimeList?.note)!
            }
            +++ Section()
            <<< ButtonRow ("Delete") {
                $0.title = "Delete"
            }.cellUpdate { cell, row in
                cell.isHidden = !(self.myAnimeList?.isAdded)!
                cell.textLabel?.textColor = UIColor.red
            }.onCellSelection { cell, row in
                let alert = UIAlertController(title: "Alert", message: "Are you sure you want to remove this form your list ?", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    self.removeThisAnimeFormList()
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        
        if (myAnimeList?.isAdded)! {
            navigationItem.title = "Edit: \((myAnimeList?.anime?.title_romaji)!)"
        } else {
            navigationItem.title = "Add: \((myAnimeList?.anime?.title_romaji)!)"
        }
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 20
        
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
        
        var newMyAnime = MyAnimeList(animeID: (myAnimeList?.animeID)!, score: score, progress: progress, note: notes, status: status)
        
        if (myAnimeList?.isAdded)! {
            newMyAnime.key = myAnimeList?.key
            UserDataService.instance.updateMyAnimeList(myAnimeList: newMyAnime) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            UserDataService.instance.addMyAnimeList(myAnimeList: newMyAnime) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func removeThisAnimeFormList() {
        UserDataService.instance.removeAnimeFormMyList(myAnimeList: myAnimeList!) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
}
