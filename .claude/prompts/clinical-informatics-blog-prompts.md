# Clinical Informatics Blog Post Prompts (Karpathy Style)

These example prompts demonstrate how to request narrative-style blog posts for junior clinical informatics students using the Karpathy writing approach.

---

## Healthcare Interoperability Topics

### HL7 v2.x Messaging
```
Write a narrative blog post about HL7 v2.x messaging for junior clinical informatics students.

Start with a story about a lab result's journey through hospital systems at 2 AM.
Use the "text messages for hospital systems" analogy. Explain why pipes and carets
from 1987 still run healthcare today. Include a real message example with a
line-by-line walkthrough. Be honest about how confusing it looks at first, but
show the "aha moment" when the pattern clicks.
```

### FHIR R4 APIs
```
Write a narrative blog post about FHIR R4 for junior clinical informatics students.

Frame this as "what HL7 wanted to be when it grew up." Use the LEGO blocks analogy
for resources. Start with a relatable scenario—like trying to build an app that
pulls patient data from multiple hospitals. Walk through a Patient resource JSON,
explaining each field like you're decoding a secret message. Share what finally
made FHIR click for you (if you struggled with the reference system, say so).
```

### LOINC Codes
```
Write a narrative blog post about LOINC for junior clinical informatics students.

Open with the chaos of lab tests having different names at different hospitals.
Use the "universal product codes for lab tests" analogy. Break down the 6-part
LOINC model using glucose (2345-7) as your running example. Show why "glucose"
alone isn't enough—you need to know from where, when, how measured. Be honest
that memorizing 98,000+ codes is impossible, but understanding the structure
makes it manageable.
```

### SNOMED CT
```
Write a narrative blog post about SNOMED CT for junior clinical informatics students.

Start with "SNOMED CT confused me for months." Explain how it's different from
LOINC—not just codes, but relationships between concepts. Use the "thesaurus on
steroids" analogy. Walk through a concrete example: how "chest pain" connects to
possible diagnoses, anatomical locations, and related findings. Show the hierarchy
visualization and why it matters for clinical decision support.
```

### Interface Engines
```
Write a narrative blog post about interface engines for junior clinical informatics students.

Begin with "The first time I saw an interface engine, it looked like spaghetti with
arrows." Use the Star Trek universal translator analogy. Walk through a real
scenario: an order from Epic needs to reach a lab system. Show the transformation
steps. Include the moment when you realized interface engines are the unsung heroes
of healthcare IT—if they work, nobody notices; if they fail, everything stops.
```

---

## EHR & Clinical Systems Topics

### Clinical Decision Support (CDS)
```
Write a narrative blog post about Clinical Decision Support for junior clinical informatics students.

Start with a 3 AM scenario: a physician almost prescribes a drug the patient is
allergic to, but an alert pops up. That's CDS working. Explain the five rights
of CDS. Be honest about alert fatigue—"yes, sometimes physicians click through
warnings, and here's why that's a bigger problem than it sounds." Walk through
building a simple CDS rule from scratch.
```

### EHR Integration Patterns
```
Write a narrative blog post about EHR integration patterns for junior clinical informatics students.

Open with "Getting different software systems to talk to each other is harder
than it should be." Use the party analogy—getting everyone to speak the same
language. Cover point-to-point vs. hub-and-spoke vs. enterprise bus patterns.
Be honest about the tradeoffs. Include a "what I wish I knew earlier" section
about why integration projects often take longer than expected.
```

### Patient Matching
```
Write a narrative blog post about patient matching for junior clinical informatics students.

Start with the horror story potential: wrong patient's labs attached to another
patient's record. Explain why this is harder than it sounds—people change names,
move, have typos in their records. Walk through matching algorithms: deterministic
vs. probabilistic. Use concrete examples with fake patient data. Be honest about
the "no perfect solution" reality.
```

---

## Data & Terminology Topics

