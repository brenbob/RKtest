//
//  Survey.swift
//  test
//
//  Created by Brenden West on 6/14/15.
//

import UIKit
import ResearchKit

class SurveyVC: UIViewController, ORKTaskViewControllerDelegate  {
    
    /**
    When a task is completed, the `SurveyViewController` calls this closure
    with the created task.
    */
    var taskResultFinishedCompletionHandler: (ORKResult -> Void)?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startSurvey()
    }
    
    /**
    Start the survey as a RK task
    */
    func startSurvey() {
        
        let task = surveyTask
        
        let taskViewController = SurveyTaskVC(task: task, taskRunUUID: nil)
        
        // Make sure we receive events from `taskViewController`.
        taskViewController.delegate = self
        
        taskViewController.defaultResultSource = taskViewController

        // Assign a directory to store `taskViewController` output.
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String, isDirectory: true)

        self.presentViewController(taskViewController, animated: true, completion: nil)
        
    }
    
    /**
    Contruct the survey as a task with one step
    stepBeforeStep and stepAfterStep methods in DSOrderedTask determine which other steps to insert
    */
    var surveyTask: ORKOrderedTask {
        
        var steps = [AnyObject]()

        // Add a question step.
        var choices = [ORKTextChoice]()
        choices.append(ORKTextChoice(text: "YES", value: "1"))
        choices.append(ORKTextChoice(text: "NO", value: "0"))
        var format = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.SingleChoice, textChoices: choices)

        let questionStepTitle = "Are you happy?"
        let questionStep = ORKQuestionStep(identifier: "Q1", title: questionStepTitle, answer: format)
        questionStep.optional = false
        
        steps += [questionStep]

        return ORKOrderedTask(identifier: "testTask", steps: steps)
    }
    

    // MARK: ORKTaskViewControllerDelegate
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        println("didFinishWithReason")
        switch reason {
            
        case ORKTaskViewControllerFinishReason.Completed:
            println("completed")
        case ORKTaskViewControllerFinishReason.Failed:
            println("failed")
        case ORKTaskViewControllerFinishReason.Discarded:
            println("discarded")
        case ORKTaskViewControllerFinishReason.Saved:
            println("saved")
        }
        
        /*
        The `reason` passed to this method indicates why the task view
        controller finished: Did the user cancel, save, or actually complete
        the task; or was there an error?
        
        The actual result of the task is on the `result` property of the task
        view controller.
        */
        taskResultFinishedCompletionHandler?(taskViewController.result)
        
        self.dismissViewControllerAnimated(false, completion: nil )
        
    }
    
    
}