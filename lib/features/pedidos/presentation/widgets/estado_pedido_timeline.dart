import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';

class EstadoPedidoTimeline extends StatelessWidget {
  final EstadoPedido estadoActual;

  const EstadoPedidoTimeline({super.key, required this.estadoActual});

  static const _estados = [
    EstadoPedido.pendiente,
    EstadoPedido.confirmado,
    EstadoPedido.preparando,
    EstadoPedido.enCamino,
    EstadoPedido.entregado,
  ];

  static const _labels = {
    EstadoPedido.pendiente: 'Pendiente',
    EstadoPedido.confirmado: 'Confirmado',
    EstadoPedido.preparando: 'Preparando',
    EstadoPedido.enCamino: 'En camino',
    EstadoPedido.entregado: 'Entregado',
  };

  int _index(EstadoPedido e) => _estados.indexOf(e);

  @override
  Widget build(BuildContext context) {
    final currentIdx = _index(estadoActual);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: LigeritoColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            for (int i = 0; i < _estados.length; i++) ...[
              _TimelineStep(
                label: _labels[_estados[i]]!,
                status: i < currentIdx
                    ? _StepStatus.done
                    : i == currentIdx
                        ? _StepStatus.current
                        : _StepStatus.pending,
              ),
              if (i < _estados.length - 1)
                _TimelineLine(
                  status: i < currentIdx
                      ? _LineStatus.done
                      : i == currentIdx
                          ? _LineStatus.transitioning
                          : _LineStatus.pending,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

enum _StepStatus { done, current, pending }
enum _LineStatus { done, transitioning, pending }

class _TimelineStep extends StatelessWidget {
  final String label;
  final _StepStatus status;

  const _TimelineStep({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDot(),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: status == _StepStatus.pending ? FontWeight.w400 : FontWeight.w600,
            color: status == _StepStatus.pending
                ? LigeritoColors.textSecondary
                : LigeritoColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDot() {
    switch (status) {
      case _StepStatus.done:
        return Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: LigeritoColors.secondary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 14, color: Colors.white),
        );
      case _StepStatus.current:
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: LigeritoColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: LigeritoColors.primary.withValues(alpha: 0.4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.circle, size: 10, color: Colors.white),
        );
      case _StepStatus.pending:
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFBDBDBD), width: 2),
          ),
        );
    }
  }
}

class _TimelineLine extends StatelessWidget {
  final _LineStatus status;

  const _TimelineLine({required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9),
      child: Container(
        width: 2,
        height: 32,
        decoration: switch (status) {
          _LineStatus.done => const BoxDecoration(color: LigeritoColors.secondary),
          _LineStatus.transitioning => BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [LigeritoColors.secondary, Color(0xFFBDBDBD)],
              ),
            ),
          _LineStatus.pending => const BoxDecoration(color: Color(0xFFBDBDBD)),
        },
      ),
    );
  }
}
