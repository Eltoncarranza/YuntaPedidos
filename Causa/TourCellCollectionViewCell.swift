import UIKit

class TourCellCollectionViewCell: UICollectionViewCell {
    
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
            
            lblDetalles.text = "🚲 \(ruta.distancia)   🔥 \(ruta.calorias)"
            
            contentView.layer.cornerRadius = 12
            contentView.layer.masksToBounds = true
            contentView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        }
    }

