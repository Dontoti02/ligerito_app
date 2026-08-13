// lib/features/auth/presentation/screens/registro_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/utils/validators.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class RegistroScreen extends ConsumerStatefulWidget {
  const RegistroScreen({super.key});

  @override
  ConsumerState<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends ConsumerState<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(sesionControllerProvider.notifier).registrar(
          _nombreCtrl.text.trim(),
          _telefonoCtrl.text.trim(),
          _passwordCtrl.text,
          email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        );
    if (!mounted) return;
    final sesion = ref.read(sesionControllerProvider).valueOrNull;
    if (sesion is SesionAutenticada) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.registroExito),
          backgroundColor: LigeritoColors.secondary,
        ),
      );
      context.go('/login');
    } else if (sesion is SesionNoAutenticada && sesion.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(sesion.error!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sesion = ref.watch(sesionControllerProvider);
    final isLoading = sesion.valueOrNull is SesionCargando;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/logo.png',
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.registroTitulo,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.tagline,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nombreCtrl,
                validator: LigeritoValidators.nombreObligatorio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: l10n.registroNombre,
                  prefixIcon: const Icon(Icons.person_outline),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoCtrl,
                validator: LigeritoValidators.telefono,
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: l10n.loginTelefono,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: l10n.registroEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordCtrl,
                validator: LigeritoValidators.password,
                obscureText: _obscurePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: l10n.loginPassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.registroBoton),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/login'),
                child: RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      const TextSpan(text: '¿Ya tienes cuenta? '),
                      TextSpan(
                        text: 'Inicia sesión',
                        style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
