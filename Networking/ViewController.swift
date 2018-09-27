//
//  ViewController.swift
//  Networking
//
//  Created by Yoshua Elmaryono on 26/09/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let getRequestButton = UIButton()
        view.addSubview(getRequestButton)

        getRequestButton.setTitleColor(.blue, for: .normal)
        getRequestButton.setTitle("Get Request", for: .normal)
        getRequestButton.addTarget(self, action: #selector(getRequest(_:)), for: .touchUpInside)

        getRequestButton.translatesAutoresizingMaskIntoConstraints = false
        getRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getRequestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        getRequestButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        getRequestButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let postRequestButton = UIButton()
        view.addSubview(postRequestButton)
        
        postRequestButton.setTitleColor(.blue, for: .normal)
        postRequestButton.setTitle("Post Request", for: .normal)
        postRequestButton.addTarget(self, action: #selector(postRequest(_:)), for: .touchUpInside)
        
        postRequestButton.translatesAutoresizingMaskIntoConstraints = false
        postRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postRequestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        postRequestButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        postRequestButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    @objc func postRequest(_ sender: UIButton){
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://httpbin.org/post")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonInput = ["name":"Joe"]
        let data = try? JSONSerialization.data(withJSONObject: jsonInput, options: [])
        urlRequest.httpBody = data
        
        let dataTask = session.dataTask(with: urlRequest) { (data, resp, err) in
            if let unwrappedError = err {
                print("Error",unwrappedError.localizedDescription)
            }else if let unwrappedData = data {
                print("Data",unwrappedData)
                do {
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    print("JSON", json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        dataTask.resume()

    }
    @objc func getRequest(_ sender: UIButton){
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://httpbin.org/get")!
        let dataTask = session.dataTask(with: url) { (data, resp, err) in
            if let unwrappedError = err {
                print("Error",unwrappedError.localizedDescription)
            }else if let unwrappedData = data {
                print("Data",unwrappedData)
                do {
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    print("JSON", json)
                    if let dict = json as? [String:Any] {
                        if let headers = dict["headers"] as? [String:Any]{
                            print(headers["Host"])
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        dataTask.resume()
    }

}

