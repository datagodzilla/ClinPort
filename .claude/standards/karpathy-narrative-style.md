# Karpathy-Inspired Narrative Writing Style Guide

## Overview

This writing style guide is modeled after Andrej Karpathy's technical blog posts, which masterfully combine rigorous technical content with engaging narrative storytelling. This approach is particularly effective for junior clinical informatics students who benefit from relatable explanations, personal anecdotes, and a sense of wonder about the material.

**Target Audience:** Junior clinical informatics students with foundational healthcare knowledge but limited technical/data science background.

**Reference Posts:**
- [The Unreasonable Effectiveness of RNNs](https://karpathy.github.io/2015/05/21/rnn-effectiveness/)
- [What I Learned from Competing Against a ConvNet on ImageNet](https://karpathy.github.io/2014/09/02/what-i-learned-from-competing-against-a-convnet-on-imagenet/)
- [Biohacking Lite](https://karpathy.github.io/2020/06/11/biohacking-lite/)

---

## Core Principles

### 1. Write Like You're Explaining to a Curious Friend

**Not this:**
> "HL7 v2.x utilizes pipe-delimited message structures with hierarchical field separators for healthcare data interchange."

**But this:**
> "Here's the thing about HL7 messages that took me a while to truly appreciate: they're basically the text messages of healthcare IT. Literally pipe characters (`|`) separating fields, like some programmer in 1987 said 'eh, CSV but different.' And somehow this format is *still* running in hospitals everywhere. There's something almost beautiful about that."

### 2. Lead with Wonder and Curiosity

Start sections with genuine enthusiasm. Make readers feel the intrinsic interest of the subject.

**Example opening:**
> "I still remember the first time I saw an HL7 message scroll across a terminal. It looked like absolute chaos—a soup of pipes and carets and random numbers. But here's what nobody tells you: once you learn to read it, it's like suddenly understanding a foreign language. Each segment tells a story about a patient, a test, a result. There's a kind of magic in that."

### 3. Use First-Person Narrative

Write from personal experience. Share your learning journey, mistakes, and "aha" moments.

**Phrases that work:**
- "When I first started learning about FHIR, I made every mistake possible..."
- "I remember being confused about this for weeks until..."
- "Let me tell you about the time I accidentally..."
- "Here's what finally made it click for me..."

### 4. Acknowledge Complexity Honestly

Don't pretend things are simpler than they are. Readers appreciate honesty.

**Example:**
> "Okay, I'm going to be honest with you: the LOINC code structure is kind of a lot. There are six parts, each with its own vocabulary, and when you first look at it, your brain will want to give up. Mine certainly did. But stick with me—we'll break this down piece by piece, and by the end you'll actually understand why '2345-7' means 'glucose in serum.'"

### 5. Layer Explanations from Simple to Complex

Build understanding progressively. Start with intuition, then add rigor.

**Pattern:**
1. **Hook**: Why should I care?
2. **Intuition**: Plain English explanation with analogy
3. **Concrete Example**: Show me, don't just tell me
4. **Technical Detail**: Now the formal version
5. **Deeper Implications**: Why this matters in practice

---

## Writing Techniques

### Analogies and Metaphors

Always anchor abstract concepts to familiar ideas, especially from everyday life or computing.

**Clinical Informatics Examples:**

| Concept | Analogy |
|---------|---------|
| HL7 v2.x messages | "Text messages for hospital systems—short, structured, sometimes cryptic" |
| FHIR resources | "Like LEGO blocks for health data—standardized pieces that snap together" |
| LOINC codes | "Universal product codes (UPCs) but for lab tests—same test, same code, anywhere in the world" |
| SNOMED CT | "A thesaurus on steroids—not just words, but the relationships between every clinical concept" |
| Interface engine | "The universal translator from Star Trek, but for healthcare systems" |
| EHR integration | "Like getting everyone at a party to speak the same language—harder than it sounds" |

### Humor as a Teaching Tool

Use jokes and observations to disarm intimidating material. Self-deprecating humor works particularly well.

**Examples:**
> "The HL7 standard was first published in 1987. For context, that's the same year as the first Final Fantasy game. One of these has had consistent updates and improvements. I'll let you guess which one. (Okay fine, both have. But HL7 took longer.)"

> "Pro tip: if you ever want to feel humble, try explaining to a physician why their lab order didn't go through because of a missing caret in an OBR segment. Ask me how I know."

### Quantification and Concreteness

Turn abstract concepts into specific numbers and tangible examples.

**Instead of:** "LOINC contains many codes for laboratory tests."

**Write:** "LOINC currently has over 98,000 codes. That's roughly one code for every possible way you could measure something in a human body. Glucose alone has dozens of codes—fasting glucose, random glucose, glucose in urine, glucose in cerebrospinal fluid... you get the idea."

### Strategic Pacing

Alternate between:
- Dense technical content
- Light explanatory passages
- Visual breaks (diagrams, code snippets)
- Personal anecdotes or humor

**Pattern for long sections:**
```
[Technical explanation - 2-3 paragraphs]
[Concrete example or visualization]
[Brief personal observation or "here's the thing..."]
[Continue with next concept]
```

### Anticipate Confusion

Directly address common misconceptions or confusing points.

**Examples:**
> "Now you might be thinking: 'Wait, if LOINC identifies the test, why do we also need SNOMED CT?' Great question. This confused me for months. Here's the key insight..."

> "At this point, you're probably asking: 'Why doesn't everyone just use FHIR and stop dealing with HL7 v2?' If only it were that simple. Let me explain why hospitals still run on pipes and carets..."

---

## Structure Templates

### Opening Hook (First 2-3 paragraphs)

**Template:**
```markdown
[Engaging scenario or personal anecdote that illustrates the topic]

[Why this matters / the problem we're solving]

[Promise of what the reader will understand by the end]

"In this post, we'll [journey through / explore / break down] [topic],
and by the end you'll understand [concrete outcome]. Let's dive in."
```

**Example:**
> Picture this: It's 2 AM in the emergency department. A patient arrives with chest pain. The physician orders a troponin test. Within minutes, the lab receives the order, processes the sample, and sends the results back—all without a single phone call or fax. This seemingly simple workflow involves at least four different software systems speaking three different "languages."
>
> How does this actually work? How does a lab order typed into Epic end up in a completely different lab system, and how do the results find their way back? This is the story of healthcare interoperability—the plumbing that makes modern medicine possible.
>
> In this post, we'll trace the journey of a lab order from physician click to result display, and by the end you'll be able to read HL7 messages like they're plain English. Let's dive in.

### Section Transitions

Use conversational transitions that maintain momentum:

- "But we're getting ahead of ourselves. Let's start with the basics..."
- "Okay, now that we understand [X], things get interesting..."
- "Here's where it gets fun..."
- "Now let's zoom in on..."
- "Armed with this understanding, we can tackle..."
- "This brings us to the really cool part..."

### Code and Technical Examples

When showing code or technical content:

1. **Prepare the reader**: "Let me show you what this actually looks like..."
2. **Show the example**: Keep it minimal and focused
3. **Walk through it**: Explain line by line with personality
4. **Connect to the bigger picture**: "So what this means in practice is..."

**Example:**
> Let me show you an actual HL7 message. Don't panic—I'll explain every character:
>
> ```hl7
> MSH|^~\&|EPIC|HOSPITAL|LAB|LABCORP|20231115||ORM^O01|12345|P|2.5
> ```
>
> Okay, let's decode this chaos. The first three characters `MSH` are like a label saying "hey, this is the message header." The pipe `|` separates fields. And `^~\&`? Those are escape characters (we'll get there).
>
> See that `ORM^O01`? That's the message type—an order message. When you see this, you know someone just ordered something. In our case, a lab test.

### Closing with Impact

End with:
1. **Summary of the journey**: What we learned together
2. **Broader implications**: Why this matters beyond the immediate topic
3. **Call to curiosity**: Inspire further exploration
4. **Optional: Personal reflection**

**Example:**
> We've covered a lot of ground—from HL7's pipe-delimited origins to FHIR's modern JSON elegance, from LOINC's universal test codes to SNOMED's semantic web of clinical meaning. These aren't just standards; they're the invisible infrastructure that lets a lab result from Chicago be understood in Tokyo.
>
> The next time you see a lab value pop up in a patient chart, you'll know the journey it took to get there. And maybe, like me, you'll find something almost magical in that.

---

## Clinical Informatics-Specific Guidelines

### For Healthcare Topics

- Always connect to real clinical scenarios (the ER at 2 AM, the physician ordering tests)
- Use patient stories (fictional, HIPAA-safe) to illustrate concepts
- Reference familiar clinical workflows before diving into technical details
- Acknowledge the clinical stakes: "This isn't just about data—it's about patient care"

### For Technical Topics

- Start with the "why" from a clinical perspective
- Use healthcare analogies first, then computing analogies
- Show real examples from EHRs (Epic, Cerner references are relatable)
- Connect to job scenarios: "When you're the informaticist on call and..."

### For Standards (HL7, FHIR, LOINC, SNOMED)

- Humanize the history: "Imagine being an engineer in 1987..."
- Acknowledge the messiness: "Yes, it's complicated. Here's why that happened..."
- Show the evolution: "This is how we got from there to here"
- Emphasize practical application: "You'll actually use this when..."

---

## Tone Checklist

Before publishing, verify your writing:

- [ ] **Conversational**: Would you say this to a colleague over coffee?
- [ ] **Enthusiastic**: Does your genuine interest in the topic come through?
- [ ] **Humble**: Do you acknowledge what's hard and what you don't know?
- [ ] **Concrete**: Are abstract concepts grounded in specific examples?
- [ ] **Progressive**: Do you build from simple to complex?
- [ ] **Engaging**: Would a reader want to keep reading?
- [ ] **Honest**: Are you being straight about complexity and tradeoffs?
- [ ] **Personal**: Is there a human voice behind the writing?

---

## Quick Reference: Phrases That Work

### Opening Lines
- "Here's the thing about [X] that nobody tells you..."
- "I still remember the first time I..."
- "Let me tell you about the time..."
- "There's something almost magical about..."
- "Picture this scenario..."

### Transitions
- "But we're getting ahead of ourselves..."
- "Okay, now things get interesting..."
- "Here's where it gets fun..."
- "Armed with this understanding..."
- "Let's zoom in on..."

### Acknowledging Difficulty
- "I'm going to be honest with you..."
- "This confused me for weeks until..."
- "Your brain will want to give up. Mine did too."
- "Yes, this is as complicated as it looks. But..."

### Building Curiosity
- "But here's the really cool part..."
- "And this is where things get interesting..."
- "Wait, it gets better..."
- "You might be surprised to learn..."

### Closing Thoughts
- "The next time you see [X], you'll know..."
- "And maybe, like me, you'll find something [magical/fascinating/beautiful] in that."
- "We've covered a lot of ground..."
- "These aren't just [standards/concepts]—they're..."

---

## Version History

- **v1.0** (2025-12-01): Initial style guide based on Karpathy blog analysis
