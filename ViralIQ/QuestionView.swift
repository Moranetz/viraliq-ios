import SwiftUI

struct QuestionView: View {
    let question: Question
    let answered: Bool
    let wasCorrect: Bool
    let onAnswer: (Bool) -> Void

    var body: some View {
        switch question {
        case .assemble(let topic, let fragments, let correctOrder, _):
            QAssemble(topic: topic, fragments: fragments, correctOrder: correctOrder,
                      answered: answered, onAnswer: onAnswer)
        case .swipe(let hook, let isViral, _):
            QSwipe(hook: hook, isViral: isViral, answered: answered, onAnswer: onAnswer)
        case .surgery(let words, let killIndex, _):
            QSurgery(words: words, killIndex: killIndex, answered: answered, onAnswer: onAnswer)
        case .rank(let hooks, let correctOrder, _):
            QRank(hooks: hooks, correctOrder: correctOrder, answered: answered, onAnswer: onAnswer)
        case .ab(let versions, let winnerIndex, let marginText, _):
            QAB(versions: versions, winnerIndex: winnerIndex, marginText: marginText,
                answered: answered, onAnswer: onAnswer)
        case .roast(let content, let expertScore, let context, _):
            QRoast(content: content, expertScore: expertScore, context: context,
                   answered: answered, onAnswer: onAnswer)
        case .fix(let phrases, let weakIndex, let fixOptions, let fixCorrectIndex, _):
            QFix(phrases: phrases, weakIndex: weakIndex, fixOptions: fixOptions,
                 fixCorrectIndex: fixCorrectIndex, answered: answered, onAnswer: onAnswer)
        }
    }
}

// MARK: - 1. Hook Assembly

struct QAssemble: View {
    let topic: String
    let fragments: [String]
    let correctOrder: [Int]
    let answered: Bool
    let onAnswer: (Bool) -> Void
    @State private var placed: [Int] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("HOOK ASSEMBLY · \(topic.uppercased())")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(VTheme.secondary)
            Text("Arrange these fragments into the strongest hook")
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(VTheme.text)
            VChipsLayout(spacing: 8) {
                ForEach(Array(placed.enumerated()), id: \.offset) { _, fragIdx in
                    Text(fragments[fragIdx])
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(RoundedRectangle(cornerRadius: 10).fill(VTheme.secondary))
                }
            }
            .frame(minHeight: 60)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(VTheme.bgCard)
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(VTheme.border, lineWidth: 1))
            )
            Text("FRAGMENTS")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(VTheme.textMuted)
            VChipsLayout(spacing: 8) {
                ForEach(Array(fragments.enumerated()), id: \.offset) { i, frag in
                    if !placed.contains(i) {
                        Button { placed.append(i) } label: {
                            Text(frag)
                                .font(.system(size: 14, weight: .heavy))
                                .foregroundStyle(VTheme.text)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(VTheme.bgLight)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(VTheme.border, lineWidth: 1))
                                )
                        }
                        .buttonStyle(.plain)
                        .disabled(answered)
                    }
                }
            }
            Button("Check") {
                if placed.count == fragments.count {
                    onAnswer(placed == correctOrder)
                }
            }
            .buttonStyle(VPrimaryButtonStyle(fill: VTheme.secondary, shadow: VTheme.secondaryDark))
            .disabled(answered || placed.count != fragments.count)
        }
    }
}

// MARK: - 2. Swipe Instinct

struct QSwipe: View {
    let hook: String
    let isViral: Bool
    let answered: Bool
    let onAnswer: (Bool) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SWIPE INSTINCT")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(VTheme.primary)
            Text("Would you keep scrolling, or stop?")
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(VTheme.text)
            Text("\u{201C}\(hook)\u{201D}")
                .font(.system(size: 18, weight: .semibold))
                .italic()
                .foregroundStyle(VTheme.text)
                .fixedSize(horizontal: false, vertical: true)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(VTheme.bgCard)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(VTheme.primary.opacity(0.4), lineWidth: 2))
                )
            HStack(spacing: 12) {
                Button("Scroll Past") { onAnswer(!isViral) }
                    .buttonStyle(VPrimaryButtonStyle(fill: VTheme.danger, shadow: VTheme.dangerDark))
                    .disabled(answered)
                Button("Stop") { onAnswer(isViral) }
                    .buttonStyle(VPrimaryButtonStyle(fill: VTheme.success, shadow: VTheme.successDark))
                    .disabled(answered)
            }
        }
    }
}

// MARK: - 3. Script Surgery

