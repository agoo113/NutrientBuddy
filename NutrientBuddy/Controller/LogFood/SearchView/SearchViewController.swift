//
//  SearchViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 18/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit
import Speech

class SearchViewController: UIViewController, SFSpeechRecognizerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: get database and filtered data
    var database: [FoodInfo] = []
    var filteredData: [String] = []
    var searchFood: String = ""
    var codeDict: [String: [Int]] = [:]
    var allWords:[String] = []
    var food:[String:String] = [:]
    var typeOfMeal: String = ""
    
    //MARK: pass to categoty view controller
    var catDict: [String:[String]] = [:]
    var catCategories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchButton.setTitle("\(#imageLiteral(resourceName: "searchView")) Search", for: .normal)
        //search bar
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        searchBar.setImage(#imageLiteral(resourceName: "Record"), for: UISearchBarIcon.bookmark, state: UIControlState.normal)
        //speech
        speechRecognizer?.delegate = self
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            OperationQueue.main.addOperation {
                switch authStatus{
                case .authorized:
                    print("GJ: user authorized speech recognition")
                case .denied:
                    self.searchBar.showsBookmarkButton = false
                    print("GJ: user denied to speech recognition")
                case .restricted:
                    self.searchBar.showsBookmarkButton = false
                    print("GJ: speech recognition restricted on the device")
                case .notDetermined:
                    self.searchBar.showsBookmarkButton = false
                    print("GJ: speech recognition not yet authorized")
                }
            }
        }
        textView.isEditable = false
    }
    
    //MARK: record and speech recognizer
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available{
            searchBar.showsBookmarkButton = true
        }else{
            searchBar.showsBookmarkButton = false
        }
    }
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-UK"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    // Called when record button is tapped
    func startRecording(){
        if recognitionTask != nil{
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        }catch{
            print("audioSession properties weren't set because of an error")
        }
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else{
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest")
        }
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: {(result, error) in
            var isFinal = false //if recognition is final
            if result != nil{
                self.textView.text = result?.bestTranscription.formattedString //textView as result of recognition
                self.searchBar.text = result?.bestTranscription.formattedString //searchbar as result of recognition
                isFinal = (result?.isFinal)!
            }
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        })
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){(buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do{
            try audioEngine.start()
        }catch{
            print("AudioEngine couldn't start because of an error")
        }
        
        textView.text = "Say something, I am listening!"
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //record button
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if audioEngine.isRunning{
            textView.text = "Finished Recording!"
            searchBar.setImage(#imageLiteral(resourceName: "Record"), for: UISearchBarIcon.bookmark, state: UIControlState.normal)
            audioEngine.stop()
            recognitionRequest?.endAudio()
        }
        else{
            searchBar.setImage(#imageLiteral(resourceName: "Recording"), for: UISearchBarIcon.bookmark, state: UIControlState.normal)
            textView.text = "Say something, I am listening!"
            startRecording()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if debugSearch {
            print("GJ: cancel button clicked on the search bar search view")
        }
        searchBar.text?.removeAll()
        textView.text = "Cancelled speech search! \n"
        searchBar.showsCancelButton = false
        textView.text.append("Finished Recording!")
        searchBar.setImage(#imageLiteral(resourceName: "Record"), for: UISearchBarIcon.bookmark, state: UIControlState.normal)
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }

    
    //MARK: searchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        if (searchBar.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Search Bar is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            textView.text = "Please search for the food item..."
        }
        
        startActivityIndicator(activityIndicator: activityIndicator)
        let searchItem = searchBar.text!
        DispatchQueue.global(qos: .background).async {
            self.searchForFoodItems(searchText: searchItem)
            DispatchQueue.main.async {
                self.stopActivityIndicator(activityIndicator: activityIndicator)
            }
        }
        
        textView.text = "Start searching for \(searchFood)..."
        searchBar.endEditing(true)
    }
    
    func startActivityIndicator(activityIndicator: UIActivityIndicatorView) {
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        
    }
    func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        
            UIApplication.shared.endIgnoringInteractionEvents()
            activityIndicator.stopAnimating()
        
    }
    
    
    /* search button deleted
    //search for food items
    @IBAction func searchedButtonClicked(_ sender: UIButton) {
        searchForFoodItems()
        textView.text = "Start searching for \(searchFood)..."
        searchBar.endEditing(true)
    }
    */
    private func searchForFoodItems(searchText: String) {
        //search for food
        filteredData.removeAll(keepingCapacity: false)
        
        let searchFood = processSpeechSearch(searchBarText: searchText)
        filteredData = BagOfWord().searchItem(searchFood: searchFood, codeDict: codeDict, allWords: allWords)
        if filteredData.count != 0{
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.textView.text = "Here are the searched results for \(searchFood)"
            }
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Food item is not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.textView.text = "Sorry the item you searched is not found, please browse from the database."
            }
        }
    }
    
    //MARK: process speech search
    func processSpeechSearch(searchBarText: String) -> String{
        food = NaturalLanguageProcess().findInformation(speech: searchBarText)
        if ((food["Noun"]! == "") && (food["Determiner"]! == "")) {
            let lowerCaseText = searchBarText.lowercased()
            DispatchQueue.main.async {
                self.textView.text = "Searching for \(lowerCaseText)..."
            }
            
            return lowerCaseText
        }
        else{
            if (food["Determiner"]! == "") {
                DispatchQueue.main.async {
                    self.textView.text = "You have eaten: "
                    self.textView.text.append(" ")
                    self.textView.text.append(self.food["Noun"]!)
                    self.textView.text.append("\nSearching for \(self.food["Noun"]!)...")
                    self.textView.text = "You can also tell me what you have eaten and how much to log in quicker"
                }
                
            }
            else{
                DispatchQueue.main.async {
                    self.textView.text = "You have eaten: "
                    self.textView.text.append(self.food["Determiner"]!)
                    self.textView.text.append(" ")
                    self.textView.text.append(self.food["Noun"]!)
                    self.textView.text.append("\nSearching for \(self.food["Noun"]!)...")
                }
            }
            return food["Noun"]!
        }
    }
    
    //MARK: table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "speechSearchResults")
        cell?.textLabel?.text = filteredData[indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFoodInfo" {
            var selectedRowIndex = self.tableView.indexPathForSelectedRow
            let foodInformationTableViewController: FoodInformationTableViewController = segue.destination as! FoodInformationTableViewController
            var item: String = ""
            item = filteredData[(selectedRowIndex?.row)!].replacingOccurrences(of: " ", with: "_")
            
            let strutArray = database.filter{ $0.Food_Name == item }
            foodInformationTableViewController.selectedFoodInfo = strutArray[0]
            foodInformationTableViewController.typeOfMeal = self.typeOfMeal
        }
        
        if segue.identifier == "loadDatabase" {
            let categoryViewController: CategoryViewController = segue.destination as! CategoryViewController
            categoryViewController.categories = catCategories
            categoryViewController.database = database
            categoryViewController.dict = catDict
            categoryViewController.typeOfMeal = self.typeOfMeal
        }
        
        
    }
}
