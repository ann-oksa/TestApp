//
//  ViewController.swift
//  TasteApp
//
//  Created by Anna Oksanichenko on 17.11.2020.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var transformation = TranslationService()
    var appState = AppState.shared
    
    @IBOutlet weak var changingLanguageController: UISegmentedControl!
    @IBOutlet weak var indicatorOfDownloading: UIActivityIndicatorView!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var wordInputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorOfDownloading.isHidden = true
        changingLanguageController.selectedSegmentIndex = 0
        appState.changeLanguageDependingOnTheIndex(index: changingLanguageController.selectedSegmentIndex)
        self.wordInputTextField.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func changeLanguage(_ sender: UISegmentedControl) {
        appState.changeLanguageDependingOnTheIndex(index: changingLanguageController.selectedSegmentIndex)
    }
    
    @IBAction func getTranslate(_ sender: UIButton) {
        guard let input = wordInputTextField.text,
              input.isEmpty == false else {
            return
        }
        indicatorOfDownloading.isHidden = false
        indicatorOfDownloading.startAnimating()
        
        self.transformation.transformTranslationToLanguage(text: input , targetLanguage: appState.targetLanguage, sourceLanguage: appState.sourceLanguage) { t in
            
            self.translationLabel.text = t
            self.indicatorOfDownloading.stopAnimating()
            self.indicatorOfDownloading.isHidden = true
            //
            
            if self.appState.targetLanguage == .russian {
                self.appState.createRecord(word1: self.wordInputTextField.text ?? "", word2: self.translationLabel.text ?? "")
            } else {
                self.appState.createRecord(word1: self.translationLabel.text ?? "", word2: self.wordInputTextField.text ?? "")
            }
            
        }
    }
    
    @IBAction func historyClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "toHistoryVC", sender: nil)
    }
    
    @IBAction func gameClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "toGameVC", sender: nil)
        
        
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
    }
    
    
}

