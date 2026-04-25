import UIKit
import FirebaseAuth
import FirebaseFirestore

class PerfilViewController: UITableViewController {

    // Aquí está el cable que acabas de conectar
    @IBOutlet weak var lblNombreUsuario: UILabel!
    
    // Conexión a tu base de datos
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mi Perfil"
        
        // Llamamos a la función para buscar tu nombre
        obtenerNombreDeFirebase()
    }
    
    // MARK: - 1. Traer datos de Firebase
    func obtenerNombreDeFirebase() {
        // Obtenemos el ID del usuario actual
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Buscamos su documento en la colección "usuarios"
        db.collection("usuarios").document(uid).getDocument { (document, error) in
            if let doc = document, doc.exists {
                // Sacamos el nombre y lo ponemos en la pantalla
                let nombre = doc.data()?["nombre"] as? String ?? "Usuario"
                
                DispatchQueue.main.async {
                    self.lblNombreUsuario.text = nombre
                }
            }
        }
    }

    // MARK: - 2. Acciones al tocar las filas
    // Esta función detecta automáticamente en qué fila de la tabla haces clic
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Si tocas la Fila 3 (Cerrar Sesión). Recuerda que en código se empieza a contar desde 0, 1, 2.
        if indexPath.row == 2 {
            mostrarAlertaCerrarSesion()
        }
        
        // Quita la selección gris para que se vea bonito
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - 3. Alerta y Cerrar Sesión
    func mostrarAlertaCerrarSesion() {
        let alerta = UIAlertController(title: "Cerrar Sesión", message: "¿Estás seguro de que quieres salir?", preferredStyle: .actionSheet)
        
        // Botón rojo de confirmación
        let accionSalir = UIAlertAction(title: "Salir", style: .destructive) { _ in
            self.ejecutarLogout()
        }
        
        // Botón de cancelar
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alerta.addAction(accionSalir)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated: true)
    }
    
    func ejecutarLogout() {
        do {
            // Firebase cierra la sesión
            try Auth.auth().signOut()
            
            // Te regresa a la pantalla de Login (ajusta esto si usas un Navigation Controller)
            self.dismiss(animated: true, completion: nil)
            
        } catch {
            print("Hubo un problema cerrando la sesión.")
        }
    }
}
