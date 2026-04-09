import UIKit

class SuportTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var PreguntaLabel: UILabel!
    
    @IBOutlet weak var RespuestaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configuración para que la respuesta pueda crecer
        RespuestaLabel.numberOfLines = 0
    }
}
