import Foundation

class CarritoManager {
    
    static let shared = CarritoManager()
    private init() {}
    
    var listaDeCompras: [Producto] = []
    
    func agregarProducto(_ producto: Producto) {
        listaDeCompras.append(producto)
    }
    
    func eliminarProducto(en index: Int) {
        guard index < listaDeCompras.count else { return }
        listaDeCompras.remove(at: index)
    }
    
    func calcularTotal() -> Double {
        return listaDeCompras.reduce(0) { $0 + $1.precio }
    }
    func vaciarCarrito() {
        listaDeCompras.removeAll()
    }
}
