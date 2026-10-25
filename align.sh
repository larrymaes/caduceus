#!/usr/bin/env bash
set -euo pipefail

PATIENT="SRR32934938"
REF="data/reference.fna"

if [ ! -f "${REF}" ]; then
    echo "Unpacking the reference genome..."
    gunzip -k "${REF}.gz"
else
    echo "Reference already unpacked, skipping."
fi

if [ ! -f "${REF}.fai" ]; then
    echo "Indexing the reference..."
    bwa-mem2 index "$REF"
    samtools faidx "$REF"
else
    echo "Reference already indexed, skipping."
fi

if [ ! -f "data/${PATIENT}.bam.bai" ]; then
    echo "Guardian angel deployed. Aligning reads..."
    bwa-mem2 mem -t 8 -R "@RG\tID:${PATIENT}\tSM:MUTCD0001" "$REF" \
        "data/${PATIENT}_1.trimmed.fastq.gz" "data/${PATIENT}_2.trimmed.fastq.gz" \
        | samtools sort -@ 4 -o "data/${PATIENT}.bam"
    samtools index "data/${PATIENT}.bam"
else
    echo "Patient already aligned, skipping."
fi

echo "Alignment vitals:"
samtools flagstat "data/${PATIENT}.bam"
