class SoporteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablaSoporte: UITableView!
    
    var listaPreguntas = [
        FAQ(pregunta: "¿Mi pedido llegará a tiempo?", respuesta: "En Yunta nos esforzamos por entregar en menos de 30 minutos en Laredo y Trujillo."),
        FAQ(pregunta: "¿Cómo aplico el 2x1?", respuesta: "Busca los productos marcados con la etiqueta 'Yunta' para activar el combo automático."),
        FAQ(pregunta: "¿Puedo cancelar mi pedido?", respuesta: "Solo si el restaurante aún no ha empezado a preparar tu combo.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Muy importante: decirle a la tabla quién le dará los datos
        tablaSoporte.dataSource = self
        tablaSoporte.delegate = self
    }
}
