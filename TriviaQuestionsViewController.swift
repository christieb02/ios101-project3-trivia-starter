//
//  TriviaQuestionsViewController.swift
//  Trivia
//
//  Created by Christie beaubrun on 10/6/23.
//

import UIKit

class TriviaQuestionsViewController: UIViewController
{
    
    @IBOutlet weak var Answer4Button: UIButton!
    @IBOutlet weak var Answer3Button: UIButton!
    @IBOutlet weak var Answer2Button: UIButton!
    @IBOutlet weak var Answer1Button: UIButton!
    @IBOutlet weak var TriviaQuestionLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    
    // Model Structure
    struct TriviaQuestion {
        let category: String
        let question: String
        let choices: [String]
        let correctChoiceIndex: Int
    }

    // Sample Data
    var questions: [TriviaQuestion] = [
        TriviaQuestion(category: "Science", question: "Which planet is known as the Red Planet?", choices: ["Mars", "Venus", "Mercury", "Saturn"], correctChoiceIndex: 0),
        TriviaQuestion(category: "Geography", question: "What's the capital of Spain?", choices: ["Berlin", "London", "Madrid", "Barcelona"], correctChoiceIndex: 2),
        TriviaQuestion(category: "Coding", question: "What's the best Programming Language?", choices: ["Java", "Swift", "C", "Python"], correctChoiceIndex: 1)
    ]
    
    private var currQuestionIndex = 0
    private var numCorrectQuestions = 0
        
    override func viewDidLoad()
    {

            super.viewDidLoad()
            displayQuestion()
    }
    
    private func displayQuestion() {
            let question = questions[currQuestionIndex]
            
            CategoryLabel.text = "Category: " + question.category
            TriviaQuestionLabel.text = question.question
            QuestionNumberLabel.text = "Question: \(currQuestionIndex + 1)/\(questions.count)"
            
            let answerButtons = [Answer1Button, Answer2Button, Answer3Button, Answer4Button]
            for (index, button) in answerButtons.enumerated() {
                button?.setTitle(question.choices[index], for: .normal)
                button?.tag = index // Set the tag for each button
            }
        }
        
        private func isCorrectAnswer(_ answerIndex: Int) -> Bool {
            return questions[currQuestionIndex].correctChoiceIndex == answerIndex
        }
        
        private func updateToNextQuestion(answerIndex: Int) {
            if isCorrectAnswer(answerIndex) {
                numCorrectQuestions += 1
            }
            currQuestionIndex += 1
            guard currQuestionIndex < questions.count else {
                showFinalScore()
                return
            }
            displayQuestion()
        }

        private func showFinalScore() {
            let alert = UIAlertController(title: "Quiz Finished", message: "Your score is \(numCorrectQuestions)/\(questions.count)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
                self.numCorrectQuestions = 0
                self.currQuestionIndex = 0
                self.displayQuestion()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true)
        }

        @IBAction func didTapAnswerButton(_ sender: UIButton) {
            updateToNextQuestion(answerIndex: sender.tag)
        }
}


