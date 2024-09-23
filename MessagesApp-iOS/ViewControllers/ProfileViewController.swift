//
//  ProfileViewController.swift
//  MessagesApp-iOS
//
//  Created by Mañanas on 19/9/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let userID = Auth.auth().currentUser!.uid
    var user: User! = nil
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameEditText: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var birthdayDay: UITextField!
    @IBOutlet weak var birthdayMonth: UITextField!
    @IBOutlet weak var birthdayYear: UITextField!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var aboutMe: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //birthdayDay.text?.ranges(of: "^(?:[1-9]|[1-2][0-9]|3[0-2])$")
        
        fetchUser()
        
    }
    
    @IBAction func saveUser(_ sender: Any) {
        
        let birthday: String = [birthdayDay.text!, birthdayMonth.text!, birthdayYear.text!]
            .compactMap { $0 }
            .joined(separator: " ")
        
        birthdayDay.placeholder = birthdayDay.text!
        birthdayDay.text = ""
        birthdayMonth.placeholder = birthdayMonth.text!
        birthdayMonth.text = ""
        birthdayYear.placeholder = birthdayYear.text!
        birthdayYear.text = ""
        
        let gender: String = gender.titleForSegment(at: gender.selectedSegmentIndex)!
        
        user = User(id: userID, username: usernameEditText.text!, email: Auth.auth().currentUser!.email!,gender: gender, aboutMe: aboutMe.text, profileImage: user.profileImage, birthday: birthday)
        
        usernameEditText.placeholder = usernameEditText.text!
        usernameLabel.text = usernameEditText.text!
        usernameEditText.text = ""
        
        do {
            try db.collection("Users").document(userID).setData(from: user)
            //self.showToast(message: "Perfil actualizado correctamente")
            print("Perfil actualizado correctamente")
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func fetchUser() {
            let docRef = db.collection("Users").document(userID)

            Task {
                do {
                    user = try await docRef.getDocument(as: User.self)
                    print("User: \(user.debugDescription)")
                    
                    if user?.profileImage != nil && !user!.profileImage.isEmpty {
                        imageProfile.loadFrom(url: user!.profileImage)
                    } else {
                        imageProfile.image = UIImage(systemName: "person.circle.fill")
                    }
                    
                    usernameLabel.text = user?.username
                    usernameEditText.placeholder = user?.username
                    let birthday = user?.birthday.split(separator: " ")
                    
                    if let birthday = birthday, !birthday.isEmpty {
                        let stringBirthday = birthday.map { String($0) }
                        
                        birthdayDay.placeholder = stringBirthday[0]
                        birthdayMonth.placeholder = stringBirthday[1]
                        birthdayYear.placeholder = stringBirthday[2]
                    }
                    
                    aboutMe.text = user.aboutMe
                    
                    gender.selectedSegmentIndex = switch user?.gender {
                    case "Male":
                        0
                    case "Female":
                        1
                    case "Other":
                        2
                    default:
                        -1
                    }
                } catch {
                    print("Error decoding user: \(error)")
                }
            }
        }
    
    @IBAction func clickOnImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
        print ("Image is clicked")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
            
        imageProfile.image = image
            
            let data = image.jpegData(compressionQuality: 0.8)
            
            let storageRef = storage.reference()

            // Create a reference to the file you want to upload
            let profileRef = storageRef.child("\(userID)/profile.jpg")
            
            // Upload the file to the path "{userID}/profile.jpg"
        _ = profileRef.putData(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type.
            _ = metadata.size
                // You can also access to download URL after upload.
                profileRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    
                    self.user?.profileImage = downloadURL.absoluteString
                }
            }
        }
    
    
    
}
