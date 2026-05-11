import SwiftUI

struct HomeTab: View {
    @EnvironmentObject var game: GameState
    @State private var lessonSkillId: Int? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                StreakBanner()
                ProgressCard()
                SkillTreeView { skill in
                    if skill.status != .locked { lessonSkillId = skill.id }
                }
                Color.clear.frame(height: 32)
            }
            .padding(.horizontal, 14)
            .padding(.top, 8)
        }
        .onAppear {
            let args = ProcessInfo.processInfo.arguments
            if let i = args.firstIndex(of: "-openLesson"), i + 1 < args.count,
               let sid = Int(args[i + 1]) {
                lessonSkillId = sid
            }
        }
        .fullScreenCover(item: Binding(
            get: { lessonSkillId.map { LessonId(id: $0) } },
            set: { _ in lessonSkillId = nil }
        )) { item in
            LessonScreen(skillId: item.id) { lessonSkillId = nil }
                .environmentObject(game)
        }
    }
}

private struct LessonId: Identifiable { let id: Int }

struct StreakBanner: View {
    @EnvironmentObject var game: GameState
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "flame.fill")
                .font(.system(size: 42, weight: .heavy))
                .foregroundStyle(.white)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(game.streak)")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundStyle(.white)
                Text("day streak!")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.white.opacity(0.85))
            }
            Spacer()
            HStack(spacing: 3) {
                ForEach(0..<7, id: \.self) { i in
                    let done = i < (game.streak % 7 == 0 ? 7 : game.streak % 7)
                    ZStack {
                        Circle().fill(done ? .white.opacity(0.9) : .white.opacity(0.2))
                        if done {
                            Image(systemName: "checkmark")
                                .font(.system(size: 9, weight: .heavy))
                                .foregroundStyle(VTheme.secondary)
                        } else {
                            Text(["M","T","W","T","F","S","S"][i])
                                .font(.system(size: 9, weight: .heavy))
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(width: 22, height: 22)
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(LinearGradient(colors: [VTheme.secondary, VTheme.secondaryDark],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
        )
    }
}

struct ProgressCard: View {
    @EnvironmentObject var game: GameState
    var body: some View {
        VCard {
            HStack {
                Text("Viral Hook Mastery")
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundStyle(VTheme.text)
                Spacer()
                Text("\(game.lessonsCompleted) lessons")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(VTheme.primary)
            }
            .padding(.bottom, 10)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(VTheme.bgLight)
                    Capsule()
                        .fill(LinearGradient(colors: [VTheme.primary, VTheme.secondary],
                                             startPoint: .leading, endPoint: .trailing))
                        .frame(width: max(0, min(1, Double(game.mastered) / Double(game.skills.count))) * geo.size.width)
                }
            }
            .frame(height: 10)
            Text("\(game.mastered) of \(game.skills.count) skills mastered")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(VTheme.textSec)
                .padding(.top, 6)
        }
    }
}

struct SkillTreeView: View {
    @EnvironmentObject var game: GameState
    let onSkillTap: (Skill) -> Void

    var body: some View {
        VStack(spacing: 18) {
            ForEach(Array(game.skills.enumerated()), id: \.element.id) { idx, skill in
                let offsets: [CGFloat] = [0, -28, -40, -28, 0, 28, 40, 28]
                HStack {
                    Spacer().frame(width: max(0, offsets[idx % offsets.count] + 40))
                    SkillNode(skill: skill, isFirst: idx == 0) { onSkillTap(skill) }
                    Spacer().frame(width: max(0, -offsets[idx % offsets.count] + 40))
                }
            }
        }
    }
}

struct SkillNode: View {
    let skill: Skill
    let isFirst: Bool
    let action: () -> Void
    @State private var pulse: Bool = false

    var body: some View {
        Button {
            if skill.status != .locked {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                action()
            }
        } label: {
            VStack(spacing: 4) {
                if skill.status == .current {
                    Text("START")
                        .font(.system(size: 11, weight: .heavy))
                        .kerning(1.5)
                        .foregroundStyle(VTheme.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(VTheme.bgCard)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(VTheme.border, lineWidth: 1))
                        )
                        .padding(.bottom, 4)
                }
                ZStack {
                    Circle()
                        .fill(
                            skill.status == .locked ?
                                LinearGradient(colors: [VTheme.bgLight, VTheme.bgLight], startPoint: .top, endPoint: .bottom) :
                                LinearGradient(colors: [skill.color, skill.colorDark], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .overlay(Circle().stroke(skill.status == .locked ? VTheme.border : skill.colorDark, lineWidth: 4))
                        .frame(width: 76, height: 76)
                        .shadow(color: skill.status == .locked ? .clear : skill.color.opacity(0.4), radius: 12, x: 0, y: 4)
                        .scaleEffect(pulse && skill.status == .current ? 1.04 : 1.0)
                    Image(systemName: skill.status == .done ? "crown.fill" : (skill.status == .locked ? "lock.fill" : skill.sfSymbol))
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundStyle(.white)
                }
                if skill.status != .locked && skill.status != .done {
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { j in
                            Circle()
                                .fill(j < Int((skill.progress * 5).rounded()) ? skill.color : VTheme.bgLight)
                                .frame(width: 7, height: 7)
                        }
                    }
                }
                Text(skill.name)
                    .font(.system(size: 12, weight: .heavy))
                    .foregroundStyle(skill.status == .locked ? VTheme.textMuted : VTheme.text)
                if skill.status != .locked {
                    Text(skill.descLine)
                        .font(.system(size: 10))
                        .foregroundStyle(VTheme.textSec)
                }
            }
            .opacity(skill.status == .locked ? 0.35 : 1.0)
        }
        .buttonStyle(.plain)
        .onAppear {
            if skill.status == .current {
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    pulse = true
                }
            }
        }
    }
}
