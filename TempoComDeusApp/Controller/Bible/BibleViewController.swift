//
//  BibleViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit
import CoreData
class BibleViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    var context: NSManagedObjectContext!
    var service: CoreDataService!
    let dataPicker = DataPicker.data()
    let cellId = "CellId"
    var bible: Bible?
    var verses = [Verse]()
    var actualChapter: Chapter? {
        didSet {
            updateUI()
        }
    }
    var widthTitleButtonConstraint: NSLayoutConstraint?
    var fonteSize: Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueAct
        button.setTitle("", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.accessibilityIdentifier = "titleButton"
        button.addTarget(self, action: #selector(showBooks), for: .touchUpInside)
        return button
    }()
    
    lazy var versionButton: UITextField = {
        let button = UITextField()
        button.backgroundColor = .blueAct
        button.text = ""
        button.textColor = .white
        button.tintColor = .clear
        button.textAlignment = .center
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setDimensions(width: 40, height: 30)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .backViewColor
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var leftSwipeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(leftSwipe), for: .touchUpInside)
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    lazy var rightSwipeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "right"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(rightSwipe), for: .touchUpInside)
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    lazy var picker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .backgroundColor
        pickerView.isUserInteractionEnabled = true
        return pickerView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsPersistence.shared.setupDefaultsValues()
        setContext()
        setupData()
        versionButton.delegate = self
        configureUI()
    }
    
    func setContext() {
        self.context = (UIApplication.shared.delegate as? AppDelegate)?.persistenceContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        service = CoreDataService(context)
    }
    
    func setupData() {
        let abbrev = UserDefaultsPersistence.shared.getDefaultAbbrev()
        let version = UserDefaultsPersistence.shared.getDefaultVersion()
        let chapter = UserDefaultsPersistence.shared.getDefaultChapter()
        self.bible = Bible(version: version, abbreviation: abbrev)
        if let bible = bible {
            self.actualChapter = Chapter(bible: bible, number: chapter)
        }
        setupVerses()
    }
    
    func setupVerses() {
        if let actualChapter = actualChapter {
            verses.removeAll()
            for (index, verse) in actualChapter.versicles.enumerated() {
                let isHighlighted = UserDefaultsPersistence.shared.isHighlighted(
                    abbreviation: actualChapter.abbreviation, chapterNumber: actualChapter.number,
                    verseNumber: index)
                let noteId = UserDefaultsPersistence.shared.getNoteId(
                    abbreviation: actualChapter.abbreviation,
                    chapterNumber: actualChapter.number, verseNumber: index)
              
                let verse = Verse(abbreviation: actualChapter.abbreviation,
                                  chapterNumber: actualChapter.number,
                                  verseNumber: index, verseText: verse,
                                  isHighlighted: isHighlighted, noteId: noteId)
                verses.append(verse)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fonteSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        updateUI()
    }
    
    // MARK: Selectors
    
    @objc func showBooks() {
        let livrosTableView = BooksTableViewController()
        livrosTableView.onDidSelectSection = { abbrev, chapter in
            self.didSelectSection(abbr: abbrev, chapter: chapter)
        }
        self.present(livrosTableView, animated: true)
    }
    
    func addGestures() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                leftSwipe()
            case .left:
                rightSwipe()
            default:
                break
            }
        }
    }
    
    // next
    @objc func rightSwipe() {
        guard let bible = self.bible, let actualChapter = self.actualChapter else { return }
        
        if let actualBook = bible.actualBook,
                  let nextChapter = actualBook.getNextChapter(actualChapter: actualChapter.number) {
            
            self.actualChapter = Chapter(bible: bible, number: nextChapter)
        
        } else if let nextBook = bible.getNextBook(),
                  let abbreviation = nextBook.abbreviation["pt"] {
                   
                   bible.updateActualBook(abbreviation: abbreviation)
                   self.actualChapter = Chapter(bible: bible, number: 0)
        }
        
        if tableView.numberOfSections > 0 && tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    // voltar
    @objc func leftSwipe() {
        guard let bible = bible, let actualChapter = actualChapter else { return }
        
        if let actualBook = bible.actualBook,
                  let previewChapter = actualBook.getPreviewChapter(actualChapter: actualChapter.number) {
            self.actualChapter = Chapter(bible: bible, number: previewChapter)

        } else if let previewBook = bible.getPreviewBook(),
                  let abbreviation = previewBook.abbreviation["pt"] {
                   
            bible.updateActualBook(abbreviation: abbreviation)
            let actualChapterNumber = previewBook.totalChapters ?? 0
            
            self.actualChapter = Chapter(bible: bible, number: actualChapterNumber - 1)
        }
        
        if tableView.numberOfSections > 0 && tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .blueAct
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .backgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: versionButton)
        
        updateTitleWidthConstraint()
        setupTableView()
        setupPicker()
        setupButtonsNav()
        addGestures()
    }
    
    func didSelectSection(abbr: String, chapter: Int) {
        guard let bible = bible else { return }
        bible.updateActualBook(abbreviation: abbr)
        self.actualChapter = Chapter(bible: bible, number: chapter)
        
        if tableView.numberOfSections > 0 && tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func updateTitleWidthConstraint() {
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        widthTitleButtonConstraint?.isActive = false
        if let actualChapter = actualChapter {
            let buttonTitle = actualChapter.formatedTitle()
            widthTitleButtonConstraint =
                titleButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonTitle.count * 10 + 20))
            widthTitleButtonConstraint?.isActive = true
        }
    }
    
    func updateUI() {
        showHiddenArrowsLeftRight()
        UserDefaultsPersistence.shared.updateDefaultValues(actualChapter: actualChapter)
        setupVerses()
        updateButtonTitle()
        tableView.reloadData()
    }
    
    func showHiddenArrowsLeftRight() {
        guard let actualChapter = actualChapter else { return }
        if actualChapter.abbreviation == "gn" && actualChapter.number == 0 {
            leftSwipeButton.isEnabled = false } else {
                leftSwipeButton.isEnabled = true
            }
        
        if actualChapter.abbreviation == "ap" && actualChapter.number == 21 {
            rightSwipeButton.isEnabled = false} else {
                rightSwipeButton.isEnabled = true
            }
    }
    
    func updateButtonTitle() {
        guard let actualChapter = actualChapter else { return }
        let buttonTitle = actualChapter.formatedTitle()
        titleButton.setTitle(buttonTitle, for: .normal)
        let versionButtonTitle = actualChapter.formatedVersion()
        versionButton.text = versionButtonTitle
        updateTitleWidthConstraint()
        
    }
    
    func setupButtonsNav() {
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let stackView = UIStackView(arrangedSubviews: [leftSwipeButton, titleButton, rightSwipeButton])
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        navigationItem.titleView = stackView
    }
}
