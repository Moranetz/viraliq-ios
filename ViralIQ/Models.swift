import Foundation
import SwiftUI

enum Question: Identifiable, Hashable {
    case assemble(topic: String, fragments: [String], correctOrder: [Int], explanation: String)
    case swipe(hook: String, isViral: Bool, explanation: String)
    case surgery(words: [String], killIndex: Int, explanation: String)
    case rank(hooks: [String], correctOrder: [Int], explanation: String)
    case ab(versions: [String], winnerIndex: Int, marginText: String, explanation: String)
    case roast(content: String, expertScore: Int, context: String, explanation: String)
    case fix(phrases: [String], weakIndex: Int, fixOptions: [String], fixCorrectIndex: Int, explanation: String)

    var id: Int {
        var h = Hasher()
        hash(into: &h)
        return h.finalize()
    }

    var explanation: String {
        switch self {
        case .assemble(_, _, _, let e),
             .swipe(_, _, let e),
             .surgery(_, _, let e),
             .rank(_, _, let e),
             .ab(_, _, _, let e),
             .roast(_, _, _, let e),
             .fix(_, _, _, _, let e):
            return e
        }
    }
}

struct Skill: Identifiable, Hashable {
    enum Status: Hashable { case locked, current, done }

    let id: Int
    let name: String
    let descLine: String
    let sfSymbol: String
    let colorHex: String
    let colorDarkHex: String
    let questions: [Question]
    var status: Status = .locked
    var progress: Double = 0

    var color: Color { Color(hex: colorHex) }
    var colorDark: Color { Color(hex: colorDarkHex) }
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet(charactersIn: "# "))
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xff) / 255.0
        let g = Double((v >> 8) & 0xff) / 255.0
        let b = Double(v & 0xff) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}

@MainActor
final class GameState: ObservableObject {
    @Published var xp: Int = 0
    @Published var hearts: Int = 5
    @Published var streak: Int = 1
    @Published var flames: Int = 30
    @Published var lessonsCompleted: Int = 0
    @Published var skills: [Skill] = []

    init() {
        var initial = QuestionsData.skills
        if let firstIdx = initial.indices.first {
            initial[firstIdx].status = .current
        }
        self.skills = initial
    }

    var mastered: Int { skills.filter { $0.status == .done }.count }

    func completeLesson(skillId: Int, earnedXP: Int, wasPerfect: Bool) {
        xp += earnedXP
        lessonsCompleted += 1
        hearts = 5
        if wasPerfect { flames += 5 }
        guard let idx = skills.firstIndex(where: { $0.id == skillId }) else { return }
        skills[idx].progress = min(1.0, skills[idx].progress + 0.2)
        if skills[idx].progress >= 1.0 {
            skills[idx].status = .done
            if idx + 1 < skills.count, skills[idx + 1].status == .locked {
                skills[idx + 1].status = .current
            }
        }
    }

    func useHeart() {
        hearts = max(0, hearts - 1)
    }

    static func earnedXP(correctCount: Int, total: Int, maxCombo: Int) -> Int {
        let base = correctCount * 12 + maxCombo * 5
        let perfect = (correctCount == total) ? 15 : 0
        return base + perfect
    }
}
