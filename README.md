# ViralIQ · iOS

> A deliberate-practice training app for the seven core hook-writing skills that decide whether someone scrolls past your content or stops. 7 skills × 7 distinct interaction types × 8 questions = 56 exercises that teach mechanism, not template recall.

**Status:** iOS 17.0+ · SwiftUI · sim-validated · App Store submission pending Marion's ASC click. Third of three persuasion-training games shipped this quarter (after Reality Distortion + MindCraft).

---

## What this is

Most content-training apps tell you what worked. ViralIQ teaches you HOW to make it work — the underlying mechanisms behind why a hook stops the thumb. The skills compound. Spotting a weak word in someone else's script (Script Surgery) is the same mental move as catching it in your own (Fix It). Recognizing why a hook outperforms its variant (A/B Instinct) is the same mental move as building one from fragments (Hook Assembly).

## The seven interaction types

| Skill | Interaction | What it trains |
|---|---|---|
| Hook Assembly | Arrange fragments into a hook | Sentence-order architecture |
| Swipe Instinct | 2-second viral / not-viral decision | Pattern recognition under time pressure |
| Script Surgery | Tap the weak word | Hedge-word and filler detection |
| Rank & Stack | Order four hooks fire-to-flop | Relative-quality calibration |
| A/B Instinct | Pick the winner from two reasonable variants | Subtle-edge intuition |
| Roast Lab | Score content fire / mid / death | Absolute-quality calibration |
| Fix It | Tap weak phrase, pick strong replacement | Diagnose-then-replace mechanic |

## Game mechanics

Identical heart/combo/XP/flame economy across the persuasion-training suite (R-D / MindCraft / ViralIQ):
- 5 hearts per lesson, wrong answer costs one, run out = end lesson
- Combo stacking on consecutive correct
- XP = 12 per correct + 5 per max combo + 15 perfect bonus
- Flames (+5 per perfect lesson)
- Skill-progression unlock (0.2 per lesson, mastered at 1.0)

## What it is not

- No analytics, no advertising, no third-party SDKs — runs entirely on-device. See [privacy](https://moranetz.github.io/viraliq-docs/privacy.html).
- No account, no cloud sync, no in-app purchase
- Not a content-marketing app, not a chatbot

## Source repo structure

```
viraliq-ios/
├── project.yml                  # XcodeGen config
├── ViralIQ.xcodeproj
├── ViralIQ/
│   ├── ViralIQApp.swift         # @main + launch-arg phase nav
│   ├── Models.swift             # GameState, Skill, 7-case Question enum
│   ├── QuestionsData.swift      # 56 questions × 7 skill types, generated from source
│   ├── Theme.swift              # VTheme palette, VCard, VPrimaryButtonStyle, VChipsLayout
│   ├── HomeTab.swift            # StreakBanner, ProgressCard, SkillTreeView with zigzag
│   ├── LessonScreen.swift       # Question runner with progress + hearts + combo
│   ├── QuestionView.swift       # All 7 question UIs (QAssemble, QSwipe, QSurgery,
│                                #  QRank, QAB, QRoast, QFix)
│   ├── LessonComplete.swift     # Post-lesson stats
│   ├── ReferenceTab.swift       # 7-skill library with per-skill mastery %
│   ├── ProfileTab.swift         # XP / streak / flames / mastered stat grid
│   └── Assets.xcassets/         # AppIcon (cyan→pink gradient + viral-spike chart)
├── ExportOptions.plist
├── fastlane/                    # beta + meta + preflight lanes
├── scripts/preflight_check.sh
└── README.md
```

## Build

```bash
xcodegen generate
xcodebuild -project ViralIQ.xcodeproj -scheme ViralIQ \
  -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -configuration Debug build CODE_SIGNING_ALLOWED=NO
```

## Ship

```bash
./scripts/preflight_check.sh
bundle exec fastlane beta    # TestFlight
bundle exec fastlane meta    # metadata + screenshots
# Submit for Review in ASC web UI
```

## The trio

| Game | What it trains | Repo |
|---|---|---|
| **Reality Distortion** | Frame-stacking against named NPC weaknesses | `Moranetz/reality-distortion-ios` |
| **MindCraft** | Recognizing seven persuasion mechanisms in copy | `Moranetz/mindcraft-ios` |
| **ViralIQ** | Composing thumb-stop hooks across seven interaction types | this repo |

All three follow the same scaffolding pattern — XcodeGen + 9-file SwiftUI structure + programmatic AppIcon + public docs repo + fastlane lanes + 15-gate preflight script. Third ship cost less than the second; the second cost less than the first.

## License

MIT.
