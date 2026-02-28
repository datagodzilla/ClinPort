---
name: feynman-technique
description: "Apply the Feynman Technique to explain complex concepts simply. Named after physicist Richard Feynman, this method breaks down topics into first-principles explanations that anyone can understand."
allowed-tools: read, write, task
---

# Feynman Technique Skill

## Purpose
Transform complex technical, clinical, or scientific concepts into clear, accessible explanations using the Feynman Technique. This method ensures deep understanding by forcing explanations in simple terms, identifying knowledge gaps, and building intuitive understanding.

## When to Activate
- User asks to "explain like I'm 5" or "explain simply"
- Content needs to be accessible to non-experts
- Technical topics need first-principles explanations
- Educational content creation
- Blog posts for junior learners
- Healthcare data concepts need demystification

**Key Triggers**: explain simply, Feynman, first principles, ELI5, dumb it down, make it simple, for beginners, accessible explanation

## The Feynman Technique - 4 Steps

### Step 1: Choose the Concept
Identify the specific concept to explain. Be precise:
- Not "OMOP CDM" but "What is the PERSON table in OMOP CDM?"
- Not "Machine Learning" but "How does a decision tree classify patients?"
- Not "FHIR" but "How does a FHIR Patient resource represent a person?"

### Step 2: Teach It to a Child (or Curious Beginner)
Write an explanation as if teaching someone with:
- No prior knowledge of the domain
- Natural curiosity and intelligence
- No patience for jargon or hand-waving

**Rules**:
- Use only simple, everyday words
- No acronyms without explanation
- Every technical term gets a plain-English definition
- Use concrete analogies from everyday life
- Build from what they already know

### Step 3: Identify Gaps
Review your explanation and find:
- Where you used jargon or technical terms
- Where the logic skipped steps
- Where you assumed prior knowledge
- Where your explanation became vague or circular

**Gap Indicators**:
- "...and then it basically..."
- "...which is essentially..."
- "...it just works by..."
- Any sentence requiring domain knowledge

### Step 4: Simplify and Use Analogies
For each gap identified:
1. Go back to source material
2. Build understanding from first principles
3. Create a concrete analogy
4. Test: Can a complete beginner follow this?

## Analogy Library for Healthcare Data

### Data Concepts
| Concept | Analogy |
|---------|---------|
| Database | Filing cabinet with organized drawers and folders |
| Table | Spreadsheet with rows and columns |
| Primary Key | Social Security Number - unique ID for each person |
| Foreign Key | Reference number that points to another record |
| JOIN | Connecting two spreadsheets using a common column |
| ETL | Moving books from one library to another, reorganizing along the way |

### Healthcare Standards
| Concept | Analogy |
|---------|---------|
| OMOP CDM | Universal translator that makes all hospital systems speak the same language |
| Standard Concept | Official dictionary word everyone agrees on |
| Source Concept | Local dialect or slang that means the same thing |
| Vocabulary Mapping | Translation dictionary between dialects |
| HL7 v2 | Text message with special punctuation rules |
| FHIR Resource | LEGO block with specific connection points |
| SNOMED CT | Medical thesaurus on steroids with family trees |
| LOINC | UPC barcode system for lab tests |
| RxNorm | Universal product catalog for medications |

### Clinical Concepts
| Concept | Analogy |
|---------|---------|
| Cohort | Guest list for a specific party (patients who meet criteria) |
| Index Date | The "start" line of a race - when observation begins |
| Observation Period | Time when the patient is "visible" in the data |
| Washout Period | Quarantine period to ensure no prior exposure |
| New User Design | Only inviting first-time guests to the party |
| Propensity Score | Match.com compatibility score for patients |
| Confounding | Hidden factor that tricks you into wrong conclusions |

