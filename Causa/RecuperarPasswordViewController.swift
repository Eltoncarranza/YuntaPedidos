import UIKit
import FirebaseAuth

class RecuperarPasswordViewController: UIViewController {

    @IBOutlet weak var txtCorreoRecuperacion: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCorreoRecuperacion.placeholder = "Ingresa tu correo registrado"
        txtCorreoRecuperacion.keyboardType = .emailAddress
    }

    @IBAction func btnEnviarRecuperacionTapped(_ sender: UIButton) {
        
        guard let email = txtCorreoRecuperacion.text, !email.isEmpty else {
            mostrarAlerta(mensaje: "Por favor, ingresa tu correo para buscar tu cuenta.")
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let e = error {
                self.mostrarAlerta(mensaje: "Error al enviar: \(e.localizedDescription)")
            } else {
               
                self.mostrarAlertaDeExitoYVolver()
            }
        }
    }
    
    func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Yunta Pedidos", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
    
    func mostrarAlertaDeExitoYVolver() {
        let alerta = UIAlertController(title: "¡Correo enviado!", message: "Revisa tu bandeja de entrada o la carpeta de SPAM para restablecer tu contraseña.", preferredStyle: .alert)
        
        let accionOK = UIAlertAction(title: "Entendido", style: .default) { _ in
        
            self.dismiss(animated: true, completion: nil)
        }
        
        alerta.addAction(accionOK)
        present(alerta, animated: true)
    }
}
