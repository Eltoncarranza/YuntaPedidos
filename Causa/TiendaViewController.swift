import UIKit

struct SeccionTienda {
    let titulo: String
    let productos: [Producto]
}

class TiendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablaTienda: UITableView!
    
    var secciones: [SeccionTienda] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaTienda.delegate = self
        tablaTienda.dataSource = self
        tablaTienda.separatorStyle = .none
        
        cargarDatosDePrueba()
    }

    func cargarDatosDePrueba() {
        let bicis = [
                    Producto(id: "1", nombre: "Bici de Ruta", precio: 2800.0, nombreImagen: "Ruta"),
                    Producto(id: "2", nombre: "Bici de Montaña", precio: 3200.0, nombreImagen: "Montaña"),
                    Producto(id: "3", nombre: "Bici Urbana", precio: 2500.0, nombreImagen: "Urbanas"),
                    Producto(id: "4", nombre: "Bici Híbrida", precio: 2900.0, nombreImagen: "Híbridas")
                ]
                
                // 2. Categoría: Accesorios
                let accesorios = [
                    Producto(id: "5", nombre: "Casco Janko", precio: 150.0, nombreImagen: "Casco"),
                    Producto(id: "6", nombre: "Casco Pro", precio: 180.0, nombreImagen: "Casco2"),
                    Producto(id: "7", nombre: "Candado U-Lock", precio: 80.0, nombreImagen: "Candado"),
                    Producto(id: "8", nombre: "Candado Cadena", precio: 95.0, nombreImagen: "candado2"),
                    Producto(id: "9", nombre: "Linterna Frontal", precio: 60.0, nombreImagen: "Linterna"),
                    Producto(id: "10", nombre: "Luz LED Trasera", precio: 35.0, nombreImagen: "luz2")
                ]
                
                // 3. Categoría: Merch Oficial
                let merch = [
                    Producto(id: "11", nombre: "Polo Verde Janko", precio: 45.0, nombreImagen: "Polo1"),
                    Producto(id: "12", nombre: "Polo Beige Eco", precio: 45.0, nombreImagen: "polo2"),
                    Producto(id: "13", nombre: "Gorra Clásica", precio: 35.0, nombreImagen: "Gorra1"),
                    Producto(id: "14", nombre: "Gorra Beige", precio: 35.0, nombreImagen: "gorro2"),
                    Producto(id: "15", nombre: "Tomatodo Deportivo", precio: 25.0, nombreImagen: "tomatodo1"),
                    Producto(id: "16", nombre: "Tomatodo Bambú", precio: 30.0, nombreImagen: "tomatodo2")
                ]
                

        secciones = [
            SeccionTienda(titulo: "Bicicletas de Bambú", productos: bicis),
            SeccionTienda(titulo: "Accesorios y Repuestos", productos: accesorios),
            SeccionTienda(titulo: "Merch Oficial", productos: merch)
                ]
        
        tablaTienda.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secciones.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "SeccionCell", for: indexPath) as! TiendaTableViewCell
        
        let seccionActual = secciones[indexPath.row]
        celda.configurarSeccion(titulo: seccionActual.titulo, productos: seccionActual.productos)
        
        return celda
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340.0
    }
}
