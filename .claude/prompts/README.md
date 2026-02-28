# Research Hub System Prompts

This folder contains system prompts that define the behavior and capabilities of each Research Hub agent.

## Available Prompts

| Prompt | Agent | Purpose |
|--------|-------|---------|
| `system-prompt-research-master.md` | @research-master | Master orchestrator for complete analysis workflows |
| `system-prompt-doc-parser.md` | @research-doc-parser | Document parsing and content extraction |
| `system-prompt-ai-expert.md` | @research-ai-expert | AI/ML concept explanation |
| `system-prompt-clinical-expert.md` | @research-clinical-expert | Clinical workflow explanation |
| `system-prompt-mindmap-creator.md` | @research-mindmap-creator | Mind map creation and visualization |
| `system-prompt-doc-formatter.md` | @research-doc-formatter | Professional document formatting |
| `system-prompt-blog-publisher.md` | @research-blog-publisher | SEO-optimized blog post creation |

## Usage

These prompts define the core behaviors, expertise, and output standards for each agent. They are referenced by the agent definitions in `.claude/agents/`.

## Customization

To customize agent behavior:
1. Copy the relevant prompt file
2. Modify the sections needed
3. Update the agent definition to reference your custom prompt
