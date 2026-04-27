import UIKit
import CoreData

class CarritoManager {
    static let shared = CarritoManager()
    
    // Conexión al contexto de Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}

    // GUARDAR: Agrega el producto a la base de datos local
    func agregarProducto(_ producto: Producto) {
        let nuevoItem = CarritoItem(context: self.context)
        nuevoItem.id = producto.id
        nuevoItem.nombre = producto.nombre
        nuevoItem.precio = producto.precio
        nuevoItem.nombreImagen = producto.nombreImagen
        
        guardarContexto()
    }

    // LEER: Recupera todo lo guardado para mostrarlo en la tabla
    func obtenerProductos() -> [Producto] {
        var lista: [Producto] = []
        let request: NSFetchRequest<CarritoItem> = CarritoItem.fetchRequest()
        
        do {
            let itemsBD = try context.fetch(request)
            for item in itemsBD {
                let p = Producto(id: item.id ?? "",
                                 nombre: item.nombre ?? "",
                                 precio: item.precio,
                                 nombreImagen: item.nombreImagen ?? "")
                lista.append(p)
            }
        } catch {
            print("Error al cargar Core Data: \(error)")
        }
        return lista
    }
    
    // ELIMINAR: Borra un objeto específico (útil para el swipe de la tabla)
    func eliminarProducto(nombre: String) {
        let request: NSFetchRequest<CarritoItem> = CarritoItem.fetchRequest()
        request.predicate = NSPredicate(format: "nombre == %@", nombre)
        
        if let result = try? context.fetch(request), let itemABorrar = result.first {
            context.delete(itemABorrar)
            guardarContexto()
        }
    }

    // VACIAR: Limpia todo después de comprar o cerrar sesión
    func vaciarCarrito() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CarritoItem.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            guardarContexto()
        } catch {
            print("Error al vaciar: \(error)")
        }
    }

    func calcularTotal() -> Double {
        return obtenerProductos().reduce(0) { $0 + $1.precio }
    }

    private func guardarContexto() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error al guardar: \(error)")
            }
        }
    }
}
