//
//  SurveyTaskVC.swift
//  test
//
//  Created by Brenden West on 6/14/15.
//


import UIKit
import ResearchKit


class SurveyTaskVC: ORKTaskViewController, ORKTaskResultSource {

    // ORKTaskResultSource
    
    func stepResultForStepIdentifier(stepIdentifier: String) -> ORKStepResult? {
        var stepResults = [ORKQuestionResult]()
        if stepIdentifier == "Q1" {
            var questionDefault = ORKChoiceQuestionResult(identifier: stepIdentifier)
            questionDefault.choiceAnswers = ["1"]
            stepResults.append(questionDefault)
        }
        
        var defaults = ORKStepResult(stepIdentifier: stepIdentifier, results: stepResults)
        
        return defaults
    }

    
}