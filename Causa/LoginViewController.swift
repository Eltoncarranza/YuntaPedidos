import UIKit
import FirebaseAuth
import FirebaseFirestore 

class LoginViewController: UIViewController {
    
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarDiseno()
    }

    func configurarDiseno() {
        correoTextField.placeholder = "Correo electrónico"
        passwordTextField.placeholder = "Contraseña"
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func btnIngresarTapped(_ sender: UIButton) {
        guard let email = correoTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            mostrarAlerta(mensaje: "Por favor, completa tus credenciales.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print("Error de login: \(e.localizedDescription)")
                self.mostrarAlerta(mensaje: "Correo o contraseña incorrectos.")
            } else {
               
                UserDefaults.standard.set(true, forKey: "isLogin")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let tabBar = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? UITabBarController {
                    tabBar.modalPresentationStyle = .fullScreen
                    self.present(tabBar, animated: true, completion: nil)
                }
            }
        }
    }

    func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Yunta Pedidos", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Entendido", style: .default))
        present(alerta, animated: true)
    }
}
