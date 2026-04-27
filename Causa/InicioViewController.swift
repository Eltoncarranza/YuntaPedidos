import UIKit
import MapKit // Necesario para abrir los mapas

// Estructura de datos para nuestras rutas


class InicioViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var miScrollView: UIScrollView!
    @IBOutlet weak var miPageControl: UIPageControl!
    
    // 🔌 NUEVO: Conecta este cable a tu Collection View de abajo
    @IBOutlet weak var rutasCollectionView: UICollectionView!
    
    // Variables del carrusel superior
    var temporizador: Timer?
    var paginaActual = 0
    let totalPaginas = 3

    // Variables de las rutas
    var listaRutas: [RutaRecomendada] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuración Carrusel Superior
        if miScrollView != nil {
            miScrollView.delegate = self
        }
        configurarPageControl()
        iniciarTemporizador()
        
        // Configuración Carrusel Inferior (Rutas)
        if rutasCollectionView != nil {
            rutasCollectionView.delegate = self
            rutasCollectionView.dataSource = self
            rutasCollectionView.showsHorizontalScrollIndicator = false
        }
        
        cargarRutasLocales()
    }
    
    // MARK: - Datos de Rutas
    func cargarRutasLocales() {
        listaRutas = [
            RutaRecomendada(titulo: "Ruta Marinera", distancia: "12 km", calorias: "300 kcal", nombreImagen: "foto_huanchaco", destino: "Muelle de Huanchaco, Trujillo, Peru"),
            RutaRecomendada(titulo: "Ruta del Sol", distancia: "8 km", calorias: "200 kcal", nombreImagen: "foto_ruta", destino: "Huacas del Sol y de la Luna, Peru"),
            RutaRecomendada(titulo: "Circuito Cañero", distancia: "5 km", calorias: "150 kcal", nombreImagen: "Urbanas", destino: "Laredo, Trujillo, Peru")
        ]
        rutasCollectionView?.reloadData()
    }

    // MARK: - Collection View Logic (Rutas)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaRutas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "TourCell", for: indexPath) as! TourCell
        
        let ruta = listaRutas[indexPath.item]
        celda.configurar(con: ruta)
        
        // Aquí le decimos a la celda qué hacer cuando presionen SU botón
        celda.accionVerRuta = { [weak self] in
            self?.abrirAppleMaps(destino: ruta.destino)
        }
        
        return celda
    }
    
    // MARK: - Navegación (Mapas)
    func abrirAppleMaps(destino: String) {
        // daddr = Destination Address | dirflg=b = Modo Bicicleta
        let urlString = "http://maps.apple.com/?daddr=\(destino)&dirflg=b"
        
        if let urlCodificada = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlCodificada) {
            // Abre la app de mapas oficial del iPhone
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    // MARK: - Lógica Carrusel Superior (Tu código original intacto)
    
    func configurarPageControl() {
        if miPageControl != nil {
            miPageControl.numberOfPages = totalPaginas
            miPageControl.currentPage = 0
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Evitamos que el CollectionView afecte el PageControl del ScrollView
        if scrollView == miScrollView {
            guard scrollView.frame.width > 0 else { return }
            let valorPagina = round(scrollView.contentOffset.x / scrollView.frame.width)
            miPageControl.currentPage = Int(valorPagina)
            paginaActual = Int(valorPagina)
        }
    }

    func iniciarTemporizador() {
        temporizador = Timer.scheduledTimer(timeInterval: 10.0,
                                            target: self,
                                            selector: #selector(moverAlSiguiente),
                                            userInfo: nil,
                                            repeats: true)
    }
    
    @objc func moverAlSiguiente() {
        paginaActual += 1
        if paginaActual == totalPaginas {
            paginaActual = 0
        }
        if let anchoPantalla = miScrollView?.frame.width {
            let posicionX = CGFloat(paginaActual) * anchoPantalla
            miScrollView?.setContentOffset(CGPoint(x: posicionX, y: 0), animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        temporizador?.invalidate()
    }
}
