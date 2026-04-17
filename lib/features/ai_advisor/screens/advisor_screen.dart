import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';

import '../../../core/models/insight_model.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../providers.dart';

class AdvisorScreen extends StatefulWidget {
  const AdvisorScreen({super.key});

  @override
  State<AdvisorScreen> createState() => _AdvisorScreenState();
}

class _AdvisorScreenState extends State<AdvisorScreen> {
  final _textCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  void _send(String text) {
    if (text.trim().isEmpty) return;
    _textCtrl.clear();
    final user = context.read<UserProvider>().user;

    context.read<AdvisorProvider>().sendMessage(
      text,
      context: {
        'monthlyIncome': user.monthlyIncome,
        'userType': user.userType.toString(),
        'goals': user.goals.join(', '),
      },
    );
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Build quick prompts from l10n
    final quickPrompts = [
      _LocalQuickPrompt(label: l10n.promptInvestLabel,    query: l10n.promptInvestQuery),
      _LocalQuickPrompt(label: l10n.promptEmergencyLabel, query: l10n.promptEmergencyQuery),
      _LocalQuickPrompt(label: l10n.promptEmiLabel,       query: l10n.promptEmiQuery),
      _LocalQuickPrompt(label: l10n.promptSipFdLabel,     query: l10n.promptSipFdQuery),
      _LocalQuickPrompt(label: l10n.prompt503020Label,    query: l10n.prompt503020Query),
      _LocalQuickPrompt(label: l10n.promptLicLabel,       query: l10n.promptLicQuery),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Header
          _AdvisorHeader(),

          // Quick prompts
          _QuickPrompts(prompts: quickPrompts, onTap: _send),

          // Chat messages
          Expanded(
            child: Consumer<AdvisorProvider>(
              builder: (_, advisor, __) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollToBottom());

                // Empty state — show welcome message
                if (advisor.messages.isEmpty && !advisor.loading) {
                  return _WelcomeEmpty(l10n: l10n, quickPrompts: quickPrompts, onTap: _send);
                }

                return ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      advisor.messages.length + (advisor.loading ? 1 : 0),
                  itemBuilder: (ctx, i) {
                    if (i == advisor.messages.length) {
                      return _TypingIndicator(l10n: l10n);
                    }
                    final msg = advisor.messages[i];
                    return FadeInUp(
                      duration: const Duration(milliseconds: 300),
                      child: _ChatBubble(message: msg),
                    );
                  },
                );
              },
            ),
          ),

          // Input
          _ChatInput(controller: _textCtrl, onSend: _send),
        ],
      ),
    );
  }
}

// ─── Local quick prompt model ─────────────────────────────────────────────────
class _LocalQuickPrompt {
  final String label;
  final String query;
  const _LocalQuickPrompt({required this.label, required this.query});
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _AdvisorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 16, 20, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.bgGlassBorder
                : AppColors.bgGlassBorderLight,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text('🧠', style: TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.muniAdvisor,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGreen.withValues(alpha: 0.6),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    l10n.aiAlwaysAvailable,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Tooltip(
            message: l10n.clearChat,
            child: GestureDetector(
              onTap: () => context.read<AdvisorProvider>().clear(),
              child: const Icon(Icons.refresh_rounded,
                  color: AppColors.textMuted, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Quick prompts row ────────────────────────────────────────────────────────
class _QuickPrompts extends StatelessWidget {
  final List<_LocalQuickPrompt> prompts;
  final ValueChanged<String> onTap;

  const _QuickPrompts({required this.prompts, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        physics: const BouncingScrollPhysics(),
        itemCount: prompts.length,
        itemBuilder: (ctx, i) {
          final p = prompts[i];
          return GestureDetector(
            onTap: () => onTap(p.query),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color ??
                    AppColors.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.bgGlassBorder
                      : AppColors.bgGlassBorderLight,
                ),
              ),
              child: Text(
                p.label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Welcome / Empty state ────────────────────────────────────────────────────
class _WelcomeEmpty extends StatelessWidget {
  final AppLocalizations l10n;
  final List<_LocalQuickPrompt> quickPrompts;
  final ValueChanged<String> onTap;

  const _WelcomeEmpty(
      {required this.l10n,
      required this.quickPrompts,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Text('🧠', style: TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.advisorWelcome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Chat bubble ──────────────────────────────────────────────────────────────
class _ChatBubble extends StatelessWidget {
  final AdvisorMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: isUser ? AppColors.primaryGradient : null,
          color: isUser
              ? null
              : Theme.of(context).cardTheme.color ?? AppColors.bgCard,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          border: isUser
              ? null
              : Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.bgGlassBorder
                      : AppColors.bgGlassBorderLight,
                ),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isUser
                ? Colors.black
                : Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

// ─── Typing indicator ─────────────────────────────────────────────────────────
class _TypingIndicator extends StatefulWidget {
  final AppLocalizations l10n;
  const _TypingIndicator({required this.l10n});

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.bgGlassBorder
                : AppColors.bgGlassBorderLight,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Three bouncing dots
            ...List.generate(3, (i) {
              return AnimatedBuilder(
                animation: _ctrl,
                builder: (_, __) {
                  final offset =
                      ((_ctrl.value * 3 - i) % 1).clamp(0, 0.5);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen
                          .withValues(alpha: 0.4 + (offset as double)),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              );
            }),
            const SizedBox(width: 8),
            Text(
              widget.l10n.muniIsTyping,
              style: const TextStyle(
                  color: AppColors.textMuted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Chat Input ───────────────────────────────────────────────────────────────
class _ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSend;

  const _ChatInput({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 10, 16, MediaQuery.of(context).padding.bottom + 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.bgGlassBorder
                : AppColors.bgGlassBorderLight,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14),
              onSubmitted: onSend,
              decoration: InputDecoration(
                hintText: l10n.askMuniAnything,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => onSend(controller.text),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.black, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
