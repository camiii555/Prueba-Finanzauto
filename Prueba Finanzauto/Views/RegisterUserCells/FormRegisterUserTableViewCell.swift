//
//  FormRegisterUserTableViewCell.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import UIKit

protocol FormRegisterTableViewCellDelegate: AnyObject {
    func formRegisterTableViewCellDidTapNext(userCreate: CreateUserRequest)
}

class FormRegisterUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthDateView: UIView!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var formView: BaseView!
    @IBOutlet weak var saveOrCreateUserButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: FormRegisterTableViewCellDelegate?
    
    private let pickerView = UIPickerView()
    private let datePickerView = UIDatePicker()
    private var activeTextField: UITextField?
    private var currentOptions: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        pickerView.dataSource = self
        datePickerView.datePickerMode = .date
        birthDateTextField.inputView = datePickerView
        titleTextField.inputView = pickerView
        genderTextField.inputView = pickerView
        titleTextField.delegate = self
        genderTextField.delegate = self
        birthDateTextField.delegate = self
        setupToolbarPickerView()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupToolbarPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        titleTextField.inputAccessoryView = toolbar
        genderTextField.inputAccessoryView = toolbar
        birthDateTextField.inputAccessoryView = toolbar
    }
    
    private func showValidationAlert(message: String) {
        if let viewController = self.parentViewController {
            let alert = UIAlertController(
                title: "Validación",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
        }
    }
    
    private func validateGenderFieldSubmission() -> String {
        switch genderTextField.text {
        case "Masculino":
            return "male"
        case "Femenino":
            return "female"
        default:
            return "other"
        }
    }
    
    private func validateSubmissionOfTitleField() -> String {
        switch titleTextField.text {
        case "Señor":
            return "mr"
        case "Señora":
            return "ms"
        case "Señora - casada":
            return "mrs"
        case "Señorita":
            return "miss"
        default:
            return "dr"
        }
    }

    @IBAction func CreateUser(_ sender: Any) {
        
        
        let fieldsToValidate: [(UITextField, UIView, String)] = [
            (titleTextField, titleView, "Título"),
            (nameTextField, nameView, "Nombre"),
            (lastNameTextField, lastNameView, "Apellido"),
            (genderTextField, genderView, "Género"),
            (emailTextField, emailView, "Correo electrónico"),
            (birthDateTextField, birthDateView, "Fecha de nacimiento"),
            (phoneTextField, phoneView, "Teléfono")
        ]

        for (textField, containerView, fieldName) in fieldsToValidate {
            let isValid = validateField(textField) ?? false
            updateFieldAppearance(container: containerView, isValid: isValid)
            if !isValid {
                showValidationAlert(message: "El campo '\(fieldName)' es inválido o está vacío.")
                return
            }
        }

        let newUser = CreateUserRequest(
            title: validateSubmissionOfTitleField(),
            firstName: nameTextField.text ?? "",
            lastName: lastNameTextField.text ?? "",
            gender: validateGenderFieldSubmission(),
            email: emailTextField.text ?? "",
            dateOfBirth: birthDateTextField.text ?? "",
            phone: phoneTextField.text ?? "",
            picture: "www.google.com"
        )

        delegate?.formRegisterTableViewCellDidTapNext(userCreate: newUser)
        
        clearAllFields()
    }
    
    @IBAction func cancelCreateUser(_ sender: Any) {
        clearAllFields()
    }
    
}

extension FormRegisterUserTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        
        switch textField {
        case titleTextField:
            currentOptions = Constans.OptionsTextField.titleOptions
        case genderTextField:
            currentOptions = Constans.OptionsTextField.genderOptions
        default:
            return
        }
        
        pickerView.reloadAllComponents()
        
        if let text = textField.text, let index = currentOptions.firstIndex(of: text) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isValid = validateField(textField) ?? false

        if textField == titleTextField {
            updateFieldAppearance(container: titleView, isValid: isValid)
        } else if textField == nameTextField {
            updateFieldAppearance(container: nameView, isValid: isValid)
        } else if textField == lastNameTextField {
            updateFieldAppearance(container: lastNameView, isValid: isValid)
        } else if textField == genderTextField {
            updateFieldAppearance(container: genderView, isValid: isValid)
        } else if textField == emailTextField {
            updateFieldAppearance(container: emailView, isValid: isValid)
        } else if textField == birthDateTextField {
            updateFieldAppearance(container: birthDateView, isValid: isValid)
        } else if textField == phoneTextField {
            updateFieldAppearance(container: phoneView, isValid: isValid)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeTextField?.text = currentOptions[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    @objc func donePressed() {
        
        if activeTextField == birthDateTextField {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
            formatter.timeZone = TimeZone.current
            birthDateTextField.text = formatter.string(from: datePickerView.date)
            
        } else {
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            activeTextField?.text = currentOptions[selectedRow]
        }
        
        activeTextField?.resignFirstResponder()
    }
    
    
    private func validateField(_ textField: UITextField) -> Bool? {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return false
        }
        
        if textField == emailTextField {
            return isValidEmail(text)
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = Constans.FormValidation.emailRegEx
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    private func updateFieldAppearance(container: UIView, isValid: Bool) {
        let borderColor = isValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        container.layer.borderColor = borderColor
    }
    
    func clearAllFields() {
        let allFields: [(UITextField, UIView)] = [
            (titleTextField, titleView),
            (nameTextField, nameView),
            (lastNameTextField, lastNameView),
            (genderTextField, genderView),
            (emailTextField, emailView),
            (birthDateTextField, birthDateView),
            (phoneTextField, phoneView),
            (idTextField, idView)
        ]
        
        for (textField, containerView) in allFields {
            textField.text = ""
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            parentResponder = responder.next
            if let vc = responder as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
