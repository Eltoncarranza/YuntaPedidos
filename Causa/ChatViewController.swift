import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // ⚠️ Conecta esto desde tu Storyboard
    @IBOutlet weak var lblMensajeBot: UILabel!
    @IBOutlet weak var tablaOpciones: UITableView!

    // Variables para controlar en qué parte del árbol estamos
    var opcionesActuales: [String] = []
    var estadoActual: Int = 0 // 0 = Menú, 1 = Respuesta, 2 = Despedida

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuramos la tabla
        tablaOpciones.delegate = self
        tablaOpciones.dataSource = self
        
        // Para que se vea limpio
        tablaOpciones.tableFooterView = UIView()
        self.view.backgroundColor = UIColor(white: 0.96, alpha: 1.0) // Color Janko
        
        // Arrancamos el chatbot
        mostrarMenuPrincipal()
    }

    // MARK: - Lógica del Chatbot
    func mostrarMenuPrincipal() {
        estadoActual = 0
        lblMensajeBot.text = "¡Hola! Soy el asistente virtual de Janko 🎋.\n¿En qué te puedo ayudar hoy con tu bicicleta de bambú?"
        opcionesActuales = ["Dudas de pago", "Estado de mi bici", "Garantía"]
        tablaOpciones.reloadData()
    }

    // MARK: - Métodos de la Tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opcionesActuales.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Truco pro: Usamos la celda por defecto de Apple para no tener que diseñar una
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = opcionesActuales[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.textLabel?.textColor = .systemBlue
        cell.backgroundColor = .clear
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seleccion = opcionesActuales[indexPath.row]

        // ÁRBOL DE DECISIONES
        if estadoActual == 0 {
            // PASO 1: El usuario hizo una pregunta
            estadoActual = 1
            if seleccion == "Dudas de pago" {
                lblMensajeBot.text = "Aceptamos Yape, Plin y tarjetas. Se requiere un 50% de adelanto para empezar a trabajar tu bambú.\n\n¿Esto resolvió tu duda?"
            } else if seleccion == "Estado de mi bici" {
                lblMensajeBot.text = "El curado y ensamblaje toma de 2 a 3 semanas. Te enviamos fotos del proceso paso a paso.\n\n¿Esto resolvió tu duda?"
            } else if seleccion == "Garantía" {
                lblMensajeBot.text = "El marco de bambú tiene 5 años de garantía estructural.\n\n¿Esto resolvió tu duda?"
            }
            // Cambiamos los botones
            opcionesActuales = ["Sí, gracias", "No, necesito más ayuda"]
            tablaOpciones.reloadData()

        } else if estadoActual == 1 {
            // PASO 2: El usuario confirmó si le sirvió o no
            estadoActual = 2
            if seleccion == "Sí, gracias" {
                lblMensajeBot.text = "¡Genial! Si necesitas algo más, aquí estaré."
            } else {
                lblMensajeBot.text = "Lamentamos no haberte ayudado por aquí. Un maestro artesano de Janko se comunicará contigo pronto a tu número registrado."
                // 💡 Aquí en el futuro puedes guardar en Firebase que este usuario necesita contacto humano
            }
            opcionesActuales = ["Volver al inicio", "Cerrar asistente"]
            tablaOpciones.reloadData()

        } else if estadoActual == 2 {
            // PASO 3: Reiniciar o Salir
            if seleccion == "Volver al inicio" {
                mostrarMenuPrincipal()
            } else {
                // Cierra esta pantalla y vuelve a donde estaba
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        // Quita la selección gris al tocar
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
