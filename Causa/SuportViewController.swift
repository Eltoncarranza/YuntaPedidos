import UIKit

class SuportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var SuportTableView: UITableView!
    
    // 1. Estos son tus 4 botones flotantes. ¡Conéctalos en el Storyboard!
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewWhatsapp: UIView!
    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var viewReportar: UIView!
    
    var suport: [Suport] = []
    var menuExpandido = false // Controla si el menú está abierto o cerrado
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SuportTableView.dataSource = self
        SuportTableView.delegate = self
        
        // Carga de datos de Yunta Pedidos
        suport.append(Suport(pregunta: "¿Cuál es el tiempo de entrega estimado?", respuesta: "Nuestro tiempo promedio en Laredo y Trujillo es de 30 a 45 minutos."))
        suport.append(Suport(pregunta: "¿Cómo puedo aplicar un cupón?", respuesta: "Ingresa tu código en el campo 'Código Promocional' antes de pagar."))
        suport.append(Suport(pregunta: "¿Qué hago si mi pedido llegó incompleto?", respuesta: "Usa el chat con asesor para ayudarte de inmediato."))
        suport.append(Suport(pregunta: "¿Puedo cambiar la dirección?", respuesta: "Solo si el repartidor aún no ha salido del local."))
        suport.append(Suport(pregunta: "¿Métodos de pago?", respuesta: "Efectivo, Yape, Plin y tarjetas."))
        
        // --- CONFIGURACIÓN DE LOS BOTONES FLOTANTES ---
        // Darles forma redonda y prepararlos para los toques
        [viewPrincipal, viewWhatsapp, viewChat, viewReportar].forEach {
            $0?.isUserInteractionEnabled = true
            $0?.layer.cornerRadius = 30 // Hace que un cuadro de 60x60 sea un círculo perfecto
            $0?.clipsToBounds = true
        }
        
        // Ocultar los botones secundarios al iniciar la app
        viewWhatsapp.alpha = 0
        viewChat.alpha = 0
        viewReportar.alpha = 0
        
        // Asignar la acción a cada botón
        viewPrincipal.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accionPrincipal)))
        viewWhatsapp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accionWhatsapp)))
        viewReportar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accionReportar)))
        viewChat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accionChat)))
    }
    
    // MARK: - Animación del Menú Flotante
    @objc func accionPrincipal() {
        menuExpandido.toggle()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            if self.menuExpandido {
                // Extender hacia arriba
                self.viewWhatsapp.transform = CGAffineTransform(translationX: 0, y: -80)
                self.viewChat.transform = CGAffineTransform(translationX: 0, y: -150)
                self.viewReportar.transform = CGAffineTransform(translationX: 0, y: -220)
                
                [self.viewWhatsapp, self.viewChat, self.viewReportar].forEach { $0?.alpha = 1 }
                self.viewPrincipal.transform = CGAffineTransform(rotationAngle: .pi / 4) // Gira 45 grados (como una X)
            } else {
                // Contraer
                [self.viewWhatsapp, self.viewChat, self.viewReportar].forEach {
                    $0?.transform = .identity
                    $0?.alpha = 0
                }
                self.viewPrincipal.transform = .identity
            }
        })
    }

    // MARK: - Acciones de los botones
    @objc func accionWhatsapp() {
        print("Abriendo WhatsApp...")
        // let url = URL(string: "https://wa.me/tunumerodeyunta")!
        // UIApplication.shared.open(url)
    }

    @objc func accionReportar() {
        let alerta = UIAlertController(title: "Reportar", message: "¿Qué problema tuviste?", preferredStyle: .actionSheet)
        alerta.addAction(UIAlertAction(title: "Pedido demorado", style: .default))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alerta, animated: true)
    }

    @objc func accionChat() {
        print("Abriendo chat interno...")
    }
    
    // MARK: - Métodos de la Tabla (FAQ)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreguntasCell", for: indexPath) as! SuportTableViewCell
        let item = suport[indexPath.row]
        
        cell.PreguntaLabel.text = item.pregunta
        cell.RespuestaLabel.text = item.expandida ? item.respuesta : ""
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        suport[indexPath.row].expandida.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
