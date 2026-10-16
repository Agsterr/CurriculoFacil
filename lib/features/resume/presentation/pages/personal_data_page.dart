import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';
import '../widgets/profile_image_picker.dart';

class PersonalDataPage extends ConsumerStatefulWidget {
  const PersonalDataPage({super.key});

  @override
  ConsumerState<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends ConsumerState<PersonalDataPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final resume = ref.watch(currentCurriculoServiceProvider);
    final notifier = ref.read(currentCurriculoServiceProvider.notifier);

    if (resume == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Dados Pessoais')),
        body: EmptyState(
          icon: Icons.description_outlined,
          title: 'Nenhum currículo selecionado',
          message: 'Selecione ou crie um currículo para editar.',
          actionLabel: 'Ir para Meus Currículos',
          onAction: () => context.go('/'),
        ),
      );
    }

    final personalData = resume.personalData;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Dados Pessoais'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const SizedBox(height: 8),
            const ProfileImagePicker(),
            const SizedBox(height: 24),
            FormSectionCard(
              title: 'Identificação',
              icon: Icons.badge_outlined,
              children: [
                // Resume Title
                TextFormField(
                  initialValue: resume.title,
                  decoration: const InputDecoration(
                    labelText: 'Título do Currículo',
                    prefixIcon: Icon(Icons.title),
                    hintText: 'Ex: Currículo 2025',
                  ),
                  onChanged: (value) => notifier.updateResume(
                    resume.copyWith(title: value),
                  ),
                ),
                const SizedBox(height: 16),

                // Full Name
                TextFormField(
                  initialValue: personalData.fullName,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo *',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe seu nome completo';
                    }
                    if (value.trim().split(' ').length < 2) {
                      return 'Informe nome e sobrenome';
                    }
                    return null;
                  },
                  onChanged: (value) => notifier.updatePersonalData(
                    personalData.copyWith(fullName: value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FormSectionCard(
              title: 'Contato',
              icon: Icons.contact_phone_outlined,
              children: [
                // Email
                TextFormField(
                  initialValue: personalData.email,
                  decoration: const InputDecoration(
                    labelText: 'E-mail *',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe seu e-mail';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  onChanged: (value) => notifier.updatePersonalData(
                    personalData.copyWith(email: value),
                  ),
                ),
                const SizedBox(height: 16),

                // Phone
                TextFormField(
                  initialValue: personalData.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefone / WhatsApp *',
                    prefixIcon: Icon(Icons.phone_outlined),
                    hintText: '(00) 00000-0000',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe seu telefone';
                    }
                    // Basic length check for BR numbers
                    if (value.replaceAll(RegExp(r'\D'), '').length < 10) {
                      return 'Telefone inválido';
                    }
                    return null;
                  },
                  onChanged: (value) => notifier.updatePersonalData(
                    personalData.copyWith(phone: value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FormSectionCard(
              title: 'Endereço',
              icon: Icons.location_on_outlined,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: personalData.zipCode,
                        decoration: const InputDecoration(
                          labelText: 'CEP',
                          prefixIcon: Icon(Icons.markunread_mailbox_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => notifier.updatePersonalData(
                          personalData.copyWith(zipCode: value),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: personalData.city,
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                          prefixIcon: Icon(Icons.location_city_outlined),
                        ),
                        onChanged: (value) => notifier.updatePersonalData(
                          personalData.copyWith(city: value),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: personalData.street,
                        decoration: const InputDecoration(
                          labelText: 'Logradouro / Rua',
                          prefixIcon: Icon(Icons.home_outlined),
                        ),
                        onChanged: (value) => notifier.updatePersonalData(
                          personalData.copyWith(street: value),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: personalData.number,
                        decoration: const InputDecoration(
                          labelText: 'Número',
                        ),
                        onChanged: (value) => notifier.updatePersonalData(
                          personalData.copyWith(number: value),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: personalData.neighborhood,
                        decoration: const InputDecoration(
                          labelText: 'Bairro',
                          prefixIcon: Icon(Icons.holiday_village_outlined),
                        ),
                        onChanged: (value) => notifier.updatePersonalData(
                          personalData.copyWith(neighborhood: value),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: personalData.state,
                        decoration: const InputDecoration(
                          labelText: 'UF',
                          counterText: '',
                        ),
                        maxLength: 2,
                        onChanged: (value) => notifier.updatePersonalData(
                          personalData.copyWith(state: value),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            FormSectionCard(
              title: 'Links e objetivo',
              icon: Icons.link,
              children: [
                // LinkedIn
                TextFormField(
                  initialValue: personalData.linkedinUrl,
                  decoration: const InputDecoration(
                    labelText: 'LinkedIn (Opcional)',
                    prefixIcon: Icon(Icons.link),
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (value) => notifier.updatePersonalData(
                    personalData.copyWith(linkedinUrl: value),
                  ),
                ),
                const SizedBox(height: 16),

                // Portfolio
                TextFormField(
                  initialValue: personalData.portfolioUrl,
                  decoration: const InputDecoration(
                    labelText: 'Portfólio / Site (Opcional)',
                    prefixIcon: Icon(Icons.language),
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (value) => notifier.updatePersonalData(
                    personalData.copyWith(portfolioUrl: value),
                  ),
                ),
                const SizedBox(height: 16),

                // Professional Objective
                TextFormField(
                  initialValue: personalData.professionalObjective,
                  decoration: const InputDecoration(
                    labelText: 'Objetivo Profissional',
                    prefixIcon: Icon(Icons.flag_outlined),
                    hintText: 'Resuma seu objetivo de carreira...',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) => notifier.updatePersonalData(
                    personalData.copyWith(professionalObjective: value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: FilledButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dados salvos com sucesso!')),
              );
              // Navegar para a tela inicial limpando a pilha de navegação
              context.go('/');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Revise os campos destacados.')),
              );
            }
          },
          icon: const Icon(Icons.check),
          label: const Text('Salvar e Concluir'),
        ),
      ),
    );
  }
}
