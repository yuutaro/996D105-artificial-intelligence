#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

fetch() {
  local dir="$1"
  local pdf_url="$2"
  local source_url="$3"

  mkdir -p "$dir"

  curl -L -o "$dir/paper.pdf" "$pdf_url"
  curl -L -o "$dir/source.tar" "$source_url"

  rm -rf "$dir/source"
  mkdir -p "$dir/source"
  tar -xzf "$dir/source.tar" -C "$dir/source"
}

fetch "papers/00 Context Encoders" \
  "https://openaccess.thecvf.com/content_cvpr_2016/papers/Pathak_Context_Encoders_Feature_CVPR_2016_paper.pdf" \
  "https://arxiv.org/e-print/1604.07379"

fetch "papers/01 Instance Discrimination" \
  "https://openaccess.thecvf.com/content_cvpr_2018/papers/Wu_Unsupervised_Feature_Learning_CVPR_2018_paper.pdf" \
  "https://arxiv.org/e-print/1805.01978"

fetch "papers/02 Contrastive Predictive Coding" \
  "https://arxiv.org/pdf/1807.03748.pdf" \
  "https://arxiv.org/e-print/1807.03748"

fetch "papers/03 SimCLR" \
  "https://proceedings.mlr.press/v119/chen20j/chen20j.pdf" \
  "https://arxiv.org/e-print/2002.05709"

fetch "papers/04 MoCo" \
  "https://openaccess.thecvf.com/content_CVPR_2020/papers/He_Momentum_Contrast_for_Unsupervised_Visual_Representation_Learning_CVPR_2020_paper.pdf" \
  "https://arxiv.org/e-print/1911.05722"

python3 - <<'PY'
from pathlib import Path
from pypdf import PdfReader

paper_dirs = [
    Path("papers/00 Context Encoders"),
    Path("papers/01 Instance Discrimination"),
    Path("papers/02 Contrastive Predictive Coding"),
    Path("papers/03 SimCLR"),
    Path("papers/04 MoCo"),
]

for paper_dir in paper_dirs:
    reader = PdfReader(str(paper_dir / "paper.pdf"))
    chunks = []
    for i, page in enumerate(reader.pages, start=1):
        chunks.append(f"===== Page {i} =====\n")
        chunks.append(page.extract_text() or "")
        chunks.append("\n\n")
    (paper_dir / "paper.txt").write_text("".join(chunks), encoding="utf-8")
    print(paper_dir / "paper.txt")
PY
