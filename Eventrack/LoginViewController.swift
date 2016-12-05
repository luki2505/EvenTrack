//
//  LoginViewController.swift
//  Eventrack
//
//  Created by Lukas on 16.11.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isLoggedIn() {
            // when a session is still available - login in automatically
            // commented out for testing reasons!
            //performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    // checks if the user is already authenticated
    func isLoggedIn() -> Bool {
        if ((FIRAuth.auth()?.currentUser) != nil) {
            return true
        } else {
            return false
        }
    }

    @IBAction func connectTapped(_ sender: UIButton) {
        let loginManager = FBSDKLoginManager()
        let permissions = ["public_profile", "email", "user_events", "user_friends"]
        loginManager.logIn(withReadPermissions: permissions, from: self, handler: {
            (result, err) in
            // Check for error
            if err != nil {
                print(err!)
                return
            }
            
            // Check for cancel
            if result!.isCancelled {
                print("Login canceled...")
                return
            }
            
            // Successfull!
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                // Check for error
                if error != nil {
                    print(error!)
                    return
                }
                
                // Successfull!
                print("Successfully logged in!")
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            }
        })
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            let destination = segue.destination as! LoadingViewController
            destination.user = FIRAuth.auth()
        }
    }
}
