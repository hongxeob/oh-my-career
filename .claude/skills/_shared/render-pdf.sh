#!/bin/bash
# HTML → PDF 렌더 + 검사. pdf-resume와 portfolio가 공유한다.
# 사용: bash .claude/skills/_shared/render-pdf.sh <html> <pdf> [목표페이지수]
#
# 이 파일이 존재하는 이유: 예전엔 두 스킬이 각자 Chrome 경로와 검사 명령을 적어놨고,
# pdf-resume만 실측으로 고쳐서 portfolio 쪽은 없는 바이너리 3개를 부르다 죽었다.
# 환경 지식은 여기 한 곳에만 둔다.
set -euo pipefail
HTML="$1"; PDF="$2"; TARGET="${3:-0}"

# 이 맥에는 /Applications에 Chrome이 없고 ~/.cache/puppeteer에 Chrome for Testing이 있다
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || CHROME=$(ls -d ~/.cache/puppeteer/chrome/*/chrome-*/*.app/Contents/MacOS/* 2>/dev/null | head -1)
if [ ! -x "${CHROME:-}" ]; then
  echo "❌ Chrome 없음. 설치: npx --yes @puppeteer/browsers install chrome@stable"
  echo "   받은 뒤 ~/.cache/puppeteer/ 로 옮긴다 (기본 경로가 현재 디렉토리라 리포가 더러워진다)"; exit 1
fi
# pkill 하지 않는다 — headless는 사용자가 열어둔 Chrome과 충돌하지 않는다
"$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 \
  --print-to-pdf="$(pwd)/$PDF" --no-pdf-header-footer "file://$(pwd)/$HTML"

python3 - "$PDF" "$TARGET" <<'PY'
import re, sys, zlib
pdf, target = sys.argv[1], int(sys.argv[2])
d = open(pdf, 'rb').read()

# 페이지 수 — pdfinfo(poppler)는 이 환경에 없다.
# grep -c "/Type /Page" 로 세지 말 것: /Type /Pages 까지 잡혀 부정확하다.
pages = int(re.search(rb'/Count\s+(\d+)', d).group(1))
print(f"PAGES: {pages}" + (f"  (목표 {target})" if target else ""))

# 폰트 — Thin/Light가 보이면 가변 폰트 축 최솟값이 잡힌 것이다 (2026-09 실측 사고)
fonts = sorted(set(re.findall(rb'/FontName\s*/([A-Za-z0-9+,\-]+)', d)))
print("FONTS:", [f.decode() for f in fonts])
if any(b'Thin' in f or b'Light' in f for f in fonts):
    print("  ⚠️ Thin/Light 감지 — 템플릿에 웹폰트 @import가 남아 있는지 확인할 것")

# 페이지별 텍스트 밀도 — 빈 페이지·오버플로우 탐지 (pdftotext 대용, 역시 이 환경에 없음)
objs = {int(m.group(1)): m.start() for m in re.finditer(rb'(?m)^(\d+)\s+0\s+obj', d)}
def stream(n):
    s = d.find(b'stream', objs[n]); e = d.find(b'endstream', s)
    raw = d[s+6:e].lstrip(b'\r\n')
    try: return zlib.decompress(raw)
    except Exception: return raw
for i, c in enumerate(re.findall(rb'/Type\s*/Page[^s].*?/Contents\s+(\d+)\s+0\s+R', d, re.S), 1):
    ops = len(re.findall(rb'(?:TJ|Tj)', stream(int(c))))
    print(f"  p{i}: 텍스트연산 {ops}" + ("  ⚠️ 거의 빈 페이지" if ops < 20 else ""))

if target and pages > target:
    print(f"❌ 목표 {target}p 초과 ({pages}p). 앞 페이지가 절반 넘게 비었으면 콘텐츠가 아니라")
    print("   break-inside: avoid 계열 CSS를 먼저 의심할 것.")
    sys.exit(2)
PY
