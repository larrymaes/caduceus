#!/usr/bin/env bash
set -euo pipefail

PATIENT="SRR32934938"

echo "Running diagnostics on patient MUTCD0001..."

if [ ! -f "data/${PATIENT}_fastp.html" ]; then
    fastp -i "data/${PATIENT}_1.fastq" -I "data/${PATIENT}_2.fastq" \
        -o "data/${PATIENT}_1.trimmed.fastq.gz" -O "data/${PATIENT}_2.trimmed.fastq.gz" \
        -h "data/${PATIENT}_fastp.html" -j "data/${PATIENT}_fastp.json" \
        -w 8 --detect_adapter_for_pe
else
    echo "Patient already examined, skipping."
fi

echo "Triage complete. Report is in data/${PATIENT}_fastp.html"
echo "Vitals recorded. Patient cleared for alignment."
