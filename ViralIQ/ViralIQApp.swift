import SwiftUI

@main
struct ViralIQApp: App {
    init() {
        #if DEBUG
        if ProcessInfo.processInfo.environment["RT_SELFTEST"] != nil {
            MainActor.assumeIsolated {
                NSLog("ROUNDTRIP_RESULT: %@", GameState.roundTripSelfTest())
            }
        }
        #endif
    }

    @StateObject private var game: GameState = {
        let g = GameState()
        let args = ProcessInfo.processInfo.arguments
        if args.contains("-completedSome") {
            if g.skills.count >= 2 {
                g.skills[0].status = .done
                g.skills[0].progress = 1.0
                g.skills[1].status = .current
                g.skills[1].progress = 0.4
            }
            g.xp = 198
            g.lessonsCompleted = 5
            g.streak = 3
            g.flames = 45
        }
        return g
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(game)
                .preferredColorScheme(.dark)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var game: GameState
    @State private var tab: AppTab = {
        let args = ProcessInfo.processInfo.arguments
        if args.contains("-tabReference") { return .reference }
        if args.contains("-tabProfile") { return .profile }
        return .home
    }()

    enum AppTab: Hashable { case home, reference, profile }

    var body: some View {
        ZStack {
            VTheme.bg.ignoresSafeArea()
            VStack(spacing: 0) {
                TopBar()
                TabView(selection: $tab) {
                    HomeTab()
                        .tag(AppTab.home)
                        .tabItem { Label("Learn", systemImage: "graduationcap.fill") }
                    ReferenceTab()
                        .tag(AppTab.reference)
                        .tabItem { Label("Reference", systemImage: "book.closed.fill") }
                    ProfileTab()
                        .tag(AppTab.profile)
                        .tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
                }
                .tint(VTheme.primary)
            }
        }
    }
}

struct TopBar: View {
    @EnvironmentObject var game: GameState
    var body: some View {
        HStack(spacing: 6) {
            Text("VIRALIQ")
                .font(.system(size: 15, weight: .heavy))
                .kerning(1.6)
                .foregroundStyle(VTheme.text)
                .lineLimit(1)
                .fixedSize()
            Spacer(minLength: 8)
            VStatPill(icon: "flame.fill", value: "\(game.streak)", color: VTheme.secondary)
            VStatPill(icon: "bolt.fill", value: "\(game.xp)", color: VTheme.primary)
            VStatPill(icon: "heart.fill", value: "\(game.hearts)", color: VTheme.danger)
            VStatPill(icon: "diamond.fill", value: "\(game.flames)", color: VTheme.warning)
        }
        .padding(.horizontal, 12)
        .padding(.top, 8)
        .padding(.bottom, 10)
        .background(VTheme.bg)
    }
}
