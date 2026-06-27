import SwiftUI

struct LessonScreen: View {
    @EnvironmentObject var game: GameState
    let skillId: Int
    let onClose: () -> Void

    @State private var idx: Int = 0
    @State private var hearts: Int = 5
    @State private var combo: Int = 0
    @State private var maxCombo: Int = 0
    @State private var correctCount: Int = 0
    @State private var answered: Bool = false
    @State private var wasCorrect: Bool = false
    @State private var dead: Bool = false
    @State private var showResult: Bool = false

    var skill: Skill { game.skills.first { $0.id == skillId } ?? game.skills[0] }
    var questions: [Question] { skill.questions }
    var totalQ: Int { questions.count }
    var progress: Double { min(0.1 + Double(idx) / Double(totalQ) * 0.9, 1.0) }

    var body: some View {
        ZStack {
            VTheme.bg.ignoresSafeArea()
            if showResult {
                LessonComplete(
                    skillId: skillId,
                    correct: correctCount, total: totalQ, maxCombo: maxCombo,
                    onClose: {
                        let earned = GameState.earnedXP(correctCount: correctCount, total: totalQ, maxCombo: maxCombo)
                        game.completeLesson(skillId: skillId, earnedXP: earned, wasPerfect: correctCount == totalQ)
                        onClose()
                    }
                )
            } else if dead {
                LessonDead(onClose: onClose)
            } else {
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        Button { onClose() } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundStyle(VTheme.textSec)
                                .padding(8)
                        }
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule().fill(VTheme.bgLight)
                                Capsule().fill(VTheme.success)
                                    .frame(width: progress * geo.size.width)
                                    .animation(.easeOut(duration: 0.3), value: progress)
                            }
                        }
                        .frame(height: 10)
                        HStack(spacing: 4) {
                            Image(systemName: "heart.fill").foregroundStyle(VTheme.danger)
                            Text("\(hearts)")
                                .font(.system(size: 14, weight: .heavy))
                                .foregroundStyle(VTheme.text)
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.top, 12)

                    if combo >= 2 {
                        HStack(spacing: 6) {
                            Image(systemName: "bolt.fill").foregroundStyle(VTheme.primary)
                            Text("Combo × \(combo)")
                                .font(.system(size: 14, weight: .heavy))
                                .foregroundStyle(VTheme.primary)
                        }
                        .padding(.top, 8)
                    }

                    ScrollView {
                        VStack(spacing: 14) {
                            QuestionView(
                                question: questions[idx],
                                answered: answered,
                                wasCorrect: wasCorrect,
                                onAnswer: { isCorrect in handleAnswer(isCorrect: isCorrect) }
                            )
                            .id("q-\(idx)")  // force-rebuild between questions
                        }
                        .padding(.horizontal, 14)
                        .padding(.top, 18)
                    }

                    if answered {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Image(systemName: wasCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundStyle(wasCorrect ? VTheme.success : VTheme.danger)
                                Text(wasCorrect ? "Correct" : "Not quite")
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundStyle(wasCorrect ? VTheme.success : VTheme.danger)
                                Spacer()
                            }
                            if !questions[idx].explanation.isEmpty {
                                Text(questions[idx].explanation)
                                    .font(.system(size: 13))
                                    .foregroundStyle(VTheme.text)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Button("Continue") { handleContinue() }
                                .buttonStyle(VPrimaryButtonStyle(
                                    fill: wasCorrect ? VTheme.success : VTheme.accent,
                                    shadow: wasCorrect ? VTheme.successDark : VTheme.accentDark
                                ))
                        }
                        .padding(16)
                        .background((wasCorrect ? VTheme.success : VTheme.danger).opacity(0.10))
                    }
                }
            }
        }
        .onAppear {
            // Refill depleted hearts when starting a lesson, matching the
            // "Hearts refill on the next lesson" promise on the out-of-hearts
            // screen. Without this, dying leaves game.hearts at 0 and the next
            // lesson starts dead-on-arrival (instant death on the first miss).
            if game.hearts <= 0 { game.hearts = 5 }
            hearts = game.hearts
        }
    }

    private func handleAnswer(isCorrect: Bool) {
        guard !answered else { return }
        answered = true
        wasCorrect = isCorrect
        if isCorrect {
            combo += 1
            maxCombo = max(maxCombo, combo)
            correctCount += 1
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } else {
            combo = 0
            hearts = max(0, hearts - 1)
            game.useHeart()
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            if hearts <= 0 { dead = true }
        }
    }

    private func handleContinue() {
        let ni = idx + 1
        answered = false
        wasCorrect = false
        if ni >= totalQ {
            showResult = true
        } else {
            idx = ni
        }
    }
}

struct LessonDead: View {
    let onClose: () -> Void
    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 56, weight: .heavy))
                .foregroundStyle(VTheme.danger)
            Text("Out of hearts")
                .font(.system(size: 22, weight: .heavy))
                .foregroundStyle(VTheme.text)
            Text("Hearts refill on the next lesson.")
                .font(.system(size: 14))
                .foregroundStyle(VTheme.textSec)
            Button("Close") { onClose() }
                .buttonStyle(VPrimaryButtonStyle(fill: VTheme.accent, shadow: VTheme.accentDark))
                .padding(.horizontal, 24)
                .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(VTheme.bg)
    }
}
