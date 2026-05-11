import SwiftUI

struct LessonComplete: View {
    let skillId: Int
    let correct: Int
    let total: Int
    let maxCombo: Int
    let onClose: () -> Void

    var earnedXP: Int { GameState.earnedXP(correctCount: correct, total: total, maxCombo: maxCombo) }
    var isPerfect: Bool { correct == total }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: isPerfect ? "crown.fill" : "checkmark.seal.fill")
                .font(.system(size: 72, weight: .heavy))
                .foregroundStyle(isPerfect ? VTheme.primary : VTheme.success)
                .shadow(color: (isPerfect ? VTheme.primary : VTheme.success).opacity(0.5), radius: 18)
            Text(isPerfect ? "Perfect" : "Lesson Complete")
                .font(.system(size: 28, weight: .heavy))
                .kerning(2.0)
                .foregroundStyle(VTheme.text)
            VStack(spacing: 10) {
                LessonStatRow(label: "Correct", value: "\(correct) / \(total)", color: VTheme.success)
                LessonStatRow(label: "Max combo", value: "\(maxCombo)×", color: VTheme.primary)
                LessonStatRow(label: "Earned XP", value: "+\(earnedXP)", color: VTheme.accent)
                if isPerfect {
                    LessonStatRow(label: "Perfect bonus", value: "+5 flames", color: VTheme.warning)
                }
            }
            .padding(.horizontal, 24)
            Spacer()
            Button("Continue") { onClose() }
                .buttonStyle(VPrimaryButtonStyle(fill: VTheme.success, shadow: VTheme.successDark))
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(VTheme.bg)
    }
}

struct LessonStatRow: View {
    let label: String
    let value: String
    let color: Color
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(VTheme.textSec)
            Spacer()
            Text(value)
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(color)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(VTheme.bgCard)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(VTheme.border, lineWidth: 1))
        )
    }
}
