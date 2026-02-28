# Domain-Specific Styling Guide

## Healthcare / Clinical

### Color Palette
| Role | Color | Use For |
|------|-------|---------|
| Primary | #0891b2 (Cyan) | Headers, clinical data |
| Secondary | #059669 (Green) | Patient data, outcomes |
| Accent | #7c3aed (Purple) | Analytics, insights |
| Alert | #dc2626 (Red) | Warnings, critical |
| Neutral | #475569 (Slate) | Supporting elements |

### Icons
```
🏥 Hospital/Facility     💊 Medications      🩺 Clinical
📋 Records/Charts        🧬 Genomics         🔬 Lab
👨‍⚕️ Provider            👤 Patient          📊 Analytics
🛡️ Privacy/HIPAA        🔗 Interoperability 📈 Outcomes
```

### Terminology Mapping
```
EHR, EMR → 🗃️ Data Sources (Green)
FHIR, HL7 → 🔗 Standards (Cyan)
OMOP, CDM → 📊 Data Models (Purple)
NLP, AI/ML → 🧠 Analytics (Amber)
PHI, HIPAA → 🛡️ Compliance (Red)
```

---

## Technology / Software

### Color Palette
| Role | Color | Use For |
|------|-------|---------|
| Primary | #6366f1 (Indigo) | Core systems |
| Data | #059669 (Green) | Databases, storage |
| Process | #0891b2 (Cyan) | APIs, services |
| Tools | #d97706 (Amber) | DevOps, utilities |
| Cloud | #7c3aed (Purple) | Infrastructure |

### Icons
```
🖥️ Server/Compute       💾 Storage          🔧 Tools
⚙️ Configuration        🔌 API/Integration  ☁️ Cloud
🐳 Container            📦 Package          🔒 Security
🌐 Network              📊 Monitoring       🚀 Deploy
```

### Terminology Mapping
```
Database, SQL, NoSQL → 💾 Storage (Green)
API, REST, GraphQL → 🔌 Integration (Cyan)
Docker, K8s → 🐳 Containers (Amber)
AWS, Azure, GCP → ☁️ Cloud (Purple)
CI/CD, DevOps → 🚀 Deployment (Indigo)
```

---

## Data Science / ML

### Color Palette
| Role | Color | Use For |
|------|-------|---------|
| Data | #059669 (Green) | Raw data, features |
| Process | #0891b2 (Cyan) | Preprocessing |
| Model | #d97706 (Amber) | ML models |
| Evaluate | #7c3aed (Purple) | Metrics, validation |
| Deploy | #6366f1 (Indigo) | Production |

### Icons
```
📊 Data                 🧹 Preprocessing     🧠 Model
📈 Training             🎯 Evaluation        🚀 Deployment
🔬 Experiment           📉 Metrics           💡 Insights
🔄 Pipeline             ⚡ Inference         📦 MLOps
```

### Terminology Mapping
```
Dataset, Features → 📊 Data (Green)
ETL, Transform → 🧹 Preprocessing (Cyan)
Training, Fine-tuning → 🧠 Model (Amber)
Accuracy, F1, AUC → 🎯 Evaluation (Purple)
API, Endpoint → 🚀 Deployment (Indigo)
```

---

## Business / Enterprise

### Color Palette
| Role | Color | Use For |
|------|-------|---------|
| Strategy | #6366f1 (Indigo) | Leadership, goals |
| Operations | #059669 (Green) | Processes |
| Finance | #d97706 (Amber) | Revenue, costs |
| People | #7c3aed (Purple) | HR, teams |
| Risk | #dc2626 (Red) | Compliance |

### Icons
```
🎯 Strategy             📈 Growth           💰 Finance
👥 Teams                🏢 Organization     📋 Process
⚖️ Compliance          🔒 Risk             📊 Analytics
🤝 Partnerships        🌍 Global           📅 Planning
```

---

## Research / Academic

### Color Palette
| Role | Color | Use For |
|------|-------|---------|
| Theory | #6366f1 (Indigo) | Concepts |
| Method | #0891b2 (Cyan) | Methodology |
| Data | #059669 (Green) | Collection |
| Analysis | #d97706 (Amber) | Processing |
| Results | #7c3aed (Purple) | Findings |

### Icons
```
📚 Literature           🔬 Research         📝 Methods
📊 Data                 🧪 Experiment       📈 Results
💡 Hypothesis           🎓 Academic         📖 Publication
🔍 Analysis             ✅ Validation       🏆 Impact
```

---

## Domain Detection Heuristics

### Keyword Matching
```python
clinical_keywords = ['EHR', 'patient', 'clinical', 'FHIR', 'diagnosis', 
                     'treatment', 'OMOP', 'ICD', 'SNOMED', 'healthcare']

tech_keywords = ['API', 'database', 'server', 'cloud', 'deploy', 
                 'container', 'microservice', 'kubernetes', 'docker']

ml_keywords = ['model', 'training', 'dataset', 'features', 'accuracy',
               'prediction', 'neural', 'transformer', 'embedding']

business_keywords = ['revenue', 'strategy', 'stakeholder', 'ROI',
                     'compliance', 'governance', 'process', 'workflow']
```

### Auto-Assignment Rules
1. Count keyword matches per domain
2. Select domain with highest match count
3. If tie or unclear → use Technology (most versatile)
4. Apply domain's color palette and icons

---

## Theme Variations

### Dark Theme (Presentations)
```
Background: linear-gradient(135deg, #1e293b, #0f172a)
Text: #fff (titles), #94a3b8 (subtitles)
Cards: Use gradient fills with glow effects
Lines: 60% opacity, matching primary color
```

### Light Theme (Documents)
```
Background: #fafbfc or #ffffff
Text: #1e293b (titles), #64748b (subtitles)
Cards: Solid fills with soft shadows
Lines: 40% opacity, gray or primary color
```

### Print-Optimized
```
Background: #ffffff
Text: #000000
Cards: White with colored borders only
Lines: Solid black or dark gray
Avoid: Gradients, glows, transparency
```
