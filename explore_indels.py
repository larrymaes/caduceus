import matplotlib
matplotlib.use("Agg")  # save plots to files instead of opening windows
import matplotlib.pyplot as plt

snp_fractions = []
indel_fractions = []
snps_in_repeats = 0
indels_in_repeats = 0

with open("data/variants.tsv") as f:
    for line in f:
        chrom, pos, ref, alt, qual, vtype, ad = line.strip().split("\t")

        ref_text, alt_text = ad.split(",")
        ref_count = int(ref_text)
        alt_count = int(alt_text)

        if ref_count + alt_count == 0:
            continue
        alt_fraction = alt_count / (ref_count + alt_count)

        if vtype == "SNP":
            snp_fractions.append(alt_fraction)
        elif vtype == "INDEL":
            indel_fractions.append(alt_fraction)

        # NOTE: bcftools writes SNP REF alleles in uppercase, so this check
        # only detects repeats for indels. Checking SNP positions directly in
        # the reference found 120 of 1,138 SNPs in repeats.
        if ref != ref.upper():
            if vtype == "SNP":
                snps_in_repeats = snps_in_repeats + 1
            elif vtype == "INDEL":
                indels_in_repeats = indels_in_repeats + 1

print(f"SNPs: {len(snp_fractions)}, in repeats: {snps_in_repeats}")
print(f"Indels: {len(indel_fractions)}, in repeats: {indels_in_repeats}")

# Plot: two histograms side by side
fig, axes = plt.subplots(1, 2, figsize=(10, 4))
axes[0].hist(snp_fractions, bins=20, range=(0, 1))
axes[0].set_title(f"SNPs (n={len(snp_fractions)})")
axes[0].set_xlabel("Fraction of reads supporting the variant")
axes[1].hist(indel_fractions, bins=20, range=(0, 1))
axes[1].set_title(f"Indels (n={len(indel_fractions)})")
axes[1].set_xlabel("Fraction of reads supporting the variant")
fig.tight_layout()
fig.savefig("docs/allele_fractions.png", dpi=150)
print("Plot saved to docs/allele_fractions.png")
