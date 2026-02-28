# React Component Generation Patterns

## Component Structure

```jsx
import React, { useState } from 'react';

const DiagramComponent = () => {
  const [activeSection, setActiveSection] = useState(null);
  
  // GENERATED: Data from content analysis
  const sections = [/* generated array */];
  
  return (
    <div className="min-h-screen {background_classes} p-8">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        {/* Central Node (if applicable) */}
        {/* Connection Lines (if applicable) */}
        {/* Content Grid */}
        {/* Footer (optional) */}
      </div>
    </div>
  );
};

export default DiagramComponent;
```

## Data Structure Generation

### From Content Analysis
```javascript
// Input: analyzed content object
// Output: sections array

function generateSectionsData(analyzed) {
  const colorSets = [
    { color: '#059669', bg: '#d1fae5', text: '#065f46' },
    { color: '#0891b2', bg: '#cffafe', text: '#155e75' },
    { color: '#d97706', bg: '#fef3c7', text: '#92400e' },
    { color: '#7c3aed', bg: '#ede9fe', text: '#5b21b6' },
    { color: '#dc2626', bg: '#fee2e2', text: '#991b1b' },
  ];
  
  return analyzed.categories.map((cat, i) => ({
    id: `section${i}`,
    title: cat.title,
    icon: cat.icon,
    ...colorSets[i % colorSets.length],
    items: cat.items.map(item => ({
      name: item.name,
      desc: item.desc || ''
    }))
  }));
}
```

### Output Format
```javascript
const sections = [
  {
    id: 'section0',
    title: 'Category Title',
    icon: '📊',
    color: '#059669',
    bg: '#d1fae5',
    text: '#065f46',
    items: [
      { name: 'Item 1', desc: 'Description' },
      { name: 'Item 2', desc: 'Description' }
    ]
  },
  // ... more sections
];
```

## Component Building Blocks

### Header Block
```jsx
<div className="text-center mb-12">
  {/* Optional badge */}
  {badge && (
    <div className="inline-flex items-center gap-3 bg-white/10 backdrop-blur-sm px-6 py-3 rounded-full mb-6">
      <span className="text-2xl">{badge.icon}</span>
      <span className="text-white font-medium">{badge.text}</span>
    </div>
  )}
  
  {/* Title */}
  <h1 className="text-5xl font-bold text-white mb-4">
    {title.main} {title.highlight && (
      <span className="text-cyan-400">{title.highlight}</span>
    )}
  </h1>
  
  {/* Subtitle */}
  {subtitle && (
    <p className="text-slate-400 text-lg max-w-2xl mx-auto">{subtitle}</p>
  )}
</div>
```

### Central Node Block
```jsx
{centralNode && (
  <div className="relative flex justify-center mb-8">
    <div className="bg-gradient-to-br from-indigo-600 to-purple-700 rounded-2xl p-8 shadow-2xl shadow-indigo-500/30 transform hover:scale-105 transition-transform">
      <div className="text-center">
        <div className="text-4xl mb-2">{centralNode.icon}</div>
        <h2 className="text-2xl font-bold text-white">{centralNode.title}</h2>
        {centralNode.desc && (
          <p className="text-indigo-200 text-sm mt-1">{centralNode.desc}</p>
        )}
      </div>
    </div>
  </div>
)}
```

### Connection Lines Block
```jsx
{showConnections && (
  <>
    <div className="flex justify-center mb-4">
      <div className="h-8 w-px bg-gradient-to-b from-purple-500 to-transparent"></div>
    </div>
    <div className="flex justify-center mb-8">
      <div className="h-px w-4/5 bg-gradient-to-r from-transparent via-purple-500 to-transparent"></div>
    </div>
  </>
)}
```

### Section Card Block
```jsx
{sections.map((section) => (
  <div
    key={section.id}
    className="group cursor-pointer"
    onMouseEnter={() => setActiveSection(section.id)}
    onMouseLeave={() => setActiveSection(null)}
  >
    {/* Header */}
    <div 
      className="rounded-t-xl p-4 transition-all duration-300 group-hover:shadow-lg"
      style={{ 
        backgroundColor: section.color,
        boxShadow: activeSection === section.id 
          ? `0 10px 40px ${section.color}40` 
          : 'none'
      }}
    >
      <div className="flex items-center gap-2 text-white">
        <span className="text-2xl">{section.icon}</span>
        <h3 className="font-bold text-sm uppercase tracking-wide">
          {section.title}
        </h3>
      </div>
    </div>
    
    {/* Body */}
    <div 
      className="rounded-b-xl p-4 space-y-2 transition-all duration-300"
      style={{ backgroundColor: section.bg }}
    >
      {section.items.map((item, idx) => (
        <div 
          key={idx}
          className="bg-white rounded-lg p-3 shadow-sm hover:shadow-md transition-shadow"
        >
          <div 
            className="font-semibold text-sm"
            style={{ color: section.text }}
          >
            {item.name}
          </div>
          {item.desc && (
            <div className="text-slate-500 text-xs">{item.desc}</div>
          )}
        </div>
      ))}
    </div>
  </div>
))}
```

### Footer Block
```jsx
{footer && (
  <div className="mt-12 bg-white/5 backdrop-blur-sm rounded-xl p-6">
    {/* Legend */}
    <div className="flex flex-wrap justify-center gap-6 text-sm">
      {sections.map((section) => (
        <div key={section.id} className="flex items-center gap-2">
          <div 
            className="w-4 h-4 rounded"
            style={{ backgroundColor: section.color }}
          ></div>
          <span className="text-slate-300">{section.title}</span>
        </div>
      ))}
    </div>
    {/* Footer text */}
    {footer.text && (
      <div className="text-center mt-4 text-slate-500 text-xs">
        {footer.text}
      </div>
    )}
  </div>
)}
```

