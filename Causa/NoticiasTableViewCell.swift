import UIKit

class NoticiaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgNoticia: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var viewCategoriaFondo: UIView!
    @IBOutlet weak var lblCategoriaTexto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        viewCategoriaFondo.layer.cornerRadius = 10
    }
}
