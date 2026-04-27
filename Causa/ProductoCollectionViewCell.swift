import UIKit

class ProductoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    
  
    var productoActual: Producto?

    @IBAction func btnAgregarTapped(_ sender: UIButton) {
        guard let producto = productoActual else { return }

        CarritoManager.shared.agregarProducto(producto)
        
        let colorOriginal = sender.backgroundColor
        sender.backgroundColor = UIColor.gray
        sender.setTitle("Agregado ✅", for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.backgroundColor = colorOriginal
            sender.setTitle("Agregar", for: .normal)
        }
    }
    
    func configurar(con producto: Producto) {
        self.productoActual = producto
        lblNombre.text = producto.nombre
        lblPrecio.text = String(format: "S/ %.2f", producto.precio)
        imgProducto.image = UIImage(named: producto.nombreImagen)
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        imgProducto.layer.cornerRadius = 12
        // Ajustamos para que las esquinas de abajo de la imagen no sean redondas
        imgProducto.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgProducto.clipsToBounds = true
    }
}
