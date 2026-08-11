// lib/features/catalogo/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/catalogo/presentation/providers/catalogo_providers.dart';
import 'package:ligerito/features/catalogo/presentation/widgets/negocio_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'todos';

  static const _categories = [
    'todos',
    'restaurante',
    'farmacia',
    'mercado',
    'ferreteria',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final negociosAsync = ref.watch(negociosProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '¿Qué se te antoja hoy?',
              style: LigeritoTextStyles.heading1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Buscar negocios...',
                prefixIcon: const Icon(Icons.search_rounded,
                    color: LigeritoColors.textSecondary),
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(
                    category[0].toUpperCase() + category.substring(1),
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : LigeritoColors.textPrimary,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = category),
                  selectedColor: LigeritoColors.primary,
                  backgroundColor: const Color(0xFFEEEEEE),
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: negociosAsync.when(
              loading: () => const LigeritoListSkeleton(),
              error: (error, _) => Center(
                child: Text(
                  'Error al cargar: $error',
                  style: LigeritoTextStyles.bodySecondary,
                ),
              ),
              data: (negocios) {
                final filtered = negocios.where((n) {
                  final matchSearch = n.nombre
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                  final matchCategory = _selectedCategory == 'todos' ||
                      n.categoria.toLowerCase() == _selectedCategory;
                  return matchSearch && matchCategory;
                }).toList();

                if (filtered.isEmpty) {
                  return const EmptyStateView(
                    icon: Icons.storefront_rounded,
                    title: 'No se encontraron negocios',
                    subtitle: 'Intenta con otra búsqueda o categoría',
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final negocio = filtered[index];
                    return NegocioCard(
                      negocio: negocio,
                      onTap: () =>
                          context.push('/negocio/${negocio.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
