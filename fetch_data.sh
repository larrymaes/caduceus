#!/usr/bin/env bash
set -euo pipefail
echo "Caduceus online. Preparing the field hospital..."

PATIENT="SRR32934938"
mkdir -p data
BASE_URL="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/759/435/GCA_002759435.3_Cand_auris_B8441_V3"

echo "Fetching the reference genome..."
if [ ! -f data/reference.fna.gz ]; then
    curl -fL -o data/reference.fna.gz "$BASE_URL/GCA_002759435.3_Cand_auris_B8441_V3_genomic.fna.gz"
else
    echo "Reference already on file, skipping."
fi

if [ ! -f data/reference.gff.gz ]; then
    curl -fL -o data/reference.gff.gz "$BASE_URL/GCA_002759435.3_Cand_auris_B8441_V3_genomic.gff.gz"
else
    echo "Gene annotations already on file, skipping."
fi

echo "Admitting patient MUTCD0001..."
if [ ! -f "data/${PATIENT}_1.fastq" ]; then
    fasterq-dump "$PATIENT" --split-files --threads 8 --progress -O data
else
    echo "Patient already admitted, skipping."
fi

echo "Field hospital ready. Patient awaiting diagnosis."
