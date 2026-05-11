import SwiftUI

enum VTheme {
    static let bg = Color(hex: "08080F")
    static let bgCard = Color(hex: "10101C")
    static let bgLight = Color(hex: "18182A")
    static let border = Color(hex: "252538")
    static let primary = Color(hex: "00D4FF")          // cyan
    static let primaryDark = Color(hex: "00A8CC")
    static let secondary = Color(hex: "FF2D87")        // pink
    static let secondaryDark = Color(hex: "D41E6E")
    static let success = Color(hex: "00FF88")
    static let successDark = Color(hex: "00CC6E")
    static let danger = Color(hex: "FF3355")
    static let dangerDark = Color(hex: "CC2244")
    static let accent = Color(hex: "A855F7")
    static let accentDark = Color(hex: "8B3FD9")
    static let warning = Color(hex: "FFD600")
    static let warningDark = Color(hex: "CCB000")
    static let text = Color(hex: "EEEEF4")
    static let textSec = Color(hex: "8888A8")
    static let textMuted = Color(hex: "555570")
}

struct VCard<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) { self.content = content }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) { content() }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(VTheme.bgCard)
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(VTheme.border, lineWidth: 1))
            )
    }
}

struct VPrimaryButtonStyle: ButtonStyle {
    var fill: Color = VTheme.primary
    var shadow: Color = VTheme.primaryDark
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .heavy))
            .textCase(.uppercase)
            .kerning(1.2)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(RoundedRectangle(cornerRadius: 14).fill(fill))
            .offset(y: configuration.isPressed ? 4 : 0)
            .padding(.bottom, configuration.isPressed ? 1 : 5)
            .background(RoundedRectangle(cornerRadius: 14).fill(shadow).offset(y: 5))
            .animation(.easeOut(duration: 0.08), value: configuration.isPressed)
    }
}

struct VStatPill: View {
    let icon: String
    let value: String
    let color: Color
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .heavy))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 14, weight: .heavy))
                .foregroundStyle(VTheme.text)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8).fill(VTheme.bgCard)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(VTheme.border, lineWidth: 1))
        )
    }
}

struct VChipsLayout: Layout {
    var spacing: CGFloat = 6
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? .infinity
        var x: CGFloat = 0, y: CGFloat = 0, mh: CGFloat = 0, mw: CGFloat = 0
        for sv in subviews {
            let s = sv.sizeThatFits(.unspecified)
            if x + s.width > width && x > 0 {
                y += mh + spacing; x = 0; mh = 0
            }
            x += s.width + spacing; mh = max(mh, s.height); mw = max(mw, x)
        }
        return CGSize(width: mw, height: y + mh)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let width = bounds.width
        var x: CGFloat = bounds.minX, y: CGFloat = bounds.minY, mh: CGFloat = 0
        for sv in subviews {
            let s = sv.sizeThatFits(.unspecified)
            if x + s.width > bounds.minX + width && x > bounds.minX {
                y += mh + spacing; x = bounds.minX; mh = 0
            }
            sv.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(s))
            x += s.width + spacing; mh = max(mh, s.height)
        }
    }
}
