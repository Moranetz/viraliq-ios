// Auto-generated from viral/viraliq_v3.jsx QQ + skill metadata.
import Foundation

enum QuestionsData {
    static let skills: [Skill] = [
        Skill(
            id: 1,
            name: "Hook Assembly",
            descLine: "Build hooks from fragments",
            sfSymbol: "puzzlepiece.fill",
            colorHex: "FF2D87",
            colorDarkHex: "D41E6E",
            questions: [
                .assemble(topic: "Money advice video", fragments: ["The thing", "nobody tells you", "about money", "is..."], correctOrder: [0, 1, 2, 3], explanation: ""),
                .assemble(topic: "Skincare exposé", fragments: ["is secretly aging you", "Your skincare routine", "— and your dermatologist knows it"], correctOrder: [1, 0, 2], explanation: ""),
                .assemble(topic: "Kitchen hack", fragments: ["my $200 blender", "This $3 gadget", "replaced"], correctOrder: [1, 2, 0], explanation: ""),
                .assemble(topic: "Career change story", fragments: ["here's what actually happened", "I quit my 6-figure job", "and"], correctOrder: [1, 2, 0], explanation: ""),
                .assemble(topic: "Fitness myth-busting", fragments: ["that actually builds muscle", "nobody talks about", "The workout"], correctOrder: [2, 1, 0], explanation: ""),
                .assemble(topic: "Diet experiment", fragments: ["— my body changed", "I ate the same thing", "for 30 days"], correctOrder: [1, 2, 0], explanation: ""),
                .assemble(topic: "Paradox hook", fragments: ["(and got richer)", "I stopped", "saving money"], correctOrder: [1, 2, 0], explanation: ""),
                .assemble(topic: "Dating advice", fragments: ["is actually a green flag", "The dating red flag", "that"], correctOrder: [1, 2, 0], explanation: ""),
            ]
        ),
        Skill(
            id: 2,
            name: "Swipe Instinct",
            descLine: "2-second gut decisions",
            sfSymbol: "eye.fill",
            colorHex: "00D4FF",
            colorDarkHex: "00A8CC",
            questions: [
                .swipe(hook: "Hey guys! Welcome back to my channel, today I want to share something cool", isViral: false, explanation: "Generic intro. Zero tension. Invisible to the algorithm."),
                .swipe(hook: "I spent $10,000 on a course and this is the ONLY thing worth remembering", isViral: true, explanation: "Investment stakes + curiosity gap + filtering to ONE insight."),
                .swipe(hook: "So I've been thinking about productivity for a while now...", isViral: false, explanation: "Preamble = permission to scroll. Lead with the insight, not the context."),
                .swipe(hook: "POV: You just realized your entire resume is doing the opposite of what you want", isViral: true, explanation: "POV + identity threat + curiosity gap = thumb stopper."),
                .swipe(hook: "Your doctor won't tell you this about water", isViral: true, explanation: "Forbidden knowledge + authority distrust + universal topic."),
                .swipe(hook: "Like and subscribe for more content! Anyway, today I wanted to talk about...", isViral: false, explanation: "CTA before value + 'anyway' = literally asking them to leave."),
                .swipe(hook: "I found something behind my walls during renovation that made me call the police", isViral: true, explanation: "Discovery + danger + authority involvement = triple open loop."),
                .swipe(hook: "Here are some tips and tricks for better sleep hygiene and overall wellness", isViral: false, explanation: "Descriptive title energy. Zero mystery. Zero stakes."),
            ]
        ),
        Skill(
            id: 3,
            name: "Script Surgery",
            descLine: "Find and kill the weak word",
            sfSymbol: "scissors",
            colorHex: "FF3355",
            colorDarkHex: "CC2244",
            questions: [
                .surgery(words: ["The", "thing", "nobody", "tells", "you", "about", "money", "is", "actually", "really", "quite", "interesting"], killIndex: 10, explanation: "'Quite' is a hedge that deflates energy. Viral content COMMITS."),
                .surgery(words: ["I", "wanted", "to", "share", "why", "hustle", "culture", "is", "dead"], killIndex: 1, explanation: "'Wanted to share' is permission-seeking preamble. Just SAY it."),
                .surgery(words: ["This", "$5", "hack", "literally", "changed", "how", "I", "basically", "clean"], killIndex: 7, explanation: "'Basically' screams uncertainty. Cut filler. Be direct."),
                .surgery(words: ["Nobody", "is", "talking", "about", "this", "and", "I", "think", "it", "matters"], killIndex: 7, explanation: "'I think' hedges the claim. 'This changes everything' > 'I think it matters'."),
                .surgery(words: ["Stop", "buying", "protein", "powder", "—", "here's", "what", "you", "should", "probably", "do"], killIndex: 9, explanation: "'Probably' kills authority. Viewers want certainty, not maybe."),
                .surgery(words: ["Unpopular", "opinion:", "everyone", "should", "sort", "of", "learn", "to", "cook"], killIndex: 4, explanation: "'Sort of' neuters the hot take. Full conviction or don't bother."),
                .surgery(words: ["I", "discovered", "something", "insane", "—", "you", "guys", "might", "want", "this"], killIndex: 7, explanation: "'Might' undercuts the hook. 'You NEED this' > 'you might want this'."),
                .surgery(words: ["This", "one", "mistake", "is", "honestly", "ruining", "your", "sleep", "every", "night"], killIndex: 4, explanation: "'Honestly' is filler. Don't announce realness — just BE real."),
            ]
        ),
        Skill(
            id: 4,
            name: "Rank & Stack",
            descLine: "Order hooks fire to flop",
            sfSymbol: "chart.bar.fill",
            colorHex: "FFD600",
            colorDarkHex: "CCB000",
            questions: [
                .rank(hooks: ["Nobody told me this but...", "Hey guys welcome back!", "The thing your dentist hides from you", "So today I want to talk about teeth"], correctOrder: [2, 0, 3, 1], explanation: "Forbidden knowledge > curiosity gap > preamble > generic intro."),
                .rank(hooks: ["I was wrong about everything", "Here's my take on investing", "$0 to $10K in 30 days — here's how", "Investing tips you should know"], correctOrder: [2, 0, 1, 3], explanation: "Specific transformation > bold admission > opinion > generic tips."),
                .rank(hooks: ["POV: Your whole routine is wrong", "I have some fitness tips", "The lie fitness influencers sell you", "Let me explain working out"], correctOrder: [0, 2, 3, 1], explanation: "POV identity hook > exposé > explainer > generic value promise."),
                .rank(hooks: ["Stop doing this immediately", "Things to know about cooking", "The $2 trick that changed my skin", "My thoughts on skincare"], correctOrder: [2, 0, 3, 1], explanation: "Specific + transformation > command > opinion > generic listicle."),
                .rank(hooks: ["I tested every AI tool so you don't have to", "AI tools are cool", "The AI tool nobody knows about", "Let me review some AI tools"], correctOrder: [0, 2, 3, 1], explanation: "Sacrifice narrative > hidden gem > generic review > descriptor."),
                .rank(hooks: ["Day 1 vs Day 365 of learning piano", "I started learning piano", "Watch this piano transformation", "Piano practice vlog #47"], correctOrder: [0, 2, 1, 3], explanation: "Visual contrast promise > transformation > statement > series fatigue."),
                .rank(hooks: ["Replying to @Sarah who said I can't cook", "Easy recipe ideas", "Gordon Ramsay would cry watching this", "Today's recipe is pasta"], correctOrder: [2, 0, 3, 1], explanation: "Authority + emotion > reply drama > basic description > no hook."),
                .rank(hooks: ["You're showering wrong — a dermatologist explains", "Shower tips", "Hot take: cold showers are a scam", "My shower routine"], correctOrder: [0, 2, 3, 1], explanation: "Authority + challenge > hot take > routine > tips."),
            ]
        ),
        Skill(
            id: 5,
            name: "A/B Instinct",
            descLine: "Pick the winner — both look good",
            sfSymbol: "bolt.fill",
            colorHex: "A855F7",
            colorDarkHex: "8B3FD9",
            questions: [
                .ab(versions: ["5 Tips for Better Sleep", "I Slept Like a Navy SEAL for 30 Days — Here's What Happened"], winnerIndex: 1, marginText: "340%", explanation: "Transformation + specificity + time constraint > generic listicle."),
                .ab(versions: ["The thing nobody tells you about renting in NYC", "NYC Apartment Hunting Tips"], winnerIndex: 0, marginText: "180%", explanation: "Curiosity gap + forbidden knowledge > descriptive title."),
                .ab(versions: ["I Tested TikTok's Most Viral Recipe So You Don't Have To", "This Viral Recipe Is Actually Good"], winnerIndex: 0, marginText: "220%", explanation: "Sacrifice narrative > opinion statement."),
                .ab(versions: ["Stop Wasting Money on These 'Healthy' Foods", "Healthy Foods That Aren't Actually Healthy"], winnerIndex: 0, marginText: "160%", explanation: "Command + loss aversion > restatement without stakes."),
                .ab(versions: ["My Morning Routine", "I Woke Up at 4AM for 100 Days — It Nearly Broke Me"], winnerIndex: 1, marginText: "290%", explanation: "Extreme commitment + vulnerability > generic routine."),
                .ab(versions: ["How to Start a Business With $0", "I Built a $50K Business Using Only Free Tools — Here's My Playbook"], winnerIndex: 1, marginText: "250%", explanation: "Specific proof + generosity > vague how-to."),
                .ab(versions: ["Why You Should Journal", "I Journaled Every Day for a Year — My Therapist Noticed Something Weird"], winnerIndex: 1, marginText: "310%", explanation: "Time commitment + third-party validation + mystery > advice."),
                .ab(versions: ["Unpopular Opinion: College Is Overrated", "I Dropped Out of Harvard and Make More Than My Professors"], winnerIndex: 1, marginText: "270%", explanation: "Personal proof + status flip > generic hot take."),
            ]
        ),
        Skill(
            id: 6,
            name: "Roast Lab",
            descLine: "Calibrate your quality radar",
            sfSymbol: "flame.fill",
            colorHex: "FF6B00",
            colorDarkHex: "CC5500",
            questions: [
                .roast(content: "Hey everyone! Welcome back, if you're new here subscribe! Today we're talking about...", expertScore: 2, context: "First 8 seconds of YouTube", explanation: "Generic intro + sub beg + no hook = death."),
                .roast(content: "POV: Your 'healthy' smoothie has more sugar than a candy bar", expertScore: 8, context: "TikTok hook", explanation: "POV + identity threat + specific comparison."),
                .roast(content: "5 Tips for Better Productivity #productivity #tips #fyp #viral", expertScore: 2, context: "TikTok caption", explanation: "Generic listicle + hashtag spam."),
                .roast(content: "I spent 6 months in a van. The thing nobody warns you about isn't the loneliness.", expertScore: 9, context: "YouTube hook", explanation: "Investment + twist + open loop. Forces 'then what IS it?'"),
                .roast(content: "Money tips! Save more! Invest early! Compound interest!", expertScore: 2, context: "Reel hook", explanation: "Exclamation points aren't energy. Zero specificity."),
                .roast(content: "The recruiter's face when I asked what the ACTUAL salary range was", expertScore: 8, context: "TikTok hook", explanation: "Relatability + status flip + confrontation."),
                .roast(content: "Here's a really good pasta recipe your family will love", expertScore: 3, context: "Shorts hook", explanation: "'Really good' = meaningless. No specificity."),
                .roast(content: "I analyzed 500 viral TikToks. 94% did this ONE thing in the first second.", expertScore: 9, context: "YouTube hook", explanation: "Data + massive sample + specificity + curiosity."),
            ]
        ),
        Skill(
            id: 7,
            name: "Fix It",
            descLine: "Tap-swap weak phrases into strong",
            sfSymbol: "wrench.and.screwdriver.fill",
            colorHex: "00FF88",
            colorDarkHex: "00CC6E",
            questions: [
                .fix(phrases: ["I wanted to share", "some tips", "about getting better at cooking"], weakIndex: 0, fixOptions: ["Stop ruining your food —", "I wanted to share", "Here's a thought about"], fixCorrectIndex: 0, explanation: "'I wanted to share' is passive preamble. Commands beat requests."),
                .fix(phrases: ["Here's", "my take", "on why budgeting is important"], weakIndex: 2, fixOptions: ["on why your budget is lying to you", "on budgets", "about money stuff"], fixCorrectIndex: 0, explanation: "'Is important' is limp. 'Is lying to you' creates conflict + stakes."),
                .fix(phrases: ["I think", "this productivity hack", "might change your mornings"], weakIndex: 0, fixOptions: ["This", "I think", "Maybe"], fixCorrectIndex: 0, explanation: "'I think' hedges. Remove it. Let the claim stand with confidence."),
                .fix(phrases: ["So basically", "this skincare ingredient", "is kind of dangerous"], weakIndex: 2, fixOptions: ["is destroying your skin barrier", "is kind of dangerous", "exists in products"], fixCorrectIndex: 0, explanation: "'Kind of dangerous' = no urgency. 'Destroying your skin barrier' = immediate stakes."),
                .fix(phrases: ["This workout", "is pretty good", "for building muscle fast"], weakIndex: 1, fixOptions: ["is pretty good", "builds more muscle than 2 hours in the gym", "is decent"], fixCorrectIndex: 1, explanation: "'Pretty good' = forgettable. Specific comparison = memorable and shareable."),
                .fix(phrases: ["Not many people know", "that this app", "can save you money"], weakIndex: 2, fixOptions: ["saved me $4,200 last year", "can save you money", "is good for finances"], fixCorrectIndex: 0, explanation: "'Can save you money' = vague. '$4,200 last year' = specific proof."),
                .fix(phrases: ["This relationship advice", "changed my perspective", "on dating"], weakIndex: 1, fixOptions: ["changed my perspective", "saved my marriage in 48 hours", "was interesting"], fixCorrectIndex: 1, explanation: "'Changed my perspective' = abstract. 'Saved my marriage in 48 hours' = stakes + speed."),
                .fix(phrases: ["Most people", "don't realize", "that their morning coffee habit is fine"], weakIndex: 2, fixOptions: ["that their morning coffee is slowly wrecking their sleep", "that coffee is okay", "that their coffee habit is fine"], fixCorrectIndex: 0, explanation: "'Is fine' = no tension. 'Slowly wrecking their sleep' = hidden threat + urgency."),
            ]
        ),
    ]
}