struct QSurgery: View {
    let words: [String]
    let killIndex: Int
    let answered: Bool
    let onAnswer: (Bool) -> Void
    @State private var tapped: Int? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SCRIPT SURGERY")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(VTheme.danger)
            Text("Find and kill the weak word.")
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(VTheme.text)
            VChipsLayout(spacing: 6) {
                ForEach(Array(words.enumerated()), id: \.offset) { i, w in
                    Button {
                        if !answered {
                            tapped = i
                            onAnswer(i == killIndex)
                        }
                    } label: {
                        Text(w)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(rowText(for: i))
                            .strikethrough(answered && (i == killIndex || tapped == i))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(rowFill(for: i))
                            )
                    }
                    .buttonStyle(.plain)
                    .disabled(answered)
                }
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(VTheme.bgCard)
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(VTheme.border, lineWidth: 1))
            )
        }
    }

    private func rowFill(for i: Int) -> Color {
        if !answered { return VTheme.bgLight }
        if i == killIndex { return VTheme.success.opacity(0.3) }
        if tapped == i { return VTheme.danger.opacity(0.3) }
        return VTheme.bgLight
    }

    private func rowText(for i: Int) -> Color {
        if !answered { return VTheme.text }
        if i == killIndex { return VTheme.success }
        if tapped == i { return VTheme.danger }
        return VTheme.text
    }
}

// MARK: - 4. Rank & Stack

struct QRank: View {
    let hooks: [String]
    let correctOrder: [Int]
    let answered: Bool
    let onAnswer: (Bool) -> Void
    @State private var ranks: [Int: Int] = [:]  // hookIndex → rank (1..N)

    var body: some View {
        let n = hooks.count
        VStack(alignment: .leading, spacing: 12) {
            Text("RANK & STACK")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(VTheme.warning)
            Text("Order fire → flop. Tap to assign 1, then 2, etc.")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(VTheme.text)
            ForEach(Array(hooks.enumerated()), id: \.offset) { i, h in
                Button {
                    if !answered {
                        if let r = ranks[i] {
                            // re-tap unassigns
                            ranks[i] = nil
                            // Shift higher ranks down
                            for (k, v) in ranks where v > r { ranks[k] = v - 1 }
                        } else {
                            let next = (ranks.values.max() ?? 0) + 1
                            ranks[i] = next
                        }
                    }
                } label: {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle().fill(ranks[i] == nil ? VTheme.bgLight : VTheme.warning)
                                .frame(width: 32, height: 32)
                            Text(ranks[i].map(String.init) ?? "—")
                                .font(.system(size: 14, weight: .heavy))
                                .foregroundStyle(ranks[i] == nil ? VTheme.textMuted : .black)
                        }
                        Text(h)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(VTheme.text)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(VTheme.bgCard)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(VTheme.border, lineWidth: 1))
                    )
                }
                .buttonStyle(.plain)
                .disabled(answered)
            }
            Button("Check") {
                let userOrder = (1...n).compactMap { rank in ranks.first(where: { $0.value == rank })?.key }
                onAnswer(userOrder == correctOrder)
            }
            .buttonStyle(VPrimaryButtonStyle(fill: VTheme.warning, shadow: VTheme.warningDark))
            .disabled(answered || ranks.count != n)
        }
    }
}

// MARK: - 5. A/B Instinct

struct QAB: View {
    let versions: [String]
    let winnerIndex: Int
    let marginText: String
    let answered: Bool
    let onAnswer: (Bool) -> Void
    @State private var picked: Int? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A/B INSTINCT")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(VTheme.accent)
            Text("Both look reasonable. Pick the one that wins.")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(VTheme.text)
            ForEach(Array(versions.enumerated()), id: \.offset) { i, v in
                Button {
                    if !answered {
                        picked = i
                        onAnswer(i == winnerIndex)
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(String("AB"[String.Index(utf16Offset: i, in: "AB")...].first.map(String.init) ?? "?"))
                            .font(.system(size: 12, weight: .heavy))
                            .foregroundStyle(VTheme.accent)
                        Text(v)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(VTheme.text)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                        if answered && i == winnerIndex {
                            Text("WINNER · +\(marginText)")
                                .font(.system(size: 10, weight: .heavy))
                                .kerning(1.0)
                                .foregroundStyle(VTheme.success)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(rowFill(for: i))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(rowStroke(for: i), lineWidth: 2))
                    )
                }
                .buttonStyle(.plain)
                .disabled(answered)
            }
        }
    }

    private func rowFill(for i: Int) -> Color {
        if !answered { return VTheme.bgCard }
        if i == winnerIndex { return VTheme.success.opacity(0.18) }
        if picked == i { return VTheme.danger.opacity(0.18) }
        return VTheme.bgCard
    }

    private func rowStroke(for i: Int) -> Color {
        if !answered { return picked == i ? VTheme.accent : VTheme.border }
        if i == winnerIndex { return VTheme.success }
        if picked == i { return VTheme.danger }
        return VTheme.border
    }
}

// MARK: - 6. Roast Lab

struct QRoast: View {
    let content: String
    let expertScore: Int
    let context: String
    let answered: Bool
    let onAnswer: (Bool) -> Void
    @State private var picked: Int? = nil  // 0=low, 1=mid, 2=high

