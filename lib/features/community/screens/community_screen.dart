import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/gradient_badge.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: const _UserRankCard(),
              ),
            ),
          ),

          // Wealth Circles
          const SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Wealth Circles',
              subtitle: 'Group-based accountability for better habits',
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FadeInLeft(
                  delay: Duration(milliseconds: 60 * i),
                  duration: const Duration(milliseconds: 350),
                  child: _WealthCircleCard(circle: _circles[i]),
                ),
                childCount: _circles.length,
              ),
            ),
          ),

          // Active Challenges
          const SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Active Challenges',
              subtitle: 'Build good habits through competition',
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FadeInRight(
                  delay: Duration(milliseconds: 60 * i),
                  duration: const Duration(milliseconds: 350),
                  child: _ChallengeCard(challenge: _challenges[i]),
                ),
                childCount: _challenges.length,
              ),
            ),
          ),

          // Leaderboard
          const SliverToBoxAdapter(
            child: SectionHeader(title: '🏆 This Week\'s Top Savers'),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _LeaderboardTile(rank: i + 1, entry: _leaderboard[i]),
                childCount: _leaderboard.length,
              ),
            ),
          ),

          // Mindset wisdom
          const SliverToBoxAdapter(
            child: SectionHeader(title: '🧠 Wealth Mindset of the Day'),
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

  static const _circles = [
    _WealthCircle('🏦', 'Fresher Investors Club', 128, 'Weekly SIP accountability', 0.67),
    _WealthCircle('🛡️', '6-Month Fund Brigade', 43, 'Emergency fund builders', 0.44),
    _WealthCircle('📚', 'Finance Learners', 256, 'Daily finance education', 0.85),
  ];

  static const _challenges = [
    _Challenge('🚫', 'No-spend Weekend', '2 days left', 67, 'Skip unnecessary spends this weekend', AppColors.primaryGreen),
    _Challenge('☕', 'Brew at Home', '12 days left', 43, 'No café coffee for 21 days', AppColors.accentBlue),
    _Challenge('📈', '₹1K SIP Start', '6 days left', 89, 'Start your first SIP this month', AppColors.premiumGold),
  ];

  static const _leaderboard = [
    _LeaderEntry('Rahul M.', '₹12,500', '🏆', 'Mumbai'),
    _LeaderEntry('Priya S.', '₹10,200', '🥈', 'Pune'),
    _LeaderEntry('Arjun K.', '₹9,850', '🥉', 'Bangalore'),
    _LeaderEntry('Neha R.', '₹8,400', '4️⃣', 'Hyderabad'),
    _LeaderEntry('You', '₹6,200', '5️⃣', 'Your City'),
  ];
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _CommunityHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 16, 20, 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '👥 Community',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Your environment shapes your wealth',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── User Rank ────────────────────────────────────────────────────────────────
class _UserRankCard extends StatelessWidget {
  const _UserRankCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1428), Color(0xFF0A1628)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.premiumGold.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🏆 Your Rank',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              ShaderMask(
                shaderCallback: (b) => AppColors.goldGradient.createShader(b),
                child: const Text(
                  '#5',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Text(
                'Top 10% this week',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatRow(label: 'Saved this week', value: '₹6,200'),
                const SizedBox(height: 8),
                _StatRow(label: 'Circles joined', value: '2'),
                const SizedBox(height: 8),
                _StatRow(label: 'Challenges active', value: '3'),
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
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ─── Wealth Circle ────────────────────────────────────────────────────────────
class _WealthCircle {
  final String emoji;
  final String name;
  final int members;
  final String tagline;
  final double activity;
  const _WealthCircle(this.emoji, this.name, this.members, this.tagline,
      this.activity);
}

class _WealthCircleCard extends StatelessWidget {
  final _WealthCircle circle;

  const _WealthCircleCard({required this.circle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(circle.emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  circle.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  circle.tagline,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${circle.members} members',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Join',
                style: TextStyle(
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
class _Challenge {
  final String emoji;
  final String title;
  final String timeLeft;
  final int participants;
  final String description;
  final Color color;
  const _Challenge(this.emoji, this.title, this.timeLeft, this.participants,
      this.description, this.color);
}

class _ChallengeCard extends StatelessWidget {
  final _Challenge challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: challenge.color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: challenge.color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(challenge.emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      challenge.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: challenge.color.withOpacity(0.15),
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
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${challenge.participants} people participating',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
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
class _LeaderEntry {
  final String name;
  final String amount;
  final String medal;
  final String city;
  const _LeaderEntry(this.name, this.amount, this.medal, this.city);
}

class _LeaderboardTile extends StatelessWidget {
  final int rank;
  final _LeaderEntry entry;

  const _LeaderboardTile({required this.rank, required this.entry});

  @override
  Widget build(BuildContext context) {
    final isMe = entry.name == 'You';
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.primaryGreen.withOpacity(0.08)
            : AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMe ? AppColors.primaryGreen.withOpacity(0.3) : AppColors.bgGlassBorder,
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
                    color: isMe ? AppColors.primaryGreen : AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  entry.city,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
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
  final _quotes = const [
    '"The secret to wealth is simple: spend less than you earn and invest the rest." — Warren Buffett',
    '"Invest in yourself. Your career is the engine of your wealth." — Paul Clitheroe',
    '"Do not save what is left after spending, but spend what is left after saving." — Warren Buffett',
  ];

  @override
  Widget build(BuildContext context) {
    final quote = _quotes[DateTime.now().day % _quotes.length];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D1F38), Color(0xFF06101E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentBlue.withOpacity(0.3)),
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
