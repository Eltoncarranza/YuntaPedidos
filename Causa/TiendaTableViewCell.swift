import UIKit

// Fíjate que le agregamos el UICollectionViewDelegateFlowLayout para el tamaño manual
class TiendaTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // 🔌 Cables de tu celda
    @IBOutlet weak var lblTituloSeccion: UILabel!
    @IBOutlet weak var miCollectionView: UICollectionView!
    
    var listaProductos: [Producto] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Configuramos el Collection View interno
        miCollectionView.delegate = self
        miCollectionView.dataSource = self
        
        // Quita la barra de scroll horizontal para que se vea más limpio
        miCollectionView.showsHorizontalScrollIndicator = false
    }

    // Recibe los datos desde el TiendaViewController
    func configurarSeccion(titulo: String, productos: [Producto]) {
        lblTituloSeccion.text = titulo
        self.listaProductos = productos
        miCollectionView.reloadData()
    }

    // MARK: - Métodos del Collection View (El Carrusel)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaProductos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCell", for: indexPath) as! ProductoCollectionViewCell
        
        celda.configurar(con: listaProductos[indexPath.item])
        return celda
    }
    
    // MARK: - Tamaño Manual (El truco del Estimate Size: None)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Le decimos a Xcode exactamente de qué tamaño queremos la tarjeta
        return CGSize(width: 170, height: 260)
    }
    
    // Opcional: Espacio entre las tarjetas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
}
