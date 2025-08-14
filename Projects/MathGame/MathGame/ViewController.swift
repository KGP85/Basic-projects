//
//  ViewController.swift
//  MathGame
//
//  Created by Даниил Муратович on 01.07.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    private let bestScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Лучший: 0"
        label.textColor = .label
        return label
    }()
    
    private let lastScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Последний: 0"
        label.textColor = .label
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = "2 + 2"
        label.textColor = .label
        return label
    }()
    
    private let answerTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.placeholder = "Ответ"
        tf.textColor = .label
        tf.backgroundColor = .secondarySystemBackground
        return tf
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Проверить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let levelControl: UISegmentedControl = {
        let items = ["+", "-", "×", "÷"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let currentScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "Текущий счет: 0"
        label.textColor = .secondaryLabel
        return label
    }()
    
    // MARK: - Game Variables
    private var currentScore = 0
    private var bestScore: Int {
        get { UserDefaults.standard.integer(forKey: "bestScore") }
        set {
            UserDefaults.standard.set(newValue, forKey: "bestScore")
            bestScoreLabel.text = "Лучший: \(newValue)"
        }
    }
    
    private var lastScore: Int {
        get { UserDefaults.standard.integer(forKey: "lastScore") }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastScore")
            lastScoreLabel.text = "Последний: \(newValue)"
        }
    }
    
    private var currentAnswer: Int = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadScores()
        generateNewQuestion()
        
        checkButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        levelControl.addTarget(self, action: #selector(levelChanged), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        if #available(iOS 13.0, *) {
                levelControl.selectedSegmentTintColor = .systemBlue
            }
            levelControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            levelControl.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [
            bestScoreLabel, lastScoreLabel, levelControl,
            questionLabel, answerTextField, checkButton, currentScoreLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            answerTextField.heightAnchor.constraint(equalToConstant: 50),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            levelControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Game Logic
    private func generateNewQuestion() {
        let operation = levelControl.selectedSegmentIndex
        
        switch operation {
        case 0: // Сложение
            let a = Int.random(in: 1...1_000)
            let b = Int.random(in: 1...1_000)
            currentAnswer = a + b
            questionLabel.text = "\(a) + \(b)"
            
        case 1: // Вычитание
            let a = Int.random(in: 1...1_000)
            let b = Int.random(in: 1...a)
            currentAnswer = a - b
            questionLabel.text = "\(a) - \(b)"
            
        case 2: // Умножение
            let a = Int.random(in: 1...30)
            let b = Int.random(in: 30...100)
            currentAnswer = a * b
            questionLabel.text = "\(a) × \(b)"
            
        case 3: // Деление
            let b = Int.random(in: 1...100)
            let result = Int.random(in: 1...100)
            let a = b * result
            currentAnswer = result
            questionLabel.text = "\(a) ÷ \(b)"
            
        
        default: break
            
        }
        
        answerTextField.text = ""
    }
    
    @objc private func checkAnswer() {
        guard let text = answerTextField.text,
              let userAnswer = Int(text) else {
            showAlert(title: "Ошибка", message: "Введите число")
            return
        }
        
        if userAnswer == currentAnswer {
            currentScore += 1
            currentScoreLabel.text = "Текущий счет: \(currentScore)"
            generateNewQuestion()
        } else {
            gameOver()
        }
    }
    
    private func gameOver() {
        lastScore = currentScore
        
        if currentScore > bestScore {
            bestScore = currentScore
        }
        
        showAlert(title: "Игра окончена",
                 message: "Правильный ответ: \(currentAnswer)\nВаш счет: \(currentScore)")
        
        currentScore = 0
        currentScoreLabel.text = "Текущий счет: \(currentScore)"
        generateNewQuestion()
    }
    
    @objc private func levelChanged() {
        currentScore = 0
        currentScoreLabel.text = "Текущий счет: \(currentScore)"
        generateNewQuestion()
    }
    
    // MARK: - Data Management
    private func loadScores() {
        bestScoreLabel.text = "Лучший: \(bestScore)"
        lastScoreLabel.text = "Последний: \(lastScore)"
    }
    
    // MARK: - Helpers
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Обновляем цвета при смене темы
        updateColorsForCurrentTheme()
    }

    private func updateColorsForCurrentTheme() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        
        // Пример кастомизации для темной темы
        if isDarkMode {
            checkButton.backgroundColor = .systemIndigo
        } else {
            checkButton.backgroundColor = .systemBlue
        }
        
        view.backgroundColor = .systemBackground
    }
}

