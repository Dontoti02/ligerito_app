// test/features/carrito/domain/entities/item_carrito_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';

Producto makeProducto({int precioEnCentavos = 1500}) => Producto(
      id: 'p1',
      negocioId: 'n1',
      nombre: 'Producto Test',
      precioEnCentavos: precioEnCentavos,
      disponible: true,
    );

void main() {
  group('ItemCarrito.subtotalEnCentavos', () {
    test('multiplica precio por cantidad', () {
      final item = ItemCarrito(
        producto: makeProducto(precioEnCentavos: 2000),
        cantidad: 3,
      );
      expect(item.subtotalEnCentavos, 6000);
    });

    test('cantidad 1 retorna el precio unitario', () {
      final item = ItemCarrito(
        producto: makeProducto(precioEnCentavos: 1500),
        cantidad: 1,
      );
      expect(item.subtotalEnCentavos, 1500);
    });

    test('cantidad grande no desborda', () {
      final item = ItemCarrito(
        producto: makeProducto(precioEnCentavos: 100),
        cantidad: 9999,
      );
      expect(item.subtotalEnCentavos, 999900);
    });
  });

  group('ItemCarrito factory', () {
    test('crea instancia con campos requeridos', () {
      final item = ItemCarrito(
        producto: makeProducto(),
        cantidad: 2,
      );
      expect(item.producto.nombre, 'Producto Test');
      expect(item.cantidad, 2);
      expect(item.notas, isNull);
    });

    test('notas opcionales funcionan', () {
      final item = ItemCarrito(
        producto: makeProducto(),
        cantidad: 1,
        notas: 'Sin cebolla',
      );
      expect(item.notas, 'Sin cebolla');
    });
  });
}
