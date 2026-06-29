import XCTest
@testable import ViralIQ

/// Locks the progression math (the grep-only triage nearly skipped this app — it has the
/// same Duolingo-style engine as mindcraft). Verified correct, now guarded.
@MainActor
final class ScoringTests: XCTestCase {

    func testEarnedXPFormula() {
        XCTAssertEqual(GameState.earnedXP(correctCount: 5, total: 5, maxCombo: 3), 90) // 60+15+15
        XCTAssertEqual(GameState.earnedXP(correctCount: 3, total: 5, maxCombo: 2), 46) // 36+10+0
        XCTAssertEqual(GameState.earnedXP(correctCount: 0, total: 5, maxCombo: 0), 0)
    }

    func testPerfectBonusOnlyWhenAllCorrect() {
        let imperfect = GameState.earnedXP(correctCount: 4, total: 5, maxCombo: 4)
        let perfect   = GameState.earnedXP(correctCount: 5, total: 5, maxCombo: 4)
        XCTAssertEqual(perfect - imperfect, 12 + 15)
    }

    func testCompleteLessonAddsXPRefillsHeartsAndPerfectFlames() {
        let g = GameState()
        let xp0 = g.xp, flames0 = g.flames
        g.useHeart(); g.useHeart()
        g.completeLesson(skillId: -1, earnedXP: 40, wasPerfect: true)
        XCTAssertEqual(g.xp, xp0 + 40)
        XCTAssertEqual(g.hearts, 5)
        XCTAssertEqual(g.flames, flames0 + 5)
    }
}