    private func bucket(for score: Int) -> Int {
        if score <= 3 { return 0 }
        if score <= 6 { return 1 }
        return 2
    }

    var body: some View {
        let correctBucket = bucket(for: expertScore)
        VStack(alignment: .leading, spacing: 12) {
            Text("ROAST LAB · \(context.uppercased())")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(Color(hex: "FF6B00"))
            Text("Rate this piece of content.")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(VTheme.text)
            Text(content)
                .font(.system(size: 16))
                .foregroundStyle(VTheme.text)
                .fixedSize(horizontal: false, vertical: true)
                .padding(18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(VTheme.bgCard)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color(hex: "FF6B00").opacity(0.4), lineWidth: 2))
                )
            HStack(spacing: 10) {
                ForEach(0..<3) { b in
                    let label = ["DEATH", "MID", "FIRE"][b]
                    let color = [VTheme.danger, VTheme.warning, VTheme.success][b]
                    Button {
                        if !answered {
                            picked = b
                            onAnswer(b == correctBucket)
                        }
                    } label: {
                        Text(label)
                            .font(.system(size: 13, weight: .heavy))
                            .kerning(1.0)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill((answered && b == correctBucket) || picked == b ? color : color.opacity(0.4))
                            )
                    }
                    .buttonStyle(.plain)
                    .disabled(answered)
                }
            }
            if answered {
                HStack {
                    Text("EXPERT SCORE: \(expertScore)/10")
                        .font(.system(size: 12, weight: .heavy))
                        .kerning(1.0)
                        .foregroundStyle(VTheme.text)
                    Spacer()
                }
                .padding(.top, 4)
            }
        }
    }
}

// MARK: - 7. Fix It

struct QFix: View {
    let phrases: [String]
    let weakIndex: Int
    let fixOptions: [String]
    let fixCorrectIndex: Int
    let answered: Bool
    let onAnswer: (Bool) -> Void

    @State private var step: Step = .pickWeak
    @State private var tappedWeak: Int? = nil
    @State private var pickedFix: Int? = nil

    enum Step { case pickWeak, pickFix }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("FIX IT")
                .font(.system(size: 10, weight: .heavy))
                .kerning(1.2)
                .foregroundStyle(VTheme.success)
            Text(step == .pickWeak ? "Tap the weak phrase." : "Pick the strongest replacement.")
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(VTheme.text)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(phrases.enumerated()), id: \.offset) { i, p in
                    Button {
                        if step == .pickWeak && !answered {
                            tappedWeak = i
                            if i == weakIndex {
                                step = .pickFix
                            } else {
                                // wrong on first tap = wrong answer immediately
                                onAnswer(false)
                            }
                        }
                    } label: {
                        Text(p)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(textColorForPhrase(i: i))
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(bgForPhrase(i: i))
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(strokeForPhrase(i: i), lineWidth: 2))
                            )
                    }
                    .buttonStyle(.plain)
                    .disabled(step != .pickWeak || answered)
                }
            }
            if step == .pickFix {
                Text("REPLACEMENTS")
                    .font(.system(size: 10, weight: .heavy))
                    .kerning(1.2)
                    .foregroundStyle(VTheme.textMuted)
                ForEach(Array(fixOptions.enumerated()), id: \.offset) { i, opt in
                    Button {
                        if !answered {
                            pickedFix = i
                            onAnswer(i == fixCorrectIndex)
                        }
                    } label: {
                        Text(opt)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(VTheme.text)
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(bgForFix(i: i))
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(strokeForFix(i: i), lineWidth: 2))
                            )
                    }
                    .buttonStyle(.plain)
                    .disabled(answered)
                }
            }
        }
    }

    private func bgForPhrase(i: Int) -> Color {
        if tappedWeak == i && i == weakIndex { return VTheme.danger.opacity(0.2) }
        if tappedWeak == i && i != weakIndex { return VTheme.danger.opacity(0.1) }
        if step == .pickFix && i == weakIndex { return VTheme.danger.opacity(0.2) }
        return VTheme.bgCard
    }
    private func strokeForPhrase(i: Int) -> Color {
        if tappedWeak == i { return VTheme.danger }
        if step == .pickFix && i == weakIndex { return VTheme.danger }
        return VTheme.border
    }
    private func textColorForPhrase(i: Int) -> Color {
        if step == .pickFix && i == weakIndex { return VTheme.danger }
        return VTheme.text
    }
    private func bgForFix(i: Int) -> Color {
        if answered && i == fixCorrectIndex { return VTheme.success.opacity(0.18) }
        if pickedFix == i && i != fixCorrectIndex { return VTheme.danger.opacity(0.18) }
        return VTheme.bgCard
    }
    private func strokeForFix(i: Int) -> Color {
        if answered && i == fixCorrectIndex { return VTheme.success }
        if pickedFix == i { return VTheme.danger }
        return VTheme.border
    }
}
