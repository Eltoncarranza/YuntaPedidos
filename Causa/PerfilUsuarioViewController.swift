import UIKit
import FirebaseAuth
import FirebaseFirestore

class PerfilUsuarioViewController: UIViewController {

    @IBOutlet weak var imgPerfilUsuario: UIImageView!
    @IBOutlet weak var lblNombreUsuario: UILabel!
    @IBOutlet weak var vistaTarjetaCarrito: UIView!
    @IBOutlet weak var lblTotalCarrito: UILabel!
    @IBOutlet weak var stackCarrito: UIStackView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarDiseno()
        obtenerNombreDeFirebase()
        
        CarritoManager.shared.agregarProducto(Producto(id: "1", nombre: "Janko Urbana", precio: 2800.0, nombreImagen: "foto_ruta"))
        CarritoManager.shared.agregarProducto(Producto(id: "2", nombre: "Candado Bambú", precio: 80.0, nombreImagen: "foto_bambu"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actualizarPantallaCarrito()
    }
    
    func obtenerNombreDeFirebase() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            self.lblNombreUsuario.text = "Invitado"
            return
        }
        
        db.collection("usuarios").document(uid).getDocument { (document, error) in
            if let doc = document, doc.exists {
                let nombre = doc.data()?["nombre"] as? String ?? "Usuario Janko"
                DispatchQueue.main.async {
                    self.lblNombreUsuario.text = nombre
                }
            } else {
                DispatchQueue.main.async {
                    self.lblNombreUsuario.text = "Usuario Janko"
                }
            }
        }
    }
    
    @IBAction func btnCerrarSesion(_ sender: Any) {
        let alerta = UIAlertController(
            title: "Cerrar sesión",
            message: "¿Estás seguro que quieres salir?",
            preferredStyle: .alert
        )
        
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        alerta.addAction(UIAlertAction(title: "Salir", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
                CarritoManager.shared.vaciarCarrito()
                UserDefaults.standard.set(false, forKey: "isLogin")
                self.irAlLogin()
            } catch {
                print("Error al cerrar sesión: \(error.localizedDescription)")
            }
        })
        
        present(alerta, animated: true)
    }

    func irAlLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "InitialVC")
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    func actualizarPantallaCarrito() {
        for view in stackCarrito.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        let productosEnCarrito = CarritoManager.shared.listaDeCompras
        
        if productosEnCarrito.isEmpty {
            lblTotalCarrito.text = "Total: S/ 0.00"
            let lblVacio = UILabel()
            lblVacio.text = "Tu carrito está vacío 🛒"
            lblVacio.textAlignment = .center
            lblVacio.textColor = .gray
            stackCarrito.addArrangedSubview(lblVacio)
        } else {
            let total = CarritoManager.shared.calcularTotal()
            lblTotalCarrito.text = String(format: "Total: S/ %.2f", total)
            for producto in productosEnCarrito {
                let vistaProducto = crearFilaDeProducto(nombre: producto.nombre, precio: producto.precio)
                stackCarrito.addArrangedSubview(vistaProducto)
            }
        }
    }
    
    func crearFilaDeProducto(nombre: String, precio: Double) -> UIView {
        let fila = UIStackView()
        fila.axis = .horizontal
        fila.distribution = .equalSpacing
        
        let lblNombre = UILabel()
        lblNombre.text = "🚲 \(nombre)"
        lblNombre.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        let lblPrecio = UILabel()
        lblPrecio.text = String(format: "S/ %.2f", precio)
        lblPrecio.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        fila.addArrangedSubview(lblNombre)
        fila.addArrangedSubview(lblPrecio)
        
        return fila
    }
    
    func configurarDiseno() {
      
        imgPerfilUsuario.image = UIImage(systemName: "person.circle.fill")
        imgPerfilUsuario.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1.0)
        imgPerfilUsuario.contentMode = .scaleAspectFit
        imgPerfilUsuario.layer.cornerRadius = imgPerfilUsuario.frame.height / 2
        imgPerfilUsuario.clipsToBounds = true
        imgPerfilUsuario.layer.borderWidth = 3
        imgPerfilUsuario.layer.borderColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1.0).cgColor
        
        vistaTarjetaCarrito.layer.cornerRadius = 15
        vistaTarjetaCarrito.layer.shadowColor = UIColor.black.cgColor
        vistaTarjetaCarrito.layer.shadowOpacity = 0.05
        vistaTarjetaCarrito.layer.shadowOffset = CGSize(width: 0, height: 4)
        vistaTarjetaCarrito.layer.shadowRadius = 8
    }
}
