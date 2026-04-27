import UIKit

class RutasTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewRutas: UICollectionView!
    
    var listaRutas: [RutaRecomendada] = []
    
    var accionAbrirMapa: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewRutas.delegate = self
        collectionViewRutas.dataSource = self
        collectionViewRutas.showsHorizontalScrollIndicator = false
    }

    func configurar(rutas: [RutaRecomendada]) {
        self.listaRutas = rutas
        collectionViewRutas.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaRutas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "TourCell", for: indexPath) as! TourCell
        
        let ruta = listaRutas[indexPath.item]
        celda.configurar(con: ruta)
        
        celda.accionVerRuta = { [weak self] in
            self?.accionAbrirMapa?(ruta.destino)
        }
        
        return celda
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 230)
    }
}
