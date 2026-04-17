import '../models/transaction_model.dart';
import '../localization/app_localizations.dart';
import 'package:flutter/material.dart';

class WealthCircleData {
  final String emoji;
  final String name;
  final int members;
  final String tagline;
  final double activity;
  const WealthCircleData(this.emoji, this.name, this.members, this.tagline, this.activity);
}

class ChallengeData {
  final String emoji;
  final String title;
  final String timeLeft;
  final int participants;
  final String description;
  final Color color;
  const ChallengeData(this.emoji, this.title, this.timeLeft, this.participants, this.description, this.color);
}

class LeaderData {
  final String name;
  final String amount;
  final String medal;
  final String city;
  final bool isMe;
  const LeaderData(this.name, this.amount, this.medal, this.city, this.isMe);
}

class CommunityEcosystem {
  final List<WealthCircleData> circles;
  final List<ChallengeData> challenges;
  final List<LeaderData> leaderboard;

  const CommunityEcosystem({required this.circles, required this.challenges, required this.leaderboard});
}

class CommunityService {
  CommunityService._();
  static final CommunityService instance = CommunityService._();

  CommunityEcosystem generateSimulatedEcosystem({
     required AppLocalizations l10n,
     required List<TransactionModel> transactions,
     required double totalSavings,
  }) {
     // Analyze to pick challenges
     double monthExpenses = transactions.where((t) => t.type == TransactionType.expense).fold(0.0, (s, t) => s + t.amount);
     bool spendsOnFood = transactions.any((t) => t.category == TransactionCategory.dining || t.category == TransactionCategory.food);
     
     List<ChallengeData> activeChallenges = [];
     if (spendsOnFood) {
       activeChallenges.add(ChallengeData('🍳', 'No-Dine-Out Week', '4 Days', 112, 'Cook at home. Stop funding Zomato.', Colors.blue));
     }
     
     if (monthExpenses > 15000) {
       activeChallenges.add(ChallengeData('🛑', 'Zero-Spend Weekend', '2 Days', 89, 'Don\'t buy anything this weekend.', Colors.redAccent));
     } else {
       activeChallenges.add(ChallengeData('💰', '10k Savings Sprint', '12 Days', 205, 'Save your first 10,000 this month.', Colors.green));
     }

     activeChallenges.add(ChallengeData('📚', 'Read 1 Finance Book', '20 Days', 45, 'Education pays the best interest.', Colors.orange));

     // Simulate realistic leaderboard where user falls around rank 3 or 4 based on actual savings
     int userRank = totalSavings > 100000 ? 1 : totalSavings > 50000 ? 2 : totalSavings > 10000 ? 3 : 5;
     
     List<LeaderData> board = [];
     if (userRank == 1) {
        board.add(LeaderData(l10n.leaderYou, '₹${totalSavings.toInt()}', '🏆', l10n.leaderYourCity, true));
        board.add(const LeaderData('Aditi V.', '₹95,000', '🥈', 'Pune', false));
        board.add(const LeaderData('Rohan K.', '₹88,000', '🥉', 'Mumbai', false));
     } else {
        board.add(LeaderData('Siddharth J.', '₹${totalSavings > 0 ? (totalSavings * 2.5).toInt() : 45000}', '🏆', 'Delhi', false));
        board.add(LeaderData('Ananya S.', '₹${totalSavings > 0 ? (totalSavings * 1.8).toInt() : 35000}', '🥈', 'Bangalore', false));
        if (userRank == 3) {
            board.add(LeaderData(l10n.leaderYou, '₹${totalSavings.toInt()}', '🥉', l10n.leaderYourCity, true));
        } else {
            board.add(LeaderData('Karan M.', '₹${totalSavings > 0 ? (totalSavings * 1.4).toInt() : 25000}', '🥉', 'Mumbai', false));
        }
        board.add(const LeaderData('Pooja P.', '₹15,000', '4️⃣', 'Hyderabad', false));
        if (userRank > 3) {
           board.add(LeaderData(l10n.leaderYou, '₹${totalSavings.toInt()}', '5️⃣', l10n.leaderYourCity, true));
        }
     }

     return CommunityEcosystem(
       circles: [
         WealthCircleData('🏦', l10n.circle1Name, 142, l10n.circle1Tag, 0.8),
         WealthCircleData('🛡️', l10n.circle2Name, 56, l10n.circle2Tag, 0.4),
         WealthCircleData('🎓', 'Students Finance Hub', 312, 'Learn how to manage stipend', 0.9),
       ],
       challenges: activeChallenges,
       leaderboard: board,
     );
  }
}
