# SVG Generation Patterns

## Document Structure

```xml
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {WIDTH} {HEIGHT}" 
     style="background: {BACKGROUND}">
  <defs>
    <!-- Gradients and filters -->
  </defs>
  
  <!-- Content sections in order -->
</svg>
```

## Dynamic Sizing Calculator

```
WIDTH = 200 + (NUM_COLUMNS * 220)
HEIGHT = 300 + (MAX_ITEMS_PER_COLUMN * 50) + 120

Examples:
3 columns, 4 items → 860 x 520
5 columns, 5 items → 1300 x 670
5 columns, 3 items → 1300 x 570
```

## Building Blocks

### Gradient Generator
```xml
<!-- Generate one per category -->
<linearGradient id="{category_id}Grad" x1="0%" y1="0%" x2="100%" y2="100%">
  <stop offset="0%" style="stop-color:{primary_color}"/>
  <stop offset="100%" style="stop-color:{secondary_color}"/>
</linearGradient>
```

Color pairs (primary → secondary):
- Green: #059669 → #10b981
- Cyan: #0891b2 → #06b6d4
- Amber: #d97706 → #f59e0b
- Purple: #7c3aed → #a78bfa
- Red: #dc2626 → #ef4444
- Indigo: #6366f1 → #8b5cf6

### Filter Effects
```xml
<!-- Standard shadow -->
<filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
  <feDropShadow dx="0" dy="4" stdDeviation="8" flood-color="#000" flood-opacity="0.3"/>
</filter>

<!-- Glow for central node -->
<filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
  <feGaussianBlur stdDeviation="10" result="blur"/>
  <feFlood flood-color="{glow_color}" flood-opacity="0.4"/>
  <feComposite in2="blur" operator="in"/>
  <feMerge>
    <feMergeNode/>
    <feMergeNode in="SourceGraphic"/>
  </feMerge>
</filter>
```

### Title Section
```xml
<!-- Position: top center -->
<text x="{WIDTH/2}" y="50" text-anchor="middle" 
      font-family="Segoe UI, sans-serif" font-size="36" font-weight="700" 
      fill="{title_color}">{TITLE}</text>
<text x="{WIDTH/2}" y="80" text-anchor="middle" 
      font-family="Segoe UI, sans-serif" font-size="16" 
      fill="{subtitle_color}">{SUBTITLE}</text>
```

### Central Node
```xml
<!-- Position: centered below title -->
<g filter="url(#glow)">
  <rect x="{(WIDTH-300)/2}" y="110" width="300" height="80" rx="16" 
        fill="url(#coreGrad)"/>
  <text x="{WIDTH/2}" y="145" text-anchor="middle" 
        font-family="Segoe UI, sans-serif" font-size="20" font-weight="700" 
        fill="#fff">{ICON} {CENTRAL_TITLE}</text>
  <text x="{WIDTH/2}" y="170" text-anchor="middle" 
        font-family="Segoe UI, sans-serif" font-size="12" 
        fill="#e0e7ff">{CENTRAL_DESC}</text>
</g>
```

### Connection Lines Generator
```python
# Calculate line paths from central node to each column
def generate_connections(num_columns, width, central_y=190, target_y=260):
    central_x = width / 2
    column_width = 220
    start_x = (width - (num_columns * column_width - 20)) / 2 + 100
    
    paths = []
    for i in range(num_columns):
        target_x = start_x + (i * column_width)
        # Calculate curved path
        mid_y = (central_y + target_y) / 2
        offset = (i - num_columns/2) * 50
        path = f"M {central_x + offset} {central_y} L {central_x + offset} {mid_y} L {target_x} {mid_y} L {target_x} {target_y}"
        paths.append(path)
    return paths
```

SVG output:
```xml
<g stroke="#6366f1" stroke-width="2" fill="none" opacity="0.6">
  <!-- One path per column -->
  <path d="{path_string}"/>
</g>
```

### Category Column Generator
```xml
<!-- Calculate X position: start_x + (column_index * 220) -->
<g filter="url(#shadow)">
  <!-- Header -->
  <rect x="{X}" y="260" width="200" height="40" rx="8" 
        fill="url(#{category_id}Grad)"/>
  <text x="{X+100}" y="287" text-anchor="middle" 
        font-family="Segoe UI, sans-serif" font-size="14" font-weight="700" 
        fill="#fff">{ICON} {CATEGORY_TITLE}</text>
  
  <!-- Body - height = 45 + (num_items * 45) -->
  <rect x="{X}" y="305" width="200" height="{BODY_HEIGHT}" rx="8" 
        fill="{bg_color}"/>
  
  <!-- Items - generated dynamically -->
  {ITEMS}
</g>
```

### Item Generator
```xml
<!-- Y position: 315 + (item_index * 45) -->
<rect x="{X+10}" y="{ITEM_Y}" width="180" height="40" rx="6" fill="#fff"/>
<text x="{X+100}" y="{ITEM_Y+22}" text-anchor="middle" 
      font-family="Segoe UI, sans-serif" font-size="13" font-weight="600" 
      fill="{text_color}">{ITEM_NAME}</text>
<text x="{X+100}" y="{ITEM_Y+35}" text-anchor="middle" 
      font-family="Segoe UI, sans-serif" font-size="10" 
      fill="#6b7280">{ITEM_DESC}</text>
```

### Footer
```xml
<text x="{WIDTH/2}" y="{HEIGHT-25}" text-anchor="middle" 
      font-family="Segoe UI, sans-serif" font-size="11" 
      fill="#475569">{FOOTER_TEXT}</text>
```

## Layout Algorithms

### Architecture (Top-Bottom)
```
1. Title at y=50
2. Central node at y=110
3. Connection lines from y=190 to y=260
4. Columns start at y=260
5. Column X = margin + (index * column_width)
6. Footer at HEIGHT - 25
```

### Pipeline (Left-Right)
```
1. Title at top
2. Nodes arranged horizontally with arrows
3. Each node: x = margin + (index * node_spacing)
4. Arrow between each pair of nodes
```

### Mind Map (Radial)
```
Center: (WIDTH/2, HEIGHT/2)
Branches at angles: 360° / num_branches
Branch length: 200-250px
Sub-nodes extend from branch endpoints
```

## Complete Generation Example

Input:
```
categories = [
    {"title": "Data Sources", "icon": "📊", "items": [
        {"name": "EHR Notes", "desc": "Clinical text"},
        {"name": "Lab Results", "desc": "Structured data"}
    ]},
    {"title": "Processing", "icon": "⚙️", "items": [
        {"name": "Tokenization", "desc": "Text splitting"},
        {"name": "De-ID", "desc": "PHI removal"}
    ]}
]
```

Output calculation:
```
num_columns = 2
max_items = 2
WIDTH = 200 + (2 * 220) = 640
HEIGHT = 300 + (2 * 50) + 120 = 520
column_start_x = (640 - (2 * 220 - 20)) / 2 = 110
```

## Backgrounds

### Dark Gradient
```xml
style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%)"
```

### Light Solid
```xml
style="background: #fafbfc"
```

### Transparent (for embedding)
```xml
style="background: transparent"
```

## Export Considerations

### For Print
- Use RGB colors, avoid transparency
- Minimum font size: 10px
- Include xmlns attribute

### For Web
- Optimize with SVGO if needed
- Consider viewBox for responsiveness
- Test at multiple scales
