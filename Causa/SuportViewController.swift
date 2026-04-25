import UIKit

class SuportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var SuportTableView: UITableView!
    
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewWhatsapp: UIView!
    @IBOutlet weak var viewReportar: UIView!
    
    var suport: [Suport] = []
    var menuExpandido = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SuportTableView.dataSource = self
        SuportTableView.delegate = self
        
        SuportTableView.rowHeight = UITableView.automaticDimension
        SuportTableView.estimatedRowHeight = 120
        SuportTableView.separatorStyle = .none
        SuportTableView.backgroundColor = .clear
        
        cargarPreguntasJanko()
        configurarBotonesFlotantes()
    }
    
    func cargarPreguntasJanko() {
        suport.append(Suport(pregunta: "¿Cómo es el proceso para personalizar mi bicicleta Janko?", respuesta: "Es un proceso 100% a medida. Primero reservas tu modelo favorito desde la app. Una vez confirmada tu reserva, nuestro maestro artesano te contactará por WhatsApp para coordinar la toma de tus medidas exactas en nuestro taller o enviarte una guía en video para que lo hagas en casa."))
        suport.append(Suport(pregunta: "¿Es realmente resistente el bambú peruano?", respuesta: "¡Absolutamente! Utilizamos bambú peruano curado. Tiene una relación fuerza-peso superior a la del acero, haciendo tu marco increíblemente resistente, ligero y capaz de absorber vibraciones."))
        suport.append(Suport(pregunta: "¿Cuánto tiempo toma fabricar mi bicicleta?", respuesta: "Al ser una obra artesanal, el curado y ensamblaje toma de 2 a 3 semanas. Realizamos entregas directas en Laredo y Trujillo."))
        suport.append(Suport(pregunta: "¿Qué mantenimiento requiere el bambú?", respuesta: "El marco está sellado con poliuretano de alta resistencia. Solo necesitas limpiarlo con un paño húmedo. La parte mecánica recibe mantenimiento estándar en cualquier taller."))
        suport.append(Suport(pregunta: "¿Cuál es el límite de peso y la talla ideal?", respuesta: "Soportan hasta 120 kg. En cuanto a la talla, no te preocupes; adaptaremos los cortes del bambú a tu estatura exacta tras tu pedido."))
        suport.append(Suport(pregunta: "¿Qué garantía tiene el marco de bambú?", respuesta: "Ofrecemos una garantía de 3 años sobre el marco principal contra defectos de fabricación. Nuestras uniones están selladas y reforzadas para resistir el clima de La Libertad sin problemas."))
                
        suport.append(Suport(pregunta: "¿Los componentes mecánicos (frenos, llantas) son comerciales?", respuesta: "Sí, utilizamos componentes con estándares internacionales. Si necesitas cambiar una llanta, ajustar frenos o cambiar la cadena, puedes hacerlo en cualquier taller de bicicletas de Laredo o Trujillo."))
                
        suport.append(Suport(pregunta: "¿Puedo probar una bicicleta Janko antes de pedirla?", respuesta: "¡Claro que sí! Constantemente organizamos 'Rodadas de Prueba' en la Plaza de Armas de Laredo y el centro de Trujillo. Revisa la sección de Noticias de la app para ver nuestras próximas fechas."))
                
        suport.append(Suport(pregunta: "¿Hacen envíos a otras ciudades fuera de La Libertad?", respuesta: "Por el momento, nuestra producción artesanal se enfoca en Trujillo, Laredo y alrededores para garantizar que la bicicleta quede a tu medida perfecta en persona. Sin embargo, puedes contactarnos por soporte para evaluar un envío especial."))
                
        suport.append(Suport(pregunta: "¿Puedo instalarle accesorios como canastas o portaequipajes?", respuesta: "Sí, todos nuestros modelos incluyen puntos de anclaje estándar. Solo menciónalo cuando nuestro maestro artesano se contacte contigo para asegurarnos de dejar el espacio perfecto para tus accesorios."))
    }
    
    func configurarBotonesFlotantes() {
        [viewPrincipal, viewWhatsapp, viewReportar].forEach {
            $0?.isUserInteractionEnabled = true
            $0?.layer.cornerRadius = 30
            $0?.clipsToBounds = true
        }
        
        viewWhatsapp.alpha = 0
        viewReportar.alpha = 0
        
        viewPrincipal.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accionPrincipal)))
        viewWhatsapp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accionWhatsapp)))
        viewReportar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accionReportar)))
    }
    
    
    @objc func accionPrincipal() {
        menuExpandido.toggle()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            if self.menuExpandido {
               
                self.viewWhatsapp.transform = CGAffineTransform(translationX: 0, y: -80)
                self.viewReportar.transform = CGAffineTransform(translationX: 0, y: -150)
                
                [self.viewWhatsapp, self.viewReportar].forEach { $0?.alpha = 1 }
                self.viewPrincipal.transform = CGAffineTransform(rotationAngle: .pi / 4)
            } else {
                [self.viewWhatsapp, self.viewReportar].forEach {
                    $0?.transform = .identity
                    $0?.alpha = 0
                }
                self.viewPrincipal.transform = .identity
            }
        })
    }

        @objc func accionWhatsapp() {
            print("Abriendo enlace de WhatsApp de Janko...")
            
            let urlString = "https://chat.whatsapp.com/KVJIxzz0XQ3KQUixSrTYk4?mode=gi_t"
            
            if let url = URL(string: urlString) {

                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    let alerta = UIAlertController(title: "Error", message: "No pudimos abrir el enlace en este dispositivo.", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alerta, animated: true)
                }
            }
        }
    
    @objc func accionReportar() {
        let alertaPrincipal = UIAlertController(title: "Soporte Janko", message: "¿Qué tipo de asistencia necesitas con tu ecobicicleta?", preferredStyle: .actionSheet)
        
        let opc1 = UIAlertAction(title: "Dudas sobre medidas/talla", style: .default) { _ in self.pedirDetalleDelReporte(motivo: "Medidas") }
        let opc2 = UIAlertAction(title: "Problema con un componente", style: .default) { _ in self.pedirDetalleDelReporte(motivo: "Componentes") }
        let opc3 = UIAlertAction(title: "Retraso en la entrega", style: .default) { _ in self.pedirDetalleDelReporte(motivo: "Logística") }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alertaPrincipal.addAction(opc1)
        alertaPrincipal.addAction(opc2)
        alertaPrincipal.addAction(opc3)
        alertaPrincipal.addAction(cancelar)
        
        self.present(alertaPrincipal, animated: true)
    }
    
    func pedirDetalleDelReporte(motivo: String) {
        let alertaDetalle = UIAlertController(title: "Detalles del caso", message: "Motivo: \(motivo)\n\nPor favor, descríbenos brevemente tu consulta:", preferredStyle: .alert)
        
        alertaDetalle.addTextField { textField in
            textField.placeholder = "Escribe aquí los detalles..."
            textField.autocapitalizationType = .sentences
        }
        
        let enviar = UIAlertAction(title: "Enviar al Taller", style: .default) { _ in
            self.mostrarConfirmacion()
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alertaDetalle.addAction(cancelar)
        alertaDetalle.addAction(enviar)
        
        self.present(alertaDetalle, animated: true)
    }
    
    func mostrarConfirmacion() {
        let confirmacion = UIAlertController(title: "¡Recibido!", message: "Hemos registrado tu caso. Un maestro artesano lo revisará y nos comunicaremos contigo a la brevedad.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Entendido", style: .default)
        confirmacion.addAction(ok)
        self.present(confirmacion, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreguntasCell", for: indexPath) as! SuportTableViewCell
        let item = suport[indexPath.row]
        cell.configurarCelda(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        suport[indexPath.row].expandida.toggle()
        
        tableView.performBatchUpdates({
            if let cell = tableView.cellForRow(at: indexPath) as? SuportTableViewCell {
                cell.configurarCelda(item: suport[indexPath.row])
            }
        }, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
