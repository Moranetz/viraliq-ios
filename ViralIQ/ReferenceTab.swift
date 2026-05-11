import SwiftUI

struct ReferenceTab: View {
    @EnvironmentObject var game: GameState
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("SKILL LIBRARY")
                    .font(.system(size: 11, weight: .heavy))
                    .kerning(1.8)
                    .foregroundStyle(VTheme.textMuted)
                    .padding(.horizontal, 14)
                ForEach(game.skills) { skill in
                    VCard {
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(colors: [skill.color, skill.colorDark],
                                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 52, height: 52)
                                    .opacity(skill.status == .locked ? 0.4 : 1.0)
                                Image(systemName: skill.sfSymbol)
                                    .font(.system(size: 22, weight: .heavy))
                                    .foregroundStyle(.white)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(skill.name)
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundStyle(VTheme.text)
                                Text(skill.descLine)
                                    .font(.system(size: 13))
                                    .foregroundStyle(VTheme.textSec)
                                Text("\(skill.questions.count) questions")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundStyle(VTheme.textMuted)
                            }
                            Spacer()
                            if skill.status == .done {
                                Image(systemName: "crown.fill").foregroundStyle(VTheme.warning)
                            } else if skill.status == .locked {
                                Image(systemName: "lock.fill").foregroundStyle(VTheme.textMuted)
                            } else {
                                Text("\(Int((skill.progress * 100).rounded()))%")
                                    .font(.system(size: 13, weight: .heavy))
                                    .foregroundStyle(skill.color)
                            }
                        }
                    }
                    .padding(.horizontal, 14)
                }
                Color.clear.frame(height: 24)
            }
            .padding(.top, 10)
        }
    }
}
