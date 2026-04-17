import 'dart:convert';
import 'dart:math';

import '../models/insight_model.dart';

class AIService {
  AIService._();
  static final AIService instance = AIService._();

  // ─── Mock response bank (replace with Gemini/OpenAI call) ────────────────
  static const Map<String, String> _mockBank = {
    'invest': '💡 Great mindset! I recommend starting with a Nifty 50 index fund through any SIP. ₹1,000/month compounding at 12% for 20 years = ₹9.9 Lakhs. No stock picking needed.',
    'save': '🛡️ Build your emergency fund first — 6 months of expenses in a liquid fund. Then split savings between FD (safe) and equity SIPs (grow). Never keep idle cash in savings account.',
    'spend': '🎯 Before spending, ask: "Is this a need or a want?" and "What would this become in 10 years if invested?" A ₹5,000 impulse buy = ₹15,500 lost opportunity at 12% in 10 years.',
    'salary': '📊 Freshers: Apply the 50-30-20 rule — 50% needs, 30% invest+save, 20% wants. Set up auto-debit for SIP on salary day so you invest before spending.',
    'emi': '⚠️ EMI is future salary already spent. Every ₹1,000/month EMI costs you ₹1,000 in flexibility. Ask: Can I save for this in 3-6 months instead? If yes, skip the EMI.',
    'crypto': '📉 Crypto is high risk, not investment strategy. Max 5% of portfolio if you choose to. Never invest emergency fund or borrowed money in crypto.',
    'lic': '❌ LIC endowment plans average 4-5% returns vs 12%+ from index funds. Buy term insurance for protection separately. Don\'t mix insurance with investment.',
    'fd': '💰 FD at 7% vs mutual funds at 12%: after 20 years, ₹10,000 becomes ₹38,697 (FD) vs ₹96,463 (MF). Use FD only for 1-2 year goals, not long-term wealth.',
    'default': '🧠 That\'s a great question! Financial intelligence is about understanding the cost of each decision — not just today\'s cost, but its 10-year impact. Can you give me more context about your specific situation?',
  };

  Future<AdvisorMessage> sendMessage(String userMessage, {
    Map<String, dynamic>? userContext,
  }) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 800 + Random().nextInt(600)));

    final response = _generateResponse(userMessage.toLowerCase());

    return AdvisorMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: response,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }

  String _generateResponse(String query) {
    for (final key in _mockBank.keys) {
      if (query.contains(key)) return _mockBank[key]!;
    }
    return _mockBank['default']!;
  }

  // ── Context-aware prompting ───────────────────────────────────────────────
  String buildSystemPrompt(Map<String, dynamic> userContext) {
    return '''You are MUNI, an AI financial advisor built for Indian freshers.
User context: Monthly income ₹${userContext['monthlyIncome']}, 
User type: ${userContext['userType']}, Goals: ${userContext['goals']}.
Provide specific, actionable, India-focused advice in 2-3 sentences.
Use rupee amounts and Indian financial products (SIP, FD, NPS, PPF).
Be direct, empowering, and behavior-focused. No generic advice.''';
  }

  // ── Quick prompts ─────────────────────────────────────────────────────────
  static List<QuickPrompt> quickPrompts = [
    QuickPrompt(label: '📈 How to start investing?', query: 'how should I start investing my salary'),
    QuickPrompt(label: '🛡️ Build emergency fund', query: 'how to save emergency fund'),
    QuickPrompt(label: '💳 Is this EMI worth it?', query: 'should I take an emi for this purchase'),
    QuickPrompt(label: '📊 Compare SIP vs FD', query: 'which is better sip or fd for long term'),
    QuickPrompt(label: '💰 50-30-20 rule', query: 'explain 50 30 20 rule for my salary'),
    QuickPrompt(label: '🏦 LIC vs Term Insurance', query: 'lic vs term insurance which is better'),
  ];
}

class QuickPrompt {
  final String label;
  final String query;
  const QuickPrompt({required this.label, required this.query});
}
