//
//  CategoriesViewController.swift
//  HomeWork24 (shio andghuladze)
//
//  Created by shio andghuladze on 23.08.22.
//

import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = FileManager.default.getAllFiles()
        setUpTableView()
    }
    
    private func resetCategories(){
        categories = FileManager.default.getAllFiles()
        categoriesTableView.reloadData()
    }
    
    private func setUpTableView(){
        categoriesTableView.register(UINib(nibName: "TableViewItemCell", bundle: nil), forCellReuseIdentifier: "TableViewItemCell")
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    @IBAction func createCategory(_ sender: Any) {
        let ac = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0].text ?? ""
            if !answer.isEmpty{
                FileManager.default.createDirectoryInDocuments(name: answer)
                ac.dismiss(animated: true)
                self.resetCategories()
            }
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewItemCell") as? TableViewItemCell {
            cell.setUp(name: categories[indexPath.row])
            cell.deleteAction = {
                FileManager.default.deleteFile(dir: self.categories[indexPath.row])
                self.resetCategories()
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RemindersViewController") as? RemindersViewController{
            vc.dirName = categories[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
