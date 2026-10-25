#!/usr/bin/env bash
set -euo pipefail

PATIENT="SRR32934938"
REF="data/reference.fna"
VCF="data/${PATIENT}.vcf.gz"

if [ ! -f "${VCF}.csi" ]; then
    echo "Running diagnosis on patient MUTCD0001..."
    bcftools mpileup -f "$REF" -a AD,DP -Ou "data/${PATIENT}.bam" \
        | bcftools call --ploidy 1 -mv -Oz -o "$VCF"
    bcftools index "$VCF"
else
    echo "Diagnosis already complete, skipping."
fi

echo "Diagnosis report:"
bcftools stats "$VCF" | grep "^SN"
