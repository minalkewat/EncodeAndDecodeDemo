//
//  ViewController.swift
//  EncodeAndDecodeDemo
//
//  Created by Meenal Kewat on 6/5/19.
//  Copyright © 2019 Meenal. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let data1:Data
        //Decoding
        do{
             let person = try JSONDecoder().decode(Person.self, from: rawData)
            print("person name : \(person.firstName) \(person.lastName)")
            print("person occupation: \(person.job.title)")
            print("person salary : \(person.job.salary)")
            print("person age : \(person.age)")
        }catch{
            print("error in decoding :\(error.localizedDescription)")
        }
       
        //Encoding
        let memeber = People(member: [Person1(firstName: "meenal", lastName: "kewat", age: 24),Person1(firstName: "rahul", lastName: "kumar", age: 24)])
        do {
                 data1 = try JSONEncoder().encode(memeber)
            print(data1)
        }catch{
            print("Could not encode : \(error.localizedDescription)")
        }
   
        
        
    }
    
    
    // ********************************************************Decoding********************************************************
    struct Job: Decodable {
        var title:String
        var salary:Float
        
        init(title:String,salary:Float){
            self.title = title
            self.salary = salary
        }
        
        enum CodingKeys:String, CodingKey {
            case title, salary
        }
        
    }
    
    
    struct Person: Decodable{
        var job:Job
        var firstName:String
        var lastName:String
        var age:Int
        
        init(job:Job, firstName:String,lastName:String,age:Int) {
            self.job = job
            self.firstName = firstName
            self.lastName = lastName
            self.age = age
        }
        
        enum CodingKeys: String,CodingKey {
            case job = "job_information", firstName = "firstname", lastName = "lastname", age = "age"
        }
        
    }
    
    
    
    // raw josn
    let rawData = """
{
"job_information":{
        "title": "iOS Developer",
         "salary": 5000
},
   "firstname": "Meenal",
    "lastname": "kewat",
    "age" : 24
}

""".data(using: .utf8)!
    
    // ********************************************************Encoding********************************************************
    
    struct Person1:Encodable {
        var firstName:String
        var lastName:String
        var age:Int
        
        init(firstName:String,lastName:String,age:Int) {
            self.firstName = firstName
            self.lastName = lastName
            self.age = age
        }
    }
    
    
    struct People:Encodable {
        var member:[Person1]
        
        init(member:[Person1]) {
            self.member = member
        }
    }
    
}



