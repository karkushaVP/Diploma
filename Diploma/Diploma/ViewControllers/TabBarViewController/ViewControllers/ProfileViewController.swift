//
//  ProfileViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import FirebaseAuth
import PhotosUI

enum ControllerMode {
    case create
    case read(String)
}

class ProfileViewController: UIViewController {
    
    private let mode: ControllerMode
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.image = UIImage(systemName: "gear")
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameInput: UITextField = {
        let input = UITextField()
        input.layer.cornerRadius = 12
        input.layer.borderColor = UIColor.lightGray.cgColor
        input.layer.borderWidth = 1
        input.leftViewMode = .always
        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        return input
    }()
    
    private lazy var surnameInput: UITextField = {
        let input = UITextField()
        input.layer.cornerRadius = 12
        input.layer.borderColor = UIColor.lightGray.cgColor
        input.layer.borderWidth = 1
        input.leftViewMode = .always
        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        return input
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(
            self,
            action: #selector(saveContactAction),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeLayout()
        makeConstraints()
        setupControllerMode()
        setupGestures()
    }
    
    init(mode: ControllerMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.view.addSubview(avatarImageView)
        self.view.addSubview(nameInput)
        self.view.addSubview(surnameInput)
        self.view.addSubview(saveButton)
    }
    
    private func makeConstraints() {
        
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.height.equalTo(160)
            make.width.equalTo(160)
        }
        
        nameInput.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(avatarImageView.snp.bottom).offset(25)
            make.height.equalTo(40)
        }
        
        surnameInput.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nameInput.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    @objc private func saveData() {
        guard let name = nameInput.text,
              let surname = surnameInput.text,
              let user = Auth.auth().currentUser
        else { return }
        
        let userData: [String: Any] = [
            "username": name,
            "surname": surname
        ]
    }
    
    private func readUserData() {
        guard let user = Auth.auth().currentUser else { return }
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapAction))
        avatarImageView.addGestureRecognizer(tap)
    }
    
    @objc private func avatarTapAction() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = PHPickerFilter.any(of: [.images])
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        present(pickerVC, animated: true)
    }
    
    private func setupControllerMode() {
        switch mode {
        case .create:
            title = "Создать профиль"
        case .read(let id):
            title = "Профиль"
            Environment.ref.child("users/\(id)/contacts/\(id)").observeSingleEvent(of: .value) { [weak self] (snapshot,arg)  in
                guard let contactValue = snapshot.value as? [String: Any],
                      let contactForRead = try? Contact(key: id, dict: contactValue)
                else { return }
                self?.nameInput.text = contactForRead.name
                self?.surnameInput.text = contactForRead.surname
            }
            let child = Environment.storage.child("images/\(id).jpg")
            child.downloadURL { (url, error) in
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let url,
                          let data = try? Data(contentsOf: url),
                          let image = UIImage(data: data)
                    else { return }
                    DispatchQueue.main.async { [weak self] in
                        self?.avatarImageView.image = image
                    }
                }
            }
            
            let addButton = UIButton(type: .system)
            addButton.addTarget(self, action: #selector(deleteContact), for: .touchUpInside)
            addButton.setImage(UIImage(systemName: "trash"), for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        }
    }
    
    @objc private func deleteContact() {
        switch mode {
        case .create:
            break
        case .read(let id):
            guard let user = Auth.auth().currentUser
            else { return }
            Environment.ref.child("users/\(user.uid)/contacts/\(id)").removeValue()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func saveContactAction() {
        guard let name = nameInput.text,
              let surname = surnameInput.text,
              let user = Auth.auth().currentUser,
              let image = avatarImageView.image?.jpegData(compressionQuality: 0.5)
        else { return }
        
        let contact = Contact(
            id: nil,
            name: name,
            surname: surname)
        
        switch mode {
        case .create:
            Environment.ref.child("users/\(user.uid)/contacts").childByAutoId().setValue(contact.asDict)
            saveAvatar(imageData: image)
            dismiss(animated: true)
        case .read(let id):
            Environment.ref.child("users/\(user.uid)/contacts").updateChildValues(contact.asDict)
        }
    }
    
    @objc private func saveAvatar(imageData: Data) {
        guard let user = Auth.auth().currentUser else { return }
        let child = Environment.storage.child("\(user.uid)/\(UUID().uuidString).jpg")
        _ = child.putData(imageData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("Картинка не была загружена")
                return
            }
        }
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                guard let image = reading as? UIImage,
                      error == nil,
                      let imageData = image.jpegData(compressionQuality: 1)
                else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.avatarImageView.image = image
                }
                
//                ниже код получения абсолютного пути для нашего файл (то есть пути где он физически на нашем девайсе)
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: "public.image") { [weak self] url, _ in
                    print(url)
                }
            }
        }
    }
}
