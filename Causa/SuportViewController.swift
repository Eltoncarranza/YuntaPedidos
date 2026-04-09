import UIKit

class SuportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var SuportTableView: UITableView!
    var suport: [Suport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SuportTableView.dataSource = self
        SuportTableView.delegate = self // IMPORTANTE: Agregar el delegado
        
        // Carga de datos
        suport.append(Suport(pregunta: "¿Cuál es el tiempo de entrega estimado?", respuesta: "Nuestro tiempo promedio en Laredo y Trujillo es de 30 a 45 minutos."))
        suport.append(Suport(pregunta: "¿Cómo puedo aplicar un cupón?", respuesta: "Ingresa tu código en el campo 'Código Promocional' antes de pagar."))
        suport.append(Suport(pregunta: "¿Qué hago si mi pedido llegó incompleto?", respuesta: "Usa el chat con asesor para ayudarte de inmediato."))
        suport.append(Suport(pregunta: "¿Puedo cambiar la dirección?", respuesta: "Solo si el repartidor aún no ha salido del local."))
        suport.append(Suport(pregunta: "¿Métodos de pago?", respuesta: "Efectivo, Yape, Plin y tarjetas."))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreguntasCell", for: indexPath) as! SuportTableViewCell
        let item = suport[indexPath.row]
        
        cell.PreguntaLabel.text = item.pregunta
        
        // Lógica de desglose: Si no está expandida, el texto de la respuesta desaparece
        cell.RespuestaLabel.text = item.expandida ? item.respuesta : ""
        
        return cell
    }

    // Método para detectar el clic y desglosar
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Cambia el estado de la pregunta tocada
        suport[indexPath.row].expandida.toggle()
        
        // Recarga solo esa fila con animación automática
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