## Grid Layout Selection

```jsx
// Select grid based on number of sections
function getGridClasses(numSections) {
  switch(numSections) {
    case 2: return "grid-cols-1 md:grid-cols-2";
    case 3: return "grid-cols-1 md:grid-cols-3";
    case 4: return "grid-cols-1 md:grid-cols-2 lg:grid-cols-4";
    case 5: return "grid-cols-1 md:grid-cols-3 lg:grid-cols-5";
    case 6: return "grid-cols-1 md:grid-cols-3 lg:grid-cols-6";
    default: return "grid-cols-1 md:grid-cols-3 lg:grid-cols-5";
  }
}

// Usage
<div className={`grid ${getGridClasses(sections.length)} gap-6`}>
```

## Theme Variants

### Dark Theme (default)
```jsx
// Container
className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 p-8"

// Text colors
title: "text-white"
subtitle: "text-slate-400"
footer: "text-slate-500"
legend: "text-slate-300"

// Glass effects
badge: "bg-white/10 backdrop-blur-sm"
footer: "bg-white/5 backdrop-blur-sm"
```

### Light Theme
```jsx
// Container
className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 p-8"

// Text colors
title: "text-slate-900"
subtitle: "text-slate-600"
footer: "text-slate-500"
legend: "text-slate-700"

// Central node adjustment
className="bg-gradient-to-br from-indigo-500 to-purple-600"
```

## Complete Generation Algorithm

```javascript
function generateReactComponent(analyzed) {
  const sections = generateSectionsData(analyzed);
  const gridClasses = getGridClasses(sections.length);
  const theme = analyzed.theme || 'dark';
  
  return `import React, { useState } from 'react';

const ${analyzed.componentName || 'DiagramComponent'} = () => {
  const [activeSection, setActiveSection] = useState(null);
  
  const sections = ${JSON.stringify(sections, null, 2)};

  return (
    <div className="min-h-screen ${theme === 'dark' 
      ? 'bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900' 
      : 'bg-gradient-to-br from-slate-50 to-slate-100'} p-8">
      <div className="max-w-7xl mx-auto">
        
        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="text-5xl font-bold ${theme === 'dark' ? 'text-white' : 'text-slate-900'} mb-4">
            ${analyzed.title}
          </h1>
          <p className="${theme === 'dark' ? 'text-slate-400' : 'text-slate-600'} text-lg">
            ${analyzed.subtitle || ''}
          </p>
        </div>

        ${analyzed.centralNode ? `
        {/* Central Node */}
        <div className="flex justify-center mb-8">
          <div className="bg-gradient-to-br from-indigo-600 to-purple-700 rounded-2xl p-8 shadow-2xl transform hover:scale-105 transition-transform">
            <div className="text-center">
              <div className="text-4xl mb-2">${analyzed.centralNode.icon}</div>
              <h2 className="text-2xl font-bold text-white">${analyzed.centralNode.title}</h2>
              <p className="text-indigo-200 text-sm mt-1">${analyzed.centralNode.desc || ''}</p>
            </div>
          </div>
        </div>
        
        {/* Connections */}
        <div className="flex justify-center mb-4">
          <div className="h-8 w-px bg-gradient-to-b from-purple-500 to-transparent"></div>
        </div>
        <div className="flex justify-center mb-8">
          <div className="h-px w-4/5 bg-gradient-to-r from-transparent via-purple-500 to-transparent"></div>
        </div>
        ` : ''}

        {/* Content Grid */}
        <div className="grid ${gridClasses} gap-6">
          {sections.map((section) => (
            <div
              key={section.id}
              className="group cursor-pointer"
              onMouseEnter={() => setActiveSection(section.id)}
              onMouseLeave={() => setActiveSection(null)}
            >
              <div 
                className="rounded-t-xl p-4 transition-all duration-300"
                style={{ 
                  backgroundColor: section.color,
                  boxShadow: activeSection === section.id ? \`0 10px 40px \${section.color}40\` : 'none'
                }}
              >
                <div className="flex items-center gap-2 text-white">
                  <span className="text-2xl">{section.icon}</span>
                  <h3 className="font-bold text-sm uppercase">{section.title}</h3>
                </div>
              </div>
              <div 
                className="rounded-b-xl p-4 space-y-2"
                style={{ backgroundColor: section.bg }}
              >
                {section.items.map((item, idx) => (
                  <div key={idx} className="bg-white rounded-lg p-3 shadow-sm hover:shadow-md transition-shadow">
                    <div className="font-semibold text-sm" style={{ color: section.text }}>{item.name}</div>
                    {item.desc && <div className="text-slate-500 text-xs">{item.desc}</div>}
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>

      </div>
    </div>
  );
};

export default ${analyzed.componentName || 'DiagramComponent'};`;
}
```

## Tailwind Classes Reference

### Spacing
```
p-8 (container padding)
gap-6 (grid gap)
mb-12 (header margin)
mb-8 (section margins)
p-4 (card padding)
p-3 (item padding)
space-y-2 (item spacing)
```

### Rounding
```
rounded-full (badges)
rounded-2xl (large cards)
rounded-xl (sections)
rounded-lg (items)
```

### Shadows
```
shadow-sm (items)
shadow-md (hover)
shadow-2xl (central node)
shadow-indigo-500/30 (colored shadow)
```

### Transitions
```
transition-all duration-300
transition-shadow
transition-transform
hover:scale-105
hover:shadow-md
```

### Grid Responsive
```
grid-cols-1 (mobile)
md:grid-cols-2 (tablet)
md:grid-cols-3 (tablet)
lg:grid-cols-4 (desktop)
lg:grid-cols-5 (desktop)
lg:grid-cols-6 (wide desktop)
```
