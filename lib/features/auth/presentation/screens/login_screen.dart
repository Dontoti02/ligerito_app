// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/utils/validators.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/ligerito_text_field.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/features/auth/presentation/widgets/auth_header.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _telefonoCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _telefonoCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(sesionControllerProvider.notifier).iniciarSesion(
          _telefonoCtrl.text.trim(),
          _passwordCtrl.text,
        );
    if (!mounted) return;
    final sesion = ref.read(sesionControllerProvider).valueOrNull;
    if (sesion is SesionAutenticada) {
      final ruta = sesion.usuario.rol == RolUsuario.negocio
          ? '/panel/pedidos'
          : '/home';
      context.go(ruta);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.loginErrorCredenciales),
          backgroundColor: LigeritoColors.error,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthHeader(
                  title: l10n.loginTitulo,
                  subtitle: l10n.loginSubtitulo,
                ),
                LigeritoTextField(
                  label: l10n.loginTelefono,
                  hint: '999123456',
                  controller: _telefonoCtrl,
                  validator: LigeritoValidators.telefono,
                  keyboardType: TextInputType.number,
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
                  label: l10n.loginBoton,
                  onPressed: _submit,
                  loading: isLoading,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.go('/recuperar'),
                  child: Text(
                    l10n.loginOlvidaste,
                    style: const TextStyle(color: LigeritoColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.go('/registro'),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: '${l10n.loginSinCuenta.split('? ')[0]}? ',
                        ),
                        TextSpan(
                          text: l10n.loginSinCuenta.split('? ').last,
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
