# Podcast Script Standards

## Overview
Standards for generating engaging, educational audio podcast scripts from research content.

## Script Structure

### Episode Format
```
Duration: 10-20 minutes (2,500-5,000 words)
Speakers: Host + Expert (minimum), up to 3 experts for panel discussions
Segments: Introduction, Main Topics (3-5), Summary, Call-to-Action
```

### Dialogue Requirements

1. **Natural Conversation Flow**
   - Use conversational language, avoid academic jargon
   - Include verbal fillers sparingly ("you know", "right", "exactly")
   - Add speaker reactions and acknowledgments
   - Balance speaking time between participants

2. **Educational Engagement**
   - Start with a hook question or surprising fact
   - Use analogies to explain complex concepts
   - Include real-world examples and case studies
   - Summarize key points at natural breakpoints

3. **OHDSI-Specific Content**
   - Explain OMOP CDM concepts in accessible terms
   - Use clinical examples that resonate with healthcare professionals
   - Reference OHDSI community resources and tools
   - Include network study examples when relevant

## Voice Characteristics

### Host Voice
- Curious, engaging, asks clarifying questions
- Guides the conversation flow
- Summarizes complex points for audience
- Introduces topics and transitions

### Expert Voice
- Authoritative but approachable
- Provides depth and technical accuracy
- Shares practical insights and experience
- Responds to questions with examples

## Script Formatting

### Speaker Tags
```markdown
**Host:** [dialogue]

**Expert:** [dialogue]

**[Sound Effect: transition music]**

**[Pause: 2 seconds]**
```

### Emphasis Markers
```markdown
*emphasized word* - slight stress
**key concept** - important term
[spell out: OMOP] - pronunciation guide
```

## Content Guidelines

### Do Include
- Opening hook within first 30 seconds
- Clear topic transitions with verbal cues
- Audience-directed questions ("Have you ever wondered...")
- Actionable takeaways
- Resources and next steps

### Avoid
- Long monologues (max 60 seconds per speaker)
- Excessive technical acronyms without explanation
- Reading statistics without context
- Abrupt topic changes
- Inside jokes or references

## Quality Checklist

- [ ] Total word count within range (2,500-5,000)
- [ ] Natural dialogue flow (read aloud test)
- [ ] All technical terms explained on first use
- [ ] Speaker balance (no one dominates >60%)
- [ ] Clear introduction and conclusion
- [ ] Actionable takeaways included
- [ ] OHDSI resources referenced appropriately

## TTS Optimization

### For edge-tts
- Use punctuation for natural pauses
- Avoid complex sentence structures
- Include breathing pauses with ellipses
- Mark emphasis with SSML-compatible markers

### For ElevenLabs
- Leverage voice emotion settings
- Use speaker tags for voice switching
- Include direction notes for tone
- Consider multi-voice dialogue support
