import 'dart:math';
import '../models/behavior_prediction.dart';

class Quote {
  final String text;
  final String? author;

  const Quote(this.text, [this.author]);
}

class QuoteService {
  QuoteService._();
  static final QuoteService instance = QuoteService._();

  final Random _random = Random();

  final List<Quote> _generalQuotes = [
    const Quote('Do not save what is left after spending, but spend what is left after saving.', 'Warren Buffett'),
    const Quote('A rupee saved is a rupee earned. Compound it, and it becomes generational.'),
    const Quote('Financial peace isn\'t the acquisition of stuff. It\'s learning to live on less than you make.'),
    const Quote('The goal isn\'t more money. The goal is living life on your terms.'),
    const Quote('Wealth consists not in having great possessions, but in having few wants.'),
    const Quote('Time is the currency of your life. Spend it wisely.'),
  ];

  final List<Quote> _goodBehaviorQuotes = [
    const Quote('Great decisions build great wealth.'),
    const Quote('Every investment you make is a brick in your future castle.'),
    const Quote('Patience is the highest yielding compounding asset.'),
    const Quote('You just bought yourself a piece of financial freedom.'),
    const Quote('Sacrificing a small want today secures a massive need tomorrow.'),
  ];

  final List<Quote> _poorBehaviorQuotes = [
    const Quote('Discipline today creates freedom tomorrow.'),
    const Quote('If you buy things you do not need, soon you will have to sell things you need.', 'Warren Buffett'),
    const Quote('A small leak will sink a great ship. Watch your daily expenses.'),
    const Quote('Beware of little expenses; a small hole sinks a great ship.', 'Benjamin Franklin'),
    const Quote('Impulse is the enemy of compounding.'),
  ];

  final List<Quote> _neutralBehaviorQuotes = [
    const Quote('Balance is not something you find, it\'s something you create.'),
    const Quote('Needs over wants. Always measure the utility.'),
    const Quote('Consistent tracking is the first step to financial mastery.'),
  ];

  final List<Quote> _goalQuotes = [
    const Quote('A goal without a timeline is just a dream.'),
    const Quote('Small targets hit consistently break massive financial barriers.'),
    const Quote('Set the target, trust the math, ignore the noise.'),
  ];

  final List<Quote> _futureQuotes = [
    const Quote('Compound interest is the eighth wonder of the world.', 'Albert Einstein'),
    const Quote('The best time to plant a tree was 20 years ago. The second best time is today.'),
    const Quote('Your future self is watching you through the lens of your current decisions.'),
  ];

  Quote getRandomQuote() {
    return _generalQuotes[_random.nextInt(_generalQuotes.length)];
  }

  Quote getContextualQuote(BehaviorLabel label) {
    List<Quote> pool;
    switch (label) {
      case BehaviorLabel.good:
        pool = _goodBehaviorQuotes;
        break;
      case BehaviorLabel.neutral:
        pool = _neutralBehaviorQuotes;
        break;
      case BehaviorLabel.poor:
        pool = _poorBehaviorQuotes;
        break;
    }
    return pool[_random.nextInt(pool.length)];
  }

  Quote getGoalQuote() {
    return _goalQuotes[_random.nextInt(_goalQuotes.length)];
  }

  Quote getFutureQuote() {
    return _futureQuotes[_random.nextInt(_futureQuotes.length)];
  }
}
