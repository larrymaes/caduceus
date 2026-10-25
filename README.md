# Caduceus 🩺
*Part of Project MERCY (Mapping Emerging Resistance in Candida Yeasts), named after Mercy's Caduceus Staff from Overwatch.*

Caduceus scans the genomes of *Candida auris* (now *Candidozyma auris*), a drug-resistant fungus, and
predicts which antifungal drugs each one is likely to resist.

This is my second learning project for practicing bioinformatics, Python, and Git.

## Status

🚧 Work in progress

- [x] Set up the environment and repo
- [x] Download an isolate's sequencing reads and the reference genome
- [x] Check read quality
- [x] Align reads and call variants
- [ ] Annotate variants with SnpEff
- [ ] Report likely drug resistance

## Known limitations

- Variant calls are unfiltered. A basic filter (QUAL ≥ 30, depth ≥ 10) keeps 1,036 of 1,138 SNPs.
- The indel count (1,032) is unusually high relative to SNPs. Many may be sequencing errors in A/T-rich repeats; this hasn't been investigated yet.
