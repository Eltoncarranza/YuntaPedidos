import UIKit

class InicioViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var miScrollView: UIScrollView!
    @IBOutlet weak var miPageControl: UIPageControl!
    
    var temporizador: Timer?
    var paginaActual = 0
    let totalPaginas = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        if miScrollView != nil {
            miScrollView.delegate = self
        }
        
        configurarPageControl()
        iniciarTemporizador()
    }
    
    func configurarPageControl() {
        if miPageControl != nil {
            miPageControl.numberOfPages = totalPaginas
            miPageControl.currentPage = 0
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard scrollView.frame.width > 0 else { return }
        let valorPagina = round(scrollView.contentOffset.x / scrollView.frame.width)
        miPageControl.currentPage = Int(valorPagina)
        paginaActual = Int(valorPagina)
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
