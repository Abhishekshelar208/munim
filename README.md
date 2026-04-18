# MUNI-M: AI-Driven Financial Intelligence Pipeline

MUNI-M is a highly advanced personal finance application built in Flutter. It eschews traditional static dashboards in favor of a **6-Layer Cognitive AI Pipeline**. Every transaction, income log, and chat query organically shifts the application's entire UI, delivering an actively responsive financial coaching environment.

## The Cognitive AI Pipeline
The system utilizes 6 specialized agents to control the UI and data flow:
1. **Security Agent:** Validates inputs, sanitizes data, and blocks malicious or numerically impossible transactions locally.
2. **Mindset Agent (ML):** A neural behavior evaluator. It reads timestamps and ratios to classify an expense as *Good*, *Neutral*, or *Poor* (impulse buying).
3. **Supervisor Agent:** The final gatekeeper. It monitors the user's "Burn Rate" and safely truncates hallucinated LLM advice before it reaches the UI.
4. **Strategy Agent:** Dynamically calculates 50-30-20 budget rules, enforces Wealth Milestones, and generates personalized goals relative to income.
5. **Future Agent:** Extracts the highest recurring "Waste" transactions from real data and organically calculates 10-year compounding Opportunity Costs. 
6. **Community Agent:** Scales a completely dynamic multi-player universe. Your leaderboard rank rises and falls directly based on your logged savings.

---

## 🚀 The AI User Journey Flow

This is the exact start-to-finish user journey of MUNI-M from the perspective of a brand-new user interacting with the AI pipeline for the first time:

### 1. The Entry Point: Onboarding & Identity
When a user launches the app for the first time, they don't immediately see complex dashboards. Instead, they hit the **Onboarding Screen**.
* **Action:** The system asks them for their Name, Currency preference, and—most importantly—their **Monthly Income**.
* **Backend:** Once they input this, the system saves out their profile. This Monthly Income baseline is incredibly important because it instantly becomes the mathematical anchor for the Mindset Agent, Supervisor Agent, and Strategy Agent to evaluate their financial safety moving forward.

### 2. The Clean Slate: Dashboard (Home Tab)
The user is routed into the **Main Dashboard**. Since they haven't logged anything yet, the app is clean. 
* **Action:** They tap the beautiful floating **"+" (Add Entry)** button to log their first few interactions.
* Let's say they log exactly two things: 
  1. A ₹50,000 *Salary* (Income).
  2. A ₹15,000 *Shopping* spree (Expense).
* **AI Pipeline Activating:** As soon as they hit 'Save', the data doesn't just sit in a database. It goes through the **MUNI-M Intelligence Pipeline**: 
  * The **Security Agent** ensures the input isn't malicious.
  * The **Mindset ML Agent** instantly calculates the ₹15,000 shopping spree against their ₹50,000 income, realizes it's late at night (timestamp check) and eats up 30% of their income, and instantly tags it as a **"Poor Choice"**.

### 3. The Reactive Environment: Dashboard Transformation
Instantly upon saving, the Dashboard organically shifts:
* **Asset Liability Scale:** The ₹50,000 Income pushes up the Green "Assets", while the ₹15,000 Shopping triggers the Danger Red "Liabilities" because the ML Agent flagged it.
* **Net Profit Card:** Dynamically computes that they now have ₹35,000 and calculates their real-time "Burn Rate". 
* **Smart Alerts:** The **Supervisor Agent** realizes their burn rate spiked massively in one day. It generates a dynamic 🔴 warning card on the Dashboard: *"High Burn Rate: You've spent a large portion of your income very fast."*

### 4. Setting the Course: Strategy Tab
Curious about how they should handle this spending, the user navigates to the **Strategy Tab**.
* **Action:** The user sees a button that says **✨ Generate Personalized AI Goals**. They tap it.
* **Backend:** The **Strategy Agent** reads their ₹50,000 income and organically creates custom goals just for them (e.g., a "Bulletproof Fund" set mathematically to ₹1,50,000 [3 months salary]).
* **Action Context:** Because they spent so much on shopping, the Strategy Agent dynamically shrinks their "Wants" budget in the **50-30-20 Allocation Tracker**, advising them to tighten up their discretionary spending to recover the poor choice! 

### 5. Seeing the Reality: Future Insights Tab
The user shifts to the **Future Tab** to see their long-term trajectory.
* **Backend:** The **Future Service Agent** dives into their transaction history and extracts their biggest flaw (the shopping spree).
* **Action:** It spins up a custom **"Shopping Trap" Opportunity Cost Card**, showing exactly how much that ₹15,000 shopping habit will compound to over 10 years if they put it into an index fund instead. It essentially scares them into better habits!

### 6. Asking for Guidance: AI Advisor Tab
Feeling overwhelmed by the insight, they jump to the **Advisor Tab**.
* **Action:** They type in the chat box: *"I bought a lot of clothes today, how do I save money this month?"*
* **Backend:** The **Advisor Agent** grabs their ₹35,000 Net Profit, their transaction history, and fires it into the Large Language Model. The LLM drafts a realistic plan.
* **Supervisor Action:** Before the user sees the answer, the **Supervisor Agent** checks it. If it sees the advice is safe, it pushes it to the UI with a green `🛡️ System Checked` badge, giving the user culturally relevant, context-aware advice based directly on the shopping spree they logged!

### 7. Social Motivation: Community Tab
To stay motivated, they check the **Community Tab**.
* **Action:** By following the AI's advice, let's assume they log a new ₹5,000 **Saving** transaction on the home tab.
* **Backend:** Because their `totalSavings` just increased linearly via the tracker, the **Community Agent** recalculates their rank score. When they return to the Feed, they see their User Avatar dynamically jump over other dummy users on the Global Leaderboard, giving them a massive dopamine hit for making a smart financial move.
