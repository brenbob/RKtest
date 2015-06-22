//
//  SurveyTaskVC.swift
//  test
//
//  Created by Brenden West on 6/14/15.
//


import UIKit
import ResearchKit


class SurveyTaskVC: ORKTaskViewController, ORKTaskResultSource, ORKStepViewControllerDelegate {

    // ORKTaskResultSource
    
    func stepResultForStepIdentifier(stepIdentifier: String) -> ORKStepResult? {
        var stepResults = [ORKQuestionResult]()
        if stepIdentifier == "Q1" {
            var questionDefault = ORKChoiceQuestionResult(identifier: stepIdentifier)
            questionDefault.choiceAnswers = ["1"]
            stepResults.append(questionDefault)
            
            let otherResult = ORKTextQuestionResult(identifier: "other")
            otherResult.answer = ""
            stepResults.append(otherResult)

        }
        
        var defaults = ORKStepResult(stepIdentifier: stepIdentifier, results: stepResults)
        
        return defaults
    }

    // MARK: ORKStepViewControllerDelegate
    
    override func stepViewControllerResultDidChange(stepViewController: ORKStepViewController) {
        
        let choiceResult = stepViewController.result!.results?.first as? ORKChoiceQuestionResult
        if choiceResult?.choiceAnswers?.first as? String == "1" {
                println("show text entry")
                showAlert("Please enter Other", message: "")
                //stepViewController.view.subviews[0].tableView
        }
        
    }
    
    func showAlert(title: String, message: String) {
        var alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Other"
        }

        let okAction = UIAlertAction(title: "Done", style: .Default) { (_) in
            let otherTextField = alertController.textFields![0] as! UITextField
            if otherTextField.text != "" {
                self.updateOther(otherTextField.text, stepViewController: self.currentStepViewController!)
            }
        }
        
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    

    func updateOther(text: String, stepViewController: ORKStepViewController) {
        
        var stepResults = stepViewController.result!.results
//        stepResults?.last?.answer = text
    }
    
}