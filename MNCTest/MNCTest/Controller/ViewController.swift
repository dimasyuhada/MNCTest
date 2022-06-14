//
//  ViewController.swift
//  MNCTest
//
//  Created by Dimas Syuhada on 14/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let baseUrl: String = "https://60a4954bfbd48100179dc49d.mockapi.io/api/innocent/newsapp/articles"
    var newsList = [NewsData]()
    var strIdNews: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        fetchData()
    }

}

//MARK: Functions & Actions
extension ViewController {
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    func fetchData() {
        getJSON{
            self.tableView.reloadData()
        };
    }
    
    func getJSON(completed: @escaping() -> ()){
        let url = URL (string: baseUrl)
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            if error == nil {
                do{
                    let dataNews = try JSONDecoder().decode([NewsData].self, from: data!)
                    self.newsList = dataNews
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetails"{
            let vc = segue.destination as! DetailViewController
            vc.strId = strIdNews
        }else {
            
        }
    }
    
}

//MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.configure(with: newsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        strIdNews = newsList[(indexPath.row)].id
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goDetails", sender: self)
        }
    }
    
}

