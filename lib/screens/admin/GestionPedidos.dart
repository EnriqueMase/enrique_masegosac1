import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/controllers/administrador/controlador_pedidos_admin.dart';
import 'package:enrique_masegosac1/models/pedidos.dart';

class GestionPedidosPage extends StatefulWidget {
  const GestionPedidosPage({super.key});
  @override
  State<GestionPedidosPage> createState() => _GestionPedidosPageState();
}

class _GestionPedidosPageState extends State<GestionPedidosPage> {
  final ControladorPedidosAdmin _controladorPedidosAdmin =
      ControladorPedidosAdmin();

  String _estadoToText(Pedidos estado) {
    switch (estado) {
      case Pedidos.pedido:
        return 'Pedido';
      case Pedidos.produccion:
        return 'En Producción';
      case Pedidos.reparto:
        return 'En Reparto';
      case Pedidos.entregado:
        return 'Entregado';
    }
  }

  Pedidos _textToEstado(String text) {
    switch (text) {
      case 'En Producción':
        return Pedidos.produccion;
      case 'En Reparto':
        return Pedidos.reparto;
      case 'Entregado':
        return Pedidos.entregado;
      case 'Pedido':
      default:
        return Pedidos.pedido;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pedidos = _controladorPedidosAdmin.getTodosPedidos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de pedidos'),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: pedidos.isEmpty
          ? const Center(child: Text('No hay pedidos registrados'))
          : ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final order = pedidos[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ExpansionTile(
                    title: Text(
                      'Pedido ${order.id}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Usuario: ${order.userName}\n'
                      'Fecha: ${order.fecha}\n'
                      'Total: ${order.total.toStringAsFixed(2)} €',
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            const Text('Estado: '),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _estadoToText(order.estado),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Pedido',
                                  child: Text('Pedido'),
                                ),
                                DropdownMenuItem(
                                  value: 'En Producción',
                                  child: Text('En Producción'),
                                ),
                                DropdownMenuItem(
                                  value: 'En Reparto',
                                  child: Text('En Reparto'),
                                ),
                                DropdownMenuItem(
                                  value: 'Entregado',
                                  child: Text('Entregado'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                final nuevoEstado = _textToEstado(value);
                                _controladorPedidosAdmin.cambiarEstadoPedido(
                                  order.id,
                                  nuevoEstado,
                                );
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      ...order.items.map(
                        (item) => ListTile(
                          title: Text(item.productos.nombre),
                          subtitle: Text(
                            'Cantidad: ${item.cantidad}\n'
                            'Subtotal: ${item.subtotal.toStringAsFixed(2)} €',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
