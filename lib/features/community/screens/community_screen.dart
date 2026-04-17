import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../providers.dart';
import 'package:provider/provider.dart';
import '../../../core/services/community_service.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final txns = context.watch<TransactionProvider>().transactions.toList();
    final savings = context.watch<TransactionProvider>().totalSavings;
    
    final ecosystem = CommunityService.instance.generateSimulatedEcosystem(
      l10n: l10n,
      transactions: txns,
      totalSavings: savings,
    );

    final circles = ecosystem.circles;
    final challenges = ecosystem.challenges;
    final leaderboard = ecosystem.leaderboard;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(child: _CommunityHeader()),

          // User rank card
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: _UserRankCard(),
              ),
            ),
          ),

          // Wealth Circles
          SliverToBoxAdapter(
            child: SectionHeader(
              title: l10n.wealthCirclesTitle,
              subtitle: l10n.wealthCirclesSubtitle,
              trailing: const GradientBadge(label: '✨ AI Generated'),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FadeInLeft(
                  delay: Duration(milliseconds: 60 * i),
                  duration: const Duration(milliseconds: 350),
                  child: _WealthCircleCard(circle: circles[i]),
                ),
                childCount: circles.length,
              ),
            ),
          ),

          // Active Challenges
          SliverToBoxAdapter(
            child: SectionHeader(
              title: l10n.activeChallenges,
              subtitle: l10n.activeChallengesSubtitle,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FadeInRight(
                  delay: Duration(milliseconds: 60 * i),
                  duration: const Duration(milliseconds: 350),
                  child: _ChallengeCard(challenge: challenges[i]),
                ),
                childCount: challenges.length,
              ),
            ),
          ),

          // Leaderboard
          SliverToBoxAdapter(
            child: SectionHeader(
              title: l10n.topSaversTitle,
              trailing: const GradientBadge(label: '✨ AI Generated'),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) =>
                  _LeaderboardTile(rank: i + 1, entry: leaderboard[i]),
              childCount: leaderboard.length,
            ),
          ),

          // Wisdom card
          SliverToBoxAdapter(
            child: SectionHeader(title: l10n.wisdomOfDay),
          ),

          SliverToBoxAdapter(
            child: FadeInUp(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: _WisdomCard(),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _CommunityHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.communityTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.communitySubtitle,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── User Rank ────────────────────────────────────────────────────────────────
class _UserRankCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: Theme.of(context).brightness == Brightness.dark
              ? [const Color(0xFF1A1428), const Color(0xFF0A1628)]
              : [
                  AppColors.premiumGold.withValues(alpha: 0.1),
                  AppColors.bgCardLight
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.premiumGold.withValues(alpha: 0.3)
              : AppColors.premiumGold.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.yourRank,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              ShaderMask(
                shaderCallback: (b) =>
                    AppColors.goldGradient.createShader(b),
                child: const Text(
                  '#5',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                l10n.topPercent,
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatRow(label: l10n.savedThisWeek, value: '₹6,200'),
                const SizedBox(height: 8),
                _StatRow(label: l10n.circlesJoined, value: '2'),
                const SizedBox(height: 8),
                _StatRow(label: l10n.challengesActive, value: '3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.textMuted, fontSize: 12)),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ─── Wealth Circle ────────────────────────────────────────────────────────────

class _WealthCircleCard extends StatelessWidget {
  final WealthCircleData circle;
  const _WealthCircleCard({required this.circle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgGlassBorder
              : AppColors.bgGlassBorderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(circle.emoji,
                  style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  circle.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  circle.tagline,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 11),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.membersCount(circle.members),
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                l10n.joinButton,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Challenge ───────────────────────────────────────────────────────────────

class _ChallengeCard extends StatelessWidget {
  final ChallengeData challenge;
  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: challenge.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: challenge.color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(challenge.emoji,
              style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      challenge.title,
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: challenge.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        challenge.timeLeft,
                        style: TextStyle(
                          color: challenge.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  challenge.description,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.participantsCount(challenge.participants),
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Leaderboard ──────────────────────────────────────────────────────────────

class _LeaderboardTile extends StatelessWidget {
  final int rank;
  final LeaderData entry;

  const _LeaderboardTile({required this.rank, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: entry.isMe
            ? AppColors.primaryGreen.withValues(alpha: 0.08)
            : (Theme.of(context).cardTheme.color ?? AppColors.bgCard),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: entry.isMe
              ? AppColors.primaryGreen.withValues(alpha: 0.3)
              : (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.bgGlassBorder
                  : AppColors.bgGlassBorderLight),
        ),
      ),
      child: Row(
        children: [
          Text(entry.medal, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    color: entry.isMe
                        ? AppColors.primaryGreen
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  entry.city,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            entry.amount,
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Wisdom card ──────────────────────────────────────────────────────────────
class _WisdomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final quotes = l10n.wisdomQuotes;
    final quote = quotes[DateTime.now().day % quotes.length];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: Theme.of(context).brightness == Brightness.dark
              ? [const Color(0xFF0D1F38), const Color(0xFF06101E)]
              : [
                  AppColors.accentBlue.withValues(alpha: 0.1),
                  AppColors.bgCardLight
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.accentBlue.withValues(alpha: 0.3)
              : AppColors.accentBlue.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('✨', style: TextStyle(fontSize: 22)),
          const SizedBox(height: 12),
          Text(
            quote,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
