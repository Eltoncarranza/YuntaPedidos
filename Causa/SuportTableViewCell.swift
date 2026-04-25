import UIKit

class SuportTableViewCell: UITableViewCell {

    @IBOutlet weak var PreguntaLabel: UILabel!
    @IBOutlet weak var RespuestaLabel: UILabel!
    @IBOutlet weak var viewContenedor: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        
        PreguntaLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        PreguntaLabel.textColor = UIColor(white: 0.1, alpha: 1.0)
        RespuestaLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        RespuestaLabel.textColor = .darkGray
    }

    func configurarCelda(item: Suport) {
        PreguntaLabel.text = item.pregunta
        RespuestaLabel.text = item.respuesta
        RespuestaLabel.isHidden = !item.expandida
    }
}