### Healthcare Data Quality
```
Write a narrative blog post about healthcare data quality for junior clinical informatics students.

Begin with "Garbage in, garbage out—but in healthcare, garbage out can hurt
patients." Share a real-world example of how bad data caused problems. Walk
through the dimensions of data quality: accuracy, completeness, timeliness,
consistency. Include practical tips for data validation. Be honest that
perfect data is impossible, but "good enough" is worth fighting for.
```

### ICD-10 Coding
```
Write a narrative blog post about ICD-10 coding for junior clinical informatics students.

Open with the famous example: "W61.33XA - Pecked by a chicken, initial encounter."
Yes, that's real. Explain why ICD-10 has such granularity—billing, research,
epidemiology all need different levels of detail. Walk through the code structure.
Include the transition from ICD-9 to ICD-10 as a cautionary tale about change
management in healthcare.
```

### Terminology Mapping
```
Write a narrative blog post about terminology mapping for junior clinical informatics students.

Start with the problem: Hospital A calls it "blood glucose," Hospital B calls it
"glucose, serum," Lab C calls it "GLU." Same test, different names. Explain why
mapping is necessary for data exchange. Walk through a mapping project step by
step. Be honest about edge cases that don't map cleanly—"sometimes there's no
perfect match, and here's what you do then."
```

---

## Workflow & Process Topics

### Lab Order-to-Result Workflow
```
Write a narrative blog post about the lab order-to-result workflow for junior clinical informatics students.

Follow a single glucose test from the moment a physician clicks "order" to
when the result appears in the chart. Make it a journey with timestamps:
9:00 AM order, 9:35 AM ORM message, 11:30 AM analyzer runs... Use this to
explain every system involved. Include what happens when things go wrong at
each step. End with the "magic" of modern lab integration.
```

### Medication Reconciliation
```
Write a narrative blog post about medication reconciliation for junior clinical informatics students.

Open with the scary statistic: medication errors are a leading cause of
preventable harm. Explain med rec as "detective work"—piecing together
what the patient is actually taking vs. what's documented. Walk through
the workflow with a concrete patient example. Cover the informatics
challenges: multiple data sources, patient recall issues, NDC vs RxNorm
vs generic names.
```

---

## Regulatory & Standards Topics

### HIPAA for Informaticists
```
Write a narrative blog post about HIPAA for junior clinical informatics students.

Start with "HIPAA is the reason you can't just email patient data." Debunk
common myths (no, HIPAA doesn't prevent all data sharing). Explain the
difference between Privacy Rule and Security Rule. Walk through a real
scenario: how to share data for a research project compliantly. Include
the "minimum necessary" principle with practical examples.
```

### 21st Century Cures Act & Information Blocking
```
Write a narrative blog post about information blocking rules for junior clinical informatics students.

Open with "Healthcare used to be really good at keeping data siloed. Now
there are rules against that." Explain the shift in philosophy. Define
information blocking with concrete examples. Walk through the exceptions—
when you CAN restrict access. Be honest about the tension between openness
and privacy/security.
```

---

## Prompt Template

For any clinical informatics topic, use this structure:

```
Write a narrative blog post about [TOPIC] for junior clinical informatics students.

Opening hook: [Specific scenario, personal anecdote, or surprising fact]

Key analogy to use: [Relatable comparison from everyday life or computing]

Main example to walk through: [Concrete, detailed example with real-ish data]

Honest acknowledgment: [What's genuinely hard/confusing about this topic]

"Aha moment" to reach: [The insight that makes everything click]

Practical takeaway: [What readers will be able to do after reading]
```

---

## Style Reminders

When generating blog posts with these prompts, remember:

1. **Conversational tone**: Write like explaining to a curious friend over coffee
2. **First-person narrative**: Use "I remember when...", "What finally clicked for me..."
3. **Layered explanations**: Intuition → Example → Technical detail → Implications
4. **Quantify**: Turn "many" into specific numbers
5. **Acknowledge difficulty**: "This confused me for weeks..."
6. **End with wonder**: "And maybe, like me, you'll find something magical in that."

Reference: [Karpathy Narrative Style Guide](../standards/karpathy-narrative-style.md)
