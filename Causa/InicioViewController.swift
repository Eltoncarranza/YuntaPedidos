import UIKit

class InicioViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var miScrollView: UIScrollView!
    @IBOutlet weak var miPageControl: UIPageControl!
    
    @IBOutlet weak var tablaInicio: UITableView!
    
    var temporizador: Timer?
    var paginaActual = 0
    let totalPaginas = 3
    var rutasLocales: [RutaRecomendada] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if miScrollView != nil {
            miScrollView.delegate = self
        }
        configurarPageControl()
        iniciarTemporizador()
        
        if tablaInicio != nil {
            tablaInicio.delegate = self
            tablaInicio.dataSource = self
            tablaInicio.separatorStyle = .none
            tablaInicio.allowsSelection = false
        }
        
        cargarRutasLocales()
    }
    
    func cargarRutasLocales() {
        rutasLocales = [
            RutaRecomendada(titulo: "Ruta Marinera", distancia: "12 km", calorias: "300 kcal", nombreImagen: "Ruta1", destino: "Muelle de Huanchaco, Trujillo, Peru"),
            RutaRecomendada(titulo: "Ruta del Sol", distancia: "8 km", calorias: "200 kcal", nombreImagen: "Ruta2", destino: "Huacas del Sol y de la Luna, Peru"),
            RutaRecomendada(titulo: "Circuito Cañero", distancia: "5 km", calorias: "150 kcal", nombreImagen: "Ruta3", destino: "Laredo, Trujillo, Peru")
        ]
        tablaInicio?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let celda = tableView.dequeueReusableCell(withIdentifier: "RutasTableViewCell", for: indexPath) as! RutasTableViewCell
        
        celda.configurar(rutas: rutasLocales)
        
        celda.accionAbrirMapa = { [weak self] destinoSeleccionado in
            self?.abrirAppleMaps(destino: destinoSeleccionado)
        }
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func abrirAppleMaps(destino: String) {
        let urlString = "http://maps.apple.com/?daddr=\(destino)&dirflg=b"
        if let urlCodificada = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlCodificada) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func configurarPageControl() {
        if miPageControl != nil {
            miPageControl.numberOfPages = totalPaginas
            miPageControl.currentPage = 0
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == miScrollView {
            guard scrollView.frame.width > 0 else { return }
            let valorPagina = round(scrollView.contentOffset.x / scrollView.frame.width)
            miPageControl.currentPage = Int(valorPagina)
            paginaActual = Int(valorPagina)
        }
    }

    func iniciarTemporizador() {
        temporizador = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(moverAlSiguiente), userInfo: nil, repeats: true)
    }
    
    @objc func moverAlSiguiente() {
        paginaActual += 1
        if paginaActual == totalPaginas { paginaActual = 0 }
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
