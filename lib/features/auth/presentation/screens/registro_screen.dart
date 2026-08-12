import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/utils/validators.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/ligerito_text_field.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/features/auth/presentation/widgets/auth_header.dart';
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthHeader(
                  title: l10n.registroTitulo,
                  subtitle: l10n.tagline,
                ),
                LigeritoTextField(
                  label: l10n.registroNombre,
                  controller: _nombreCtrl,
                  validator: LigeritoValidators.nombreObligatorio,
                ),
                const SizedBox(height: 16),
                LigeritoTextField(
                  label: l10n.loginTelefono,
                  hint: '999123456',
                  controller: _telefonoCtrl,
                  validator: LigeritoValidators.telefono,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                LigeritoTextField(
                  label: l10n.registroEmail,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                LigeritoTextField(
                  label: l10n.loginPassword,
                  controller: _passwordCtrl,
                  validator: LigeritoValidators.password,
                  obscureText: _obscurePassword,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: LigeritoColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 8),
                LigeritoButton(
                  label: l10n.registroBoton,
                  onPressed: _submit,
                  loading: isLoading,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: '¿Ya tienes cuenta? '),
                        TextSpan(
                          text: 'Inicia sesión',
                          style: const TextStyle(
                            color: LigeritoColors.primary,
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
      ),
    );
  }
}
