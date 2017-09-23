//
//  IntroViewController.swift
//  Disaster Victim Tool
//
//  Created by Omar Al-Ejel on 9/23/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UITextFieldDelegate {
    var heartImageView1: UIImageView = createHeartImageView()
    var heartImageView2: UIImageView = createHeartImageView()
    var heartImageView3: UIImageView = createHeartImageView()
    var heartImageView4: UIImageView = createHeartImageView()
    
    var didLayoutSubviews = false
    var didAppear = false
    
    @IBOutlet weak var skipButton: SqueezeButton!
    let bounds = UIScreen.main.bounds
    
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet weak var contextTextField: UITextField!
    
    @IBOutlet weak var inputLabel: UILabel!
    
    @IBOutlet weak var doneButton: SqueezeButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let centerOffset: CGFloat = 30
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        heartImageView1.center = CGPoint(x: center.x - 30, y: center.y - centerOffset)
        heartImageView2.center = CGPoint(x: center.x + 30, y: center.y - centerOffset)
        heartImageView3.center = CGPoint(x: center.x - 30, y: center.y + centerOffset)
        heartImageView4.center = CGPoint(x: center.x + 30, y: center.y + centerOffset)
        
        view.addSubview(heartImageView1)
        view.addSubview(heartImageView2)
        view.addSubview(heartImageView3)
        view.addSubview(heartImageView4)
        
        stylizeTextField(textField: countryTextField)
        stylizeTextField(textField: stateTextField)
        stylizeTextField(textField: cityTextField)
        stylizeTextField(textField: contextTextField)
        
        countryTextField.delegate = self
        stateTextField.delegate = self
        cityTextField.delegate = self
        contextTextField.delegate = self
        
        countryTextField.alpha = 0
        cityTextField.alpha = 0
        stateTextField.alpha = 0
        contextTextField.alpha = 0
        
        countryTextField.text = country
        cityTextField.text = city
        stateTextField.text = state
        contextTextField.text = context 
        
        inputLabel.alpha = 0
        
        skipButton.setBordered()
        skipButton.alpha = 0
        doneButton.alpha = 0
    }

    
    override func viewDidLayoutSubviews() {
        if !didLayoutSubviews {
            if city != "" {
                performSegue(withIdentifier: "showMainViewController", sender: self)
            }
        }
        didLayoutSubviews = true
    }
    
    func stylizeTextField(textField: UITextField) {
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        
        textField.layer.borderColor = ThemeRed.cgColor
        textField.layer.borderWidth = 3
    }
    
    class func createHeartImageView() -> UIImageView {
        let image = UIImage(named: "heart")
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 27)
        
        return imageView
    }
    
    @IBAction func unwindToIntro(segue: UIStoryboardSegue) {
        print("unwinding")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didAppear {
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                let heart1Center = self.heartImageView1.center
                self.heartImageView1.center = self.heartImageView4.center
                self.heartImageView4.center = heart1Center
                
                let heart2Center = self.heartImageView2.center
                self.heartImageView2.center = self.heartImageView3.center
                self.heartImageView3.center = heart2Center
                
            }) { (done) in
                
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    let heart1Center = self.heartImageView1.center
                    self.heartImageView1.center = self.heartImageView4.center
                    self.heartImageView4.center = heart1Center
                    
                    let heart2Center = self.heartImageView2.center
                    self.heartImageView2.center = self.heartImageView3.center
                    self.heartImageView3.center = heart2Center
                    
                }) { (done) in
                    
                    UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        
                        let center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
                        self.heartImageView1.center = center
                        self.heartImageView2.center = center
                        self.heartImageView3.center = center
                        self.heartImageView4.center = center
                        
                    }, completion: { (done) in
                        
                        UIView.animate(withDuration: 0.8, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            self.heartImageView2.removeFromSuperview()
                            self.heartImageView3.removeFromSuperview()
                            self.heartImageView4.removeFromSuperview()
                            
                            let shiftedCenter = CGPoint(x: self.bounds.size.width / 2, y:  self.inputLabel.frame.origin.y - 48)
                            self.heartImageView1.center = shiftedCenter
                            
                            self.countryTextField.alpha = 1
                            self.stateTextField.alpha = 1
                            self.cityTextField.alpha = 1
                            self.contextTextField.alpha = 1
                            
                            self.inputLabel.alpha = 1
                            
                            self.skipButton.alpha = 1
                            self.doneButton.alpha = 1
                            
                        }, completion: { (done) in
                            
                        })
                        
                    })
                }
            }
        }
        didAppear = true
    }
    
    
    @IBAction func skipPressed(_ sender: Any) {
        //TODO
        performSegue(withIdentifier: "showMainViewController", sender: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func donePressed(_ sender: Any) {
        city = cityTextField.text!
        country = countryTextField.text!
        state = stateTextField.text!
        context = contextTextField.text!
        saveSettings()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

}
