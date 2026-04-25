import UIKit



class NoticiasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var listaNoticias: [Noticia] = []

    override func viewDidLoad() {
        super.viewDidLoad()

 
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        cargarNoticias()
    }
    
    func cargarNoticias() {

        listaNoticias.append(Noticia(
            titulo: "Nueva Ruta en Trujillo",
            descripcion: "Inauguramos un sendero ecológico perfecto para estrenar tu Janko Urbana.",
            categoria: "RUTAS",
            fecha: "24 Abr",
            nombreImagen: "foto_ruta"
        ))
        
        listaNoticias.append(Noticia(
            titulo: "Bambú 100% Resistente",
            descripcion: "Nuestros nuevos marcos de bambú resisten mucho mejor la humedad de Trujillo.",
            categoria: "SOSTENIBILIDAD",
            fecha: "20 Abr",
            nombreImagen: "foto_bambu"
        ))
        
        listaNoticias.append(Noticia(
            titulo: "Taller Comunitario",
            descripcion: "Aprende a darle mantenimiento básico a tu ecobicicleta este fin de semana en la plaza de armas.",
            categoria: "EVENTOS",
            fecha: "15 Abr",
            nombreImagen: "foto_taller"
        ))
        
        listaNoticias.append(Noticia(
                    titulo: "Rodada a Huanchaco",
                    descripcion: "Acompáñanos este domingo en una ruta grupal desde el centro de Trujillo hasta la playa. ¡Prepara tu Janko!",
                    categoria: "RUTAS",
                    fecha: "28 Abr",
                    nombreImagen: "foto_huanchaco"
                ))
                
                listaNoticias.append(Noticia(
                    titulo: "Cosecha Responsable",
                    descripcion: "El bambú de nuestros nuevos marcos es seleccionado cuidadosamente para no alterar el ecosistema de nuestros valles.",
                    categoria: "SOSTENIBILIDAD",
                    fecha: "22 Abr",
                    nombreImagen: "foto_cosecha"
                ))
                
                listaNoticias.append(Noticia(
                    titulo: "Nueva Estación en Trujillo",
                    descripcion: "Hemos habilitado un punto de aire y herramientas básicas cerca del estadio Mansiche para todos los ciclistas.",
                    categoria: "COMUNIDAD",
                    fecha: "18 Abr",
                    nombreImagen: "foto_estacion"
                ))
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaNoticias.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticiasCell", for: indexPath) as! NoticiaTableViewCell
        
        let noticiaActual = listaNoticias[indexPath.row]
        
        cell.lblTitulo.text = noticiaActual.titulo
        cell.lblDescripcion.text = noticiaActual.descripcion
        cell.lblFecha.text = noticiaActual.fecha
        cell.lblCategoriaTexto.text = noticiaActual.categoria
        
        cell.imgNoticia.image = UIImage(named: noticiaActual.nombreImagen)
        
        if noticiaActual.categoria == "SOSTENIBILIDAD" {
            cell.viewCategoriaFondo.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            cell.lblCategoriaTexto.textColor = .systemGreen
            
        } else if noticiaActual.categoria == "RUTAS" {
            cell.viewCategoriaFondo.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
            cell.lblCategoriaTexto.textColor = .systemBlue
            
        } else {
            cell.viewCategoriaFondo.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.2)
            cell.lblCategoriaTexto.textColor = .systemOrange
        }
        
        return cell
    }
}
