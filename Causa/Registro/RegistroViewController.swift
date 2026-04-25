import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistroViewController: UIViewController {

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword1: UITextField!
    @IBOutlet weak var txtPassword2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

    @IBAction func btnRegistrarTapped(_ sender: UIButton) {
        let nombre = txtNombre.text ?? ""
        let email = txtCorreo.text ?? ""
        let pass1 = txtPassword1.text ?? ""
        let pass2 = txtPassword2.text ?? ""

        if nombre.isEmpty || email.isEmpty || pass1.isEmpty || pass2.isEmpty {
            mostrarAlerta(mensaje: "Por favor, completa todos los campos.")
            return
        }

        if pass1 != pass2 {
            mostrarAlerta(mensaje: "Las contraseñas no coinciden.")
            return
        }
        
        if pass1.count < 6 {
            mostrarAlerta(mensaje: "La contraseña debe tener al menos 6 caracteres.")
            return
        }

        Auth.auth().createUser(withEmail: email, password: pass1) { authResult, error in
            if let e = error {
                self.mostrarAlerta(mensaje: "Error: \(e.localizedDescription)")
            } else {
                
                let uid = authResult?.user.uid ?? ""
                
                self.crearColeccionUsuario(id: uid, nombre: nombre, correo: email)
                
                UserDefaults.standard.set(true, forKey: "isLogin")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tabBar = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? UITabBarController {
                    tabBar.modalPresentationStyle = .fullScreen
                    self.present(tabBar, animated: true, completion: nil)
                }
            }
        }
    }

    func crearColeccionUsuario(id: String, nombre: String, correo: String) {
        let db = Firestore.firestore()
        
        db.collection("usuarios").document(id).setData([
            "nombre": nombre,
            "email": correo,
            "fecha_registro": FieldValue.serverTimestamp()
        ]) { error in
            if let e = error {
                print("Error al crear colección: \(e.localizedDescription)")
            } else {
                print("Colección 'usuarios' actualizada con éxito en Firestore")
            }
        }
    }

    func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Yunta Pedidos", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
