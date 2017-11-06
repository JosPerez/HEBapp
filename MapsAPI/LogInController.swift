//
//  LogInController.swift
//  MapsAPI
//
//  Created by jose perez on 28/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit

class LogInController: UIViewController {

    let imageView:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named:"HEB")
        return view
        
    }()
    let userLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Usuario"
        label.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 51/255, alpha: 1.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 2
        return label
    }()
    let passwordLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contraseña"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 51/255, alpha: 1.0)
        label.textAlignment = .center
        label.layer.cornerRadius = 2
        return label
    }()
    let userField:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder  = "Ej. yo@heb.com"
        field.layer.cornerRadius = 2
        field.keyboardType = .emailAddress
        return field
    }()
    let passwordField:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder  = "******"
        field.layer.cornerRadius = 2
        field.isSecureTextEntry = true
        return field
    }()
    
    let forgotButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Olvidaste tu contraseña?", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.setTitleColor(UIColor.blue, for: .highlighted)
        btn.contentHorizontalAlignment = .right
        btn.backgroundColor = UIColor.clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var LoginButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Entrar", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 51/255, alpha: 1.0)
        btn.layer.cornerRadius = 4
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(startSession), for: .touchDown)
        return btn
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        view.addSubview(imageView)
        view.addSubview(userLabel)
        view.addSubview(passwordLabel)
        view.addSubview(userField)
        view.addSubview(passwordField)
        view.addSubview(forgotButton)
        view.addSubview(LoginButton)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 190).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        userLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        userLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 55).isActive = true
        userLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        userLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        userField.topAnchor.constraint(equalTo: userLabel.bottomAnchor).isActive = true
        userField.bottomAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 40).isActive = true
        userField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        userField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        passwordLabel.topAnchor.constraint(equalTo: userField.bottomAnchor, constant: 15).isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: userField.bottomAnchor, constant: 40).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor).isActive = true
        passwordField.bottomAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 40).isActive = true
        passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        forgotButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true
        forgotButton.bottomAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40).isActive = true
        forgotButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        forgotButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        LoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        LoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        LoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        LoginButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive  = true
        
        

    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @objc func startSession() {
        
        if isValidEmailAddress(emailAddressString: userField.text!) {
            
            if userField.text == "Admin@heb.com" && passwordField.text == "admin1234" {
                
                let rootController = UINavigationController(rootViewController: ViewController())
                
                present(rootController, animated: true, completion: nil)
                
            }else if userField.text == "User@heb.com" && passwordField.text == "admin1234"{
                let rootController = UINavigationController(rootViewController: UserViewController())
                
                present(rootController, animated: true, completion: nil)
                
                
            }else  {
                
                let alert = UIAlertController(title: "Inicio de Sesion", message: "valida tu informacion", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(action)
                
                present(alert, animated: true, completion: nil)
                
            }
        }else {
            let alert = UIAlertController(title: "Inicio de Sesion", message: "valida tu informacion", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    

}
