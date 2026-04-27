import UIKit
import FirebaseAuth
import FirebaseFirestore

class PerfilUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imgPerfilUsuario: UIImageView!
    @IBOutlet weak var lblNombreUsuario: UILabel!
    @IBOutlet weak var vistaTarjetaCarrito: UIView!
    @IBOutlet weak var lblTotalCarrito: UILabel!
    @IBOutlet weak var tablaCarrito: UITableView!
    
    let db = Firestore.firestore()
    var productosEnCarrito: [Producto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarDiseno()
        obtenerNombreDeFirebase()
        
        tablaCarrito.dataSource = self
        tablaCarrito.delegate = self
        tablaCarrito.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cargarDatosYActualizar()
    }
    
    func cargarDatosYActualizar() {
        productosEnCarrito = CarritoManager.shared.obtenerProductos()
        let total = CarritoManager.shared.calcularTotal()
        lblTotalCarrito.text = String(format: "Total: S/ %.2f", total)
        tablaCarrito.reloadData()
    }

    func obtenerNombreDeFirebase() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.lblNombreUsuario.text = "Invitado"
            return
        }
        db.collection("usuarios").document(uid).getDocument { (document, error) in
            if let doc = document, doc.exists {
                let nombre = doc.data()?["nombre"] as? String ?? "Usuario Janko"
                DispatchQueue.main.async { self.lblNombreUsuario.text = nombre }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productosEnCarrito.isEmpty {
            let label = UILabel()
            label.text = "Tu carrito está vacío 🛒"
            label.textAlignment = .center
            label.textColor = .gray
            tableView.backgroundView = label
            return 0
        }
        tableView.backgroundView = nil
        return productosEnCarrito.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaCarrito", for: indexPath)
        let producto = productosEnCarrito[indexPath.row]
        
        cell.textLabel?.text = "🚲 \(producto.nombre)"
        cell.detailTextLabel?.text = String(format: "S/ %.2f", producto.precio)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let producto = productosEnCarrito[indexPath.row]
            CarritoManager.shared.eliminarProducto(nombre: producto.nombre)
            cargarDatosYActualizar()
        }
    }

    @IBAction func btnFinalizarCompra(_ sender: UIButton) {
        if !productosEnCarrito.isEmpty {
            let alerta = UIAlertController(title: "¡Pedido Recibido!", message: "Tu orden de YuntaPedidos está en camino.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                CarritoManager.shared.vaciarCarrito()
                self.cargarDatosYActualizar()
            })
            present(alerta, animated: true)
        }
    }

    @IBAction func btnCerrarSesion(_ sender: Any) {
        let alerta = UIAlertController(title: "Cerrar sesión", message: "¿Deseas salir de la aplicación?", preferredStyle: .alert)
        
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        alerta.addAction(UIAlertAction(title: "Salir", style: .destructive) { _ in
            
            do {
                try Auth.auth().signOut()
                CarritoManager.shared.vaciarCarrito()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "InitialVC")
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    
                    window.rootViewController = loginVC
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
                }
                
            } catch let signOutError as NSError {
                print("Error al cerrar sesión: %@", signOutError)
            }
        })
        
        present(alerta, animated: true)
    }

    func configurarDiseno() {
        
        imgPerfilUsuario.layer.cornerRadius = imgPerfilUsuario.frame.height / 2
                imgPerfilUsuario.clipsToBounds = true
                imgPerfilUsuario.layer.borderWidth = 3
                imgPerfilUsuario.layer.borderColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1.0).cgColor // Verde Janko
        
        vistaTarjetaCarrito.layer.cornerRadius = 15
        vistaTarjetaCarrito.layer.shadowOpacity = 0.1
        vistaTarjetaCarrito.layer.shadowRadius = 10
    }
}
