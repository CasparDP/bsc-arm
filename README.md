# Advanced Research Methods

BSc-level course on causal inference, experimental design, and econometric methods in accounting research at Rotterdam School of Management, Erasmus University.

## 📚 Course Overview

**Note**: This repository contains materials for **Session 1 of 2**. Session 2 is taught by a colleague and covers more advanced topics. This session is designed to provide foundational knowledge and an introduction to causal inference methods—think of it as laying the groundwork rather than building the whole house.

This session covers:

- Causal inference fundamentals (the "why" behind empirical research)
- Randomized experiments and quasi-experimental designs
- Difference-in-Differences methodology
- Event study analysis
- Practical applications in accounting research

The goal is to equip students with core concepts and intuition before they dive deeper in Session 2.

## 🎓 Materials

- **Lecture Slides**: Interactive RevealJS presentations with R code examples
- **Lecture Notes**: Instructor talking points and interactive discussion prompts
- **Synthetic Data**: R scripts generating reproducible examples (the famous "Becksperiment")

## 🚧 Work in Progress

**Status**: Currently revising until March 2026

I put this on GitHub partly to keep myself accountable. Nothing motivates quite like the theoretical possibility that someone might actually look at your work. If you're reading this and it's before March 2026, you're witnessing the creative process in real-time (read: organized chaos).

## 🛠️ Built With

- [Quarto](https://quarto.org/) - Presentation framework
- [R](https://www.r-project.org/) - Statistical computing and graphics
- [RevealJS](https://revealjs.com/) - HTML presentation framework
- Custom Bauhaus-inspired SCSS theme (because academia needs more geometric bullet points)

## 📖 View the Slides

The slides are hosted via GitHub Pages (once I actually render and push them):

- [Lecture Slides](https://caspardp.github.io/bsc-arm/Advance%20research%20methods.html)
- [Lecture Notes](https://caspardp.github.io/bsc-arm/lecture_notes.html)

## 🔧 Local Development

To render the slides locally:

```bash
# Clone the repository
git clone https://github.com/CasparDP/bsc-arm.git

# Navigate to the project
cd bsc-arm

# Render all materials
quarto render

# Or preview with live reload
quarto preview
```

## 📝 Key Packages

R packages used in examples:

- `tidyverse` - Data manipulation and visualization
- `fixest` - Fast fixed-effects estimations
- `ggfixest` - Event study plots
- `kableExtra` - Publication-ready tables

## 👤 Author

**Caspar David Peter**
Rotterdam School of Management, Accounting Department
📧 peter@rsm.nl
🔗 [ORCID: 0000-0003-0020-1673](https://orcid.org/0000-0003-0020-1673)

## 📚 Key References

- Angrist & Pischke (2015) - _Mastering 'metrics_
- Huntington-Klein (2021) - _The Effect_
- Libby et al. (2002) - _Experimental research in financial accounting_

## 📄 License

Educational materials for academic use at Rotterdam School of Management.

---

_Last updated: December 2025_
_Next major revision: March 2026 (or when the procrastination guilt becomes unbearable)_
