//
//  QuestionsViewController.swift
//  PersonalityQuiz
//
//  Created by SAVREEN KAUR on 17/03/18.
//  Copyright © 2018 SAVREEN KAUR. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    var questionIndex=0
    var AnswerChosen:[Answer]=[]
   
    
    @IBOutlet weak var questionLabel: UILabel!
        @IBOutlet weak var SingleStackView: UIStackView!
            @IBOutlet weak var singleButton1: UIButton!
            @IBOutlet weak var singleButton2: UIButton!
    
            @IBOutlet weak var singleButton3: UIButton!
            @IBOutlet weak var singleButton4: UIButton!
    
    
        @IBOutlet weak var MultipleStackView: UIStackView!
            @IBOutlet weak var multipleQuestion1: UILabel!
            @IBOutlet weak var mutlipleQuestion2: UILabel!
            @IBOutlet weak var multipleQuestion3: UILabel!
            @IBOutlet weak var mutlipleQuestion4: UILabel!
    
            @IBOutlet weak var switch1: UISwitch!
            @IBOutlet weak var switch2: UISwitch!
            @IBOutlet weak var switch3: UISwitch!
            @IBOutlet weak var switch4: UISwitch!
    
    
    @IBOutlet weak var RangedStackView: UIStackView!
            @IBOutlet weak var rangedLabel1: UILabel!
            @IBOutlet weak var rangedLabel2: UILabel!
            @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var questionProgressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers=questions[questionIndex].answer
        switch sender {
        case singleButton1:
            AnswerChosen.append(currentAnswers[0])
        case singleButton2:
            AnswerChosen.append(currentAnswers[1])
        case singleButton3:
            AnswerChosen.append(currentAnswers[2])
        case singleButton4:
            AnswerChosen.append(currentAnswers[3])
        
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed() {
        let currentAnswers=questions[questionIndex].answer
        
        if switch1.isOn{
            AnswerChosen.append(currentAnswers[0])
        }
        if switch2.isOn{
            AnswerChosen.append(currentAnswers[1])
        }
        if switch3.isOn{
            AnswerChosen.append(currentAnswers[2])
        }
        if switch4.isOn{
            AnswerChosen.append(currentAnswers[3])
        }
          nextQuestion()
    }
    @IBAction func rangedAnswerPressed() {
         let currentAnswers=questions[questionIndex].answer
        let index = Int(round(rangedSlider.value *
            Float(currentAnswers.count - 1)))
        AnswerChosen.append(currentAnswers[index])
        nextQuestion()
        
    }
    func updateUI(){
        SingleStackView.isHidden=true
        MultipleStackView.isHidden=true
        RangedStackView.isHidden=true
        navigationItem.title="Question #\(questionIndex+1)"
        let currentQuestion=questions[questionIndex]
        let currentAnswers=currentQuestion.answer
        let totalProgress=Float(questionIndex)/Float(questions.count)
        questionLabel.text=currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        
        }
    }
    func nextQuestion(){
        questionIndex+=1
        if(questions.count>questionIndex){
            updateUI()
        }
        else{
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    var questions:[Question]=[
        
        Question(text: "Which food do you like the most",
                 type: .single,
                 answer: [
                    Answer(text: "Chicken", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Corn", type: .turtle),
                    Answer(text: "Carrot", type: .rabbit)
            ]),
        Question(text: "Which activities do you enjoy?",
        type: .multiple,
        answer: [
        Answer(text: "Swimming", type: .turtle),
        Answer(text: "Sleeping", type: .cat),
        Answer(text: "Cuddling", type: .rabbit),
        Answer(text: "Eating", type: .dog)
        ]),
        Question(text: "How much do you enjoy car rides",
                 type: .ranged,
                 answer: [
                    Answer(text: "I love them", type: .dog),
                    
                    
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I hate them", type: .cat)
            ]),
        
    ]
    func updateSingleStack(using answer :[Answer]){
        SingleStackView.isHidden=false
        singleButton1.setTitle(answer[0].text, for: .normal)
        singleButton2.setTitle(answer[1].text, for: .normal)
        singleButton3.setTitle(answer[2].text, for: .normal)
        singleButton4.setTitle(answer[3].text, for: .normal)
    }
    func updateMultipleStack(using answer :[Answer]){
        MultipleStackView.isHidden=false
        switch1.isOn=false
        switch2.isOn=false
        switch3.isOn=false
        switch4.isOn=false
        multipleQuestion1.text=answer[0].text
        mutlipleQuestion2.text=answer[1].text
        multipleQuestion3.text=answer[2].text
        mutlipleQuestion4.text=answer[3].text
        
    }
    func updateRangedStack(using answer :[Answer]){
        RangedStackView.isHidden=false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text=answer.first?.text
        rangedLabel2.text=answer.last?.text
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="resultSegue"{
            let resultsViewController=segue.destination as! ResultsViewController
            resultsViewController.responses=AnswerChosen
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
