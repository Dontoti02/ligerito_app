import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/utils/validators.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/ligerito_text_field.dart';
import 'package:ligerito/features/auth/presentation/widgets/auth_header.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class RecuperarScreen extends StatefulWidget {
  const RecuperarScreen({super.key});

  @override
  State<RecuperarScreen> createState() => _RecuperarScreenState();
}

class _RecuperarScreenState extends State<RecuperarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _telefonoCtrl = TextEditingController();
  bool _enviado = false;

  @override
  void dispose() {
    _telefonoCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _enviado = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                  title: l10n.recuperarTitulo,
                  subtitle: l10n.recuperarMensaje,
                ),
                if (_enviado) ...[
                  const Icon(Icons.check_circle_outline,
                      size: 64, color: LigeritoColors.secondary),
                  const SizedBox(height: 16),
                  Text(
                    'Te enviaremos las instrucciones a tu teléfono ${_telefonoCtrl.text}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  LigeritoButton(
                    label: l10n.comunAceptar,
                    onPressed: () => context.go('/login'),
                  ),
                ] else ...[
                  LigeritoTextField(
                    label: l10n.loginTelefono,
                    hint: '999123456',
                    controller: _telefonoCtrl,
                    validator: LigeritoValidators.telefono,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  LigeritoButton(
                    label: l10n.recuperarBoton,
                    onPressed: _submit,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
