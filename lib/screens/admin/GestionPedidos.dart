import 'package:enrique_masegosac1/l10n/app_localizations.dart';
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

  String _estadoToText(Pedidos estado, AppLocalizations l10n) {
    switch (estado) {
      case Pedidos.pedido:
        return l10n.ordered;
      case Pedidos.produccion:
        return l10n.inProduction;
      case Pedidos.reparto:
        return l10n.inDelivery;
      case Pedidos.entregado:
        return l10n.delivered;
    }
  }

  Pedidos _textToEstado(String text, AppLocalizations l10n) {
    switch (text) {
      case 'En Producción':
      case 'In Production':
        return Pedidos.produccion;
      case 'En Reparto':
      case 'In Delivery':
        return Pedidos.reparto;
      case 'Entregado':
      case 'Delivered':
        return Pedidos.entregado;
      case 'Pedido':
      case 'Ordered':
      default:
        return Pedidos.pedido;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pedidos = _controladorPedidosAdmin.getTodosPedidos();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.orderManagement),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: pedidos.isEmpty
          ? Center(child: Text(l10n.noRegisteredOrders))
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
                      l10n.orderId(order.id),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${l10n.user}: ${order.userName}\n'
                      '${l10n.date}: ${order.fecha}\n'
                      '${l10n.total}: ${order.total.toStringAsFixed(2)} €',
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Text('${l10n.status}: '),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _estadoToText(order.estado, l10n),
                              items: [
                                DropdownMenuItem(
                                  value: l10n.ordered,
                                  child: Text(l10n.ordered),
                                ),
                                DropdownMenuItem(
                                  value: l10n.inProduction,
                                  child: Text(l10n.inProduction),
                                ),
                                DropdownMenuItem(
                                  value: l10n.inDelivery,
                                  child: Text(l10n.inDelivery),
                                ),
                                DropdownMenuItem(
                                  value: l10n.delivered,
                                  child: Text(l10n.delivered),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                final nuevoEstado = _textToEstado(value, l10n);
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
                            '${l10n.quantity}: ${item.cantidad}\n'
                            '${l10n.subtotal}: ${item.subtotal.toStringAsFixed(2)} €',
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
