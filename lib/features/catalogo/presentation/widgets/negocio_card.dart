// lib/features/catalogo/presentation/widgets/negocio_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';

class NegocioCard extends StatelessWidget {
  final Negocio negocio;
  final VoidCallback? onTap;

  const NegocioCard({super.key, required this.negocio, this.onTap});

  static const List<List<Color>> _gradientPairs = [
    [Color(0xFFE63946), Color(0xFFFF6B6B)],
    [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    [Color(0xFF1976D2), Color(0xFF42A5F5)],
    [Color(0xFF7B1FA2), Color(0xFFAB47BC)],
    [Color(0xFFE65100), Color(0xFFFF8A65)],
    [Color(0xFF00695C), Color(0xFF26A69A)],
  ];

  @override
  Widget build(BuildContext context) {
    final gradientIndex = negocio.id.hashCode.abs() % _gradientPairs.length;
    final gradient = _gradientPairs[gradientIndex];
    final initials = negocio.nombre.length >= 2
        ? negocio.nombre.substring(0, 2).toUpperCase()
        : negocio.nombre.toUpperCase();

    return Opacity(
      opacity: negocio.abierto ? 1.0 : 0.55,
      child: Card(
        color: LigeritoColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initials,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        negocio.nombre,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: LigeritoColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _StatusBadge(abierto: negocio.abierto),
                          const SizedBox(width: 8),
                          const Icon(Icons.star_rounded,
                              size: 16, color: LigeritoColors.warning),
                          const SizedBox(width: 2),
                          Text(
                            negocio.calificacion.toStringAsFixed(1),
                            style: LigeritoTextStyles.body,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.access_time_rounded,
                              size: 16, color: LigeritoColors.textSecondary),
                          const SizedBox(width: 2),
                          Text(
                            '${negocio.tiempoEstimadoMin} min',
                            style: LigeritoTextStyles.bodySecondary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Envío S/ ${negocio.costoEnvioBase.toStringAsFixed(2)} · Mín. S/ ${negocio.pedidoMinimo.toStringAsFixed(2)}',
                        style: LigeritoTextStyles.bodySecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool abierto;

  const _StatusBadge({required this.abierto});

  @override
  Widget build(BuildContext context) {
    final color = abierto ? LigeritoColors.secondary : LigeritoColors.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        abierto ? 'Abierto' : 'Cerrado',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
