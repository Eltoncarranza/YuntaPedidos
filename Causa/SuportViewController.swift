import UIKit

class SuportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var SuportTableView: UITableView!
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var viewWhatsapp: UIView!
    @IBOutlet weak var viewReportar: UIView!
    
    var suport: [Suport] = []
    var menuExpandido = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SuportTableView.dataSource = self
        SuportTableView.delegate = self
        
        // Carga de datos inicial para Yunta Pedidos
        suport.append(Suport(pregunta: "¿Cuál es el tiempo de entrega estimado?", respuesta: "Nuestro tiempo promedio en Laredo y Trujillo es de 30 a 45 minutos."))
        suport.append(Suport(pregunta: "¿Cómo puedo aplicar un cupón?", respuesta: "Ingresa tu código en el campo 'Código Promocional' antes de pagar."))
        suport.append(Suport(pregunta: "¿Qué hago si mi pedido llegó incompleto?", respuesta: "Usa el chat con asesor para ayudarte de inmediato."))
        suport.append(Suport(pregunta: "¿Puedo cambiar la dirección?", respuesta: "Solo si el repartidor aún no ha salido del local."))
        suport.append(Suport(pregunta: "¿Métodos de pago?", respuesta: "Efectivo, Yape, Plin y tarjetas."))
        
        // 1. Activar la interacción y ocultar secundarios
        [viewPrincipal, viewWhatsapp, viewChat, viewReportar].forEach {
            $0?.isUserInteractionEnabled = true
        }
        
        viewWhatsapp.alpha = 0
        viewChat.alpha = 0
        viewReportar.alpha = 0
        
        // 2. Configurar gestos de toque para cada vista
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
                self.viewPrincipal.transform = CGAffineTransform(rotationAngle: .pi / 4) // Gira 45 grados
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

    // MARK: - Acciones de los botones expandibles
    @objc func accionWhatsapp() {
        let urlGrupo = "https://chat.whatsapp.com/TU_GRUPO_YUNTA"
        if let url = URL(string: urlGrupo) { UIApplication.shared.open(url) }
    }

    @objc func accionReportar() {
        let alerta = UIAlertController(title: "Reportar", message: "¿Qué problema tuviste?", preferredStyle: .actionSheet)
        alerta.addAction(UIAlertAction(title: "Pedido demorado", style: .default))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alerta, animated: true)
    }

    @objc func accionChat() {
        print("Abriendo simulación de chat...")
        // Aquí puedes hacer el performSegue a tu pantalla de chat
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
