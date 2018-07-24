//
//  ViewController.swift
//  Indicator
//
//  Created by Zhijian Ren on 2018/5/15.
//  Copyright © 2018 Zhijian Ren. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    var count = 0 //step counter
    var x = 0 //select type: 1 for iPhone; 2 for watch; 3 for pos
    var redf = true
    var greenf = true
    var bluef = true
    
    @IBOutlet var label: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet weak var choose: UIButton!
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var chooseagain: UIButton!
    @IBOutlet weak var addlist: UIButton!
    @IBOutlet weak var textlist: UITextField!
    
    var list = ["iPhone", "Watch", "POS"]
    var iphonelist = [String]()
    var watchlist = [String]()
    var poslist = [String]()
    var pickerlist = [String]()
    var filename = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // General Settings
        
        x = 0
        dropdown.isHidden = true
        dropdown.delegate = self
        dropdown.dataSource = self
        chooseagain.isHidden = true
        addlist.isHidden = true
        textlist.isHidden = true
        textlist.delegate = self
        pickerlist = list
        
        // Update list data from txt file
        
        iphonelist = updatelist(filename: "iPhonelist")
        iphonelist.remove(at: 0)
        iphonelist.append("Other")
        watchlist = updatelist(filename: "watchlist")
        watchlist.remove(at: 0)
        watchlist.append("Other")
        poslist = updatelist(filename: "poslist")
        poslist.remove(at: 0)
        poslist.append("Other")
    }
    
    func updatelist(filename:String) -> [String] {
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(filename).appendingPathExtension("txt")
        
        var readstring = ""
        do{
            readstring = try String(contentsOf: fileURL)
        } catch let error as NSError{
            print("Failed to Read")
            print(error)
        }
        //print(readstring)
        return readstring.components(separatedBy: "\n")
    }
    
    func hidetext(){
        addlist.isHidden = true
        textlist.isHidden = true
        textlist.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//-----------------------Choose Indicator Type-----------------------//
    @IBAction func selectdut(_ sender: UIButton) {
        if dropdown.isHidden {
            dropdown.isHidden = false
        }
        x = 0
        pickerlist = list
        chooseagain.setTitle("Choose", for: .normal)
        chooseagain.isHidden = true
        dropdown.reloadAllComponents()
        hidetext()
    }
    
    @IBAction func selectname(_ sender: UIButton) {
        if dropdown.isHidden {
            dropdown.isHidden = false
        }
        if (x == 1) {pickerlist = iphonelist}
        else if (x == 2) {pickerlist = watchlist}
        else {pickerlist = poslist}
        dropdown.reloadAllComponents()
        hidetext()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return pickerlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        dropdown.isHidden = true
        if (x == 0) {
            choose.setTitle(pickerlist[row], for: .normal)
            chooseagain.isHidden = false
            x = row + 1
        }
        else {
            chooseagain.setTitle(pickerlist[row], for: .normal)
            if (pickerlist[row] == "Other") {
                addlist.isHidden = false
                textlist.isHidden = false
                textlist.text = ""
            }
        }
    }
    
    @IBAction func addstring(_ sender: UIButton) {
        if (x == 1) {filename = "iPhonelist"; iphonelist.insert(textlist.text!, at: iphonelist.count-1)}
        else if (x == 2) {filename = "watchlist"; watchlist.insert(textlist.text!, at: watchlist.count-1)}
        else {filename = "poslist"; poslist.insert(textlist.text!, at: poslist.count-1)}
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(filename).appendingPathExtension("txt")
        
        //print("File Path: \(fileURL.path)")
        
        var readstring = ""
        do{
            readstring = try String(contentsOf: fileURL)
        } catch let error as NSError{
            print("Failed to Read")
            print(error)
        }
        //print(readstring)
        let writestring = readstring + "\n" + textlist.text!
        do {
            try writestring.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError{
            print("Failed to Write")
            print(error)
        }
        //print(writestring)
        hidetext()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: pickerlist[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
//-----------------------Indicate Part-----------------------//
    @IBAction func reset(_ sender: UIButton) {
        self.count = 0;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "white");
    }
    
    @IBAction func click(_ sender: UIButton) {
        self.count += 1;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "click");
    }
    
    @IBAction func touch(_ sender: UIButton) {
        self.count += 1;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "touch");
    }
    
    @IBAction func press(_ sender: UIButton) {
        self.count += 1;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "press");
    }
    
    @IBAction func slide_right(_ sender: UIButton) {
        self.count += 1;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "rightarrow");
    }
    @IBAction func slide_left(_ sender: UIButton) {
        self.count += 1;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "leftarrow");
    }
    @IBAction func slide_up(_ sender: UIButton) {
        self.count += 1;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "uparrow");
    }
    @IBAction func slide_down(_ sender: UIButton) {
        self.count += 1;
        self.label.text = "STATE: \(self.count)";
        self.image.image = #imageLiteral(resourceName: "downarrow");
    }
}


