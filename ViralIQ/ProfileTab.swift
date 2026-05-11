import SwiftUI

struct ProfileTab: View {
    @EnvironmentObject var game: GameState
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [VTheme.primary, VTheme.secondary],
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 96, height: 96)
                        Image(systemName: "waveform.path.ecg")
                            .font(.system(size: 42, weight: .heavy))
                            .foregroundStyle(.white)
                    }
                    Text("Operator")
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundStyle(VTheme.text)
                    Text("Level \(game.xp / 100 + 1) · \(game.xp) XP")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(VTheme.textSec)
                }
                .padding(.top, 18)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    StatCard(icon: "flame.fill", color: VTheme.secondary, value: "\(game.streak)", label: "Day streak")
                    StatCard(icon: "bolt.fill", color: VTheme.primary, value: "\(game.xp)", label: "Total XP")
                    StatCard(icon: "diamond.fill", color: VTheme.warning, value: "\(game.flames)", label: "Flames")
                    StatCard(icon: "crown.fill", color: VTheme.success, value: "\(game.mastered) / \(game.skills.count)", label: "Mastered")
                }
                .padding(.horizontal, 14)

                VCard {
                    Text("LESSONS COMPLETED")
                        .font(.system(size: 11, weight: .heavy))
                        .kerning(1.5)
                        .foregroundStyle(VTheme.textMuted)
                        .padding(.bottom, 8)
                    Text("\(game.lessonsCompleted)")
                        .font(.system(size: 36, weight: .heavy))
                        .foregroundStyle(VTheme.primary)
                    Text("The hook is the algorithm. The mechanism is the durable skill.")
                        .font(.system(size: 13))
                        .foregroundStyle(VTheme.textSec)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 14)
                Color.clear.frame(height: 24)
            }
        }
    }
}

struct StatCard: View {
    let icon: String
    let color: Color
    let value: String
    let label: String
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .heavy))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 22, weight: .heavy))
                .foregroundStyle(VTheme.text)
            Text(label.uppercased())
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.0)
                .foregroundStyle(VTheme.textMuted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(VTheme.bgCard)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(VTheme.border, lineWidth: 1))
        )
    }
}
