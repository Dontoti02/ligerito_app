import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

class DireccionCard extends StatelessWidget {
  final Direccion direccion;
  final VoidCallback? onEditar;
  final VoidCallback? onEliminar;

  const DireccionCard({
    super.key,
    required this.direccion,
    this.onEditar,
    this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final etiquetaLower = direccion.etiqueta.toLowerCase();
    final iconData = etiquetaLower == 'casa'
        ? Icons.home_rounded
        : etiquetaLower == 'trabajo'
            ? Icons.business_rounded
            : Icons.location_on_rounded;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: LigeritoColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: LigeritoColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(iconData, color: LigeritoColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        direccion.etiqueta,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: LigeritoColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        direccion.direccionTexto,
                        style: const TextStyle(
                          fontSize: 13,
                          color: LigeritoColors.textSecondary,
                        ),
                      ),
                      if (direccion.referencia != null &&
                          direccion.referencia!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Ref: ${direccion.referencia}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: LigeritoColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: onEditar,
                  child: const Text(
                    'Editar',
                    style: TextStyle(
                      color: LigeritoColors.info,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onEliminar,
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(
                      color: LigeritoColors.error,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