### Technical/ML Concepts
| Concept | Analogy |
|---------|---------|
| Feature | Question on a form that helps classify someone |
| Model Training | Studying flashcards until you can predict answers |
| Overfitting | Memorizing answers vs. understanding concepts |
| Cross-validation | Practice tests before the real exam |
| AUC-ROC | How well a test separates sick from healthy (like a metal detector's sensitivity) |
| Calibration | Does "30% chance of rain" mean it actually rains 30% of the time? |

## Explanation Templates

### The Hook-Explain-Verify Template
```markdown
## [Concept Name]

### The Hook (Why Should I Care?)
[Start with a real-world scenario or problem this solves]

### The Simple Explanation
Imagine you're [relatable scenario]...

[Concept] is like [analogy].

When you [action], it [result], just like how [analogy extension].

### Let's Break It Down
1. **First, [step 1]**: Think of it like [analogy 1]
2. **Then, [step 2]**: This is similar to [analogy 2]
3. **Finally, [step 3]**: Just like when you [familiar action]

### The Verification Question
Can you explain [concept] to a friend using only everyday words?

Test: [Simple question to verify understanding]
```

### The Journey Template (Feynman + Karpathy Style)
```markdown
## [Concept Name]

I remember the first time I encountered [concept]. It seemed impossibly complex. Then someone showed me this...

### Start Here (What You Already Know)
You know how [familiar thing] works? [Concept] is surprisingly similar.

### The Key Insight
Here's what finally made it click for me: [core insight in one sentence].

It's like [primary analogy]. When you [action], [result].

### Building Up
Let's layer on the details:

**Layer 1 - The Basics**: [Simplest version]
**Layer 2 - Adding Detail**: [Next level of complexity]
**Layer 3 - The Full Picture**: [Complete explanation]

### The "Aha!" Moment
The thing that surprised me most? [Non-obvious insight].

### Try It Yourself
Next time you see [related thing], you'll recognize [concept] in action.
```

## Integration with NotebookLM Artifacts

### With Podcasts
When generating podcast scripts, use Feynman-style explanations:
```markdown
[HOST]: So what exactly is [concept]?

[EXPERT]: Great question! Think of it like this...

Imagine you have [simple analogy]. [Concept] works the same way.

[HOST]: Oh! So it's basically [restatement]?

[EXPERT]: Exactly! And here's the cool part...
```

### With Flashcards
Create Feynman-style flashcard fronts:
```markdown
**Front**: Explain [concept] as if to a 10-year-old.

**Back**:
[Concept] is like [analogy].

When you need to [purpose], it helps by [mechanism].

Simple version: [One sentence explanation]
```

### With Slides
Use the "One Concept, One Slide" rule:
```markdown
# [Concept Name]

## It's Like...
[Single analogy with visual]

## In Practice
[One concrete example]

## Key Takeaway
[One sentence summary]
```

## Quality Checks

### The Grandmother Test
Could your grandmother follow this explanation? If not, simplify further.

### The Jargon Scan
Ctrl+F for these warning signs:
- "essentially"
- "basically"
- "in other words"
- Any acronym without definition
- Any term not in everyday vocabulary

### The Gap Detection
Red flags in your explanation:
- "...and so forth"
- "...etc."
- "...and stuff like that"
- Any hand-waving or vague connectors

### The Rebuild Test
After writing, can you rebuild the concept from your explanation alone?

## Example: Explaining OMOP CDM

### Before (Jargon-Heavy)
"The OMOP CDM is a standardized data schema that provides a common structure for observational healthcare data, enabling systematic analysis across disparate databases through standardized vocabulary concepts."

### After (Feynman Style)
"Imagine every hospital keeps patient records in a different language - one uses Spanish, another Chinese, another Morse code. If you wanted to study all patients together, you'd spend forever just translating.

OMOP CDM is like creating one universal language that all hospitals agree to use. When a hospital joins, they translate their local language into the universal one. Now, a researcher can ask one question and get answers from all hospitals at once.

The magic is in the 'dictionary' - called vocabularies. If Hospital A says 'heart attack' and Hospital B says 'MI' and Hospital C uses code '410.11', the dictionary knows they all mean the same thing. It gives them all one 'standard' code that everyone uses.

So OMOP CDM = Universal language + Standard dictionary = Ask once, answer everywhere."

## Output Location

```
docs/[topic]/explanations/
├── [concept]_feynman.md           # Full Feynman-style explanation
├── [concept]_analogies.md         # Analogy library for the topic
└── [concept]_simplified.md        # Ultra-simplified version
```

## Integration Points

### Used By
- `/research-generate-blog-post` - For accessible blog content
- `/notebooklm-generate-podcast` - For conversational explanations
- `/notebooklm-generate-flashcards` - For clear Q&A pairs
- `/notebooklm-generate-slides` - For presentation content

### Works With
- `@research-ai-expert` - Technical concept simplification
- `@research-clinical-expert` - Clinical concept simplification
- `@research-blog-publisher` - Accessible content generation

## Best Practices

1. **Start Simpler Than You Think**: Your first draft is always too complex
2. **Use Concrete Numbers**: "98,000 codes" beats "many codes"
3. **One Analogy Per Concept**: Don't overload with metaphors
4. **Test on Non-Experts**: If they're confused, simplify more
5. **Iterate Ruthlessly**: Rewrite until a beginner can teach it back

## See Also
- Skill: karpathy-narrative-style
- Standard: karpathy-narrative-style.md
- Command: /research-generate-blog-post
