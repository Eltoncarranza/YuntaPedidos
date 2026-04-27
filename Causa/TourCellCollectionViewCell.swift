import UIKit

class TourCell: UICollectionViewCell {
    
    // 🔌 Cables de la tarjeta
    @IBOutlet weak var imgRuta: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDetalles: UILabel!
    
    var accionVerRuta: (() -> Void)?
    
    @IBAction func btnVerRutaTapped(_ sender: UIButton) {
        accionVerRuta?()
    }
        
    func configurar(con ruta: RutaRecomendada) {
        imgRuta.image = UIImage(named: ruta.nombreImagen)
        lblTitulo.text = ruta.titulo
        
        // Aquí unimos los datos separados
        lblDetalles.text = "🚲 \(ruta.distancia)   🔥 \(ruta.calorias)"
        
        // Diseño visual
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        
        
    }
}
