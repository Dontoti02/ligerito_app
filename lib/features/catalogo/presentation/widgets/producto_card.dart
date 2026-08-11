import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback? onTap;

  const ProductoCard({super.key, required this.producto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: producto.disponible ? 1.0 : 0.5,
      child: Card(
        color: LigeritoColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        producto.nombre,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: LigeritoColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (producto.descripcion != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          producto.descripcion!,
                          style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        CurrencyFormatter.formatoPen(producto.precioEnCentavos),
                        style: LigeritoTextStyles.price,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: producto.imagenUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            producto.imagenUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => _placeholderIcon,
                          ),
                        )
                      : _placeholderIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static final _placeholderIcon = const Center(
    child: Icon(Icons.fastfood_rounded, size: 28, color: Color(0xFFBDBDBD)),
  );
}
