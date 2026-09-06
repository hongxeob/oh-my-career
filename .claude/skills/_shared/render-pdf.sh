#!/bin/bash
# HTML → PDF 렌더 + 검사. pdf-resume와 portfolio가 공유한다.
# 사용: bash .claude/skills/_shared/render-pdf.sh <html> <pdf> [최대페이지] [최소페이지]
#
# 종료코드로 분기한다 (메시지 문자열로 분기하지 말 것 — 문구를 바꾸면 게이트가 조용히 죽는다):
#   0 = 통과   2 = 분량 게이트 실패   3 = 환경 오류(Chrome 없음, PDF 파싱 불가)
#
# 이 파일이 존재하는 이유: 예전엔 두 스킬이 각자 Chrome 경로와 검사 명령을 적어놨고,
# pdf-resume만 실측으로 고쳐서 portfolio 쪽은 없는 바이너리 3개를 부르다 죽었다.
set -uo pipefail   # -e 는 쓰지 않는다. 아래 참조.

HTML="${1:?사용: render-pdf.sh <html> <pdf> [최대페이지] [최소페이지]}"
PDF="${2:?사용: render-pdf.sh <html> <pdf> [최대페이지] [최소페이지]}"
MAXP="${3:-0}"
MINP="${4:-0}"

for _p in "$HTML" "$PDF"; do
  case "$_p" in /*) echo "❌ 경로는 리포 루트 기준 상대경로로 넘긴다: $_p"; exit 3 ;; esac
done
[ -f "$HTML" ] || { echo "❌ HTML이 없다: $HTML"; exit 3; }
mkdir -p "$(dirname "$PDF")"

# ⚠️ `set -e` + `pipefail` 조합에서는 아래 `ls ... | head -1`이 glob 미스매치로 실패할 때
#    대입문 전체가 실패로 취급돼 스크립트가 여기서 죽는다. 그러면 아래 안내가 도달 불가 코드가 된다.
#    실제로 그렇게 죽어 있었다 — 사용자는 무음 exit 1만 봤다. `|| true`로 흡수한다.
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [ ! -x "$CHROME" ]; then
  CHROME=$(ls -d ~/.cache/puppeteer/chrome/*/chrome-*/*.app/Contents/MacOS/* 2>/dev/null | head -1 || true)
fi
if [ ! -x "${CHROME:-}" ]; then
  echo "❌ Chrome을 찾을 수 없다. 설치:"
  echo "   npx --yes @puppeteer/browsers install chrome@stable"
  echo "   받은 폴더를 ~/.cache/puppeteer/ 로 옮긴다 (기본 경로가 현재 디렉토리라 리포가 더러워진다)"
  exit 3
fi

# pkill 하지 않는다 — headless는 사용자가 열어둔 Chrome과 충돌하지 않는다
"$CHROME" --headless=new --disable-gpu --no-sandbox --virtual-time-budget=5000 \
  --print-to-pdf="$(pwd)/$PDF" --no-pdf-header-footer "file://$(pwd)/$HTML" 2>/dev/null
[ -f "$PDF" ] || { echo "❌ Chrome이 PDF를 만들지 못했다"; exit 3; }

python3 - "$PDF" "$MAXP" "$MINP" <<'PY'
import re, sys, zlib
pdf = sys.argv[1]
try:
    maxp, minp = int(sys.argv[2]), int(sys.argv[3])
except ValueError:
    print("❌ 페이지 인자가 숫자가 아니다"); sys.exit(3)
try:
    d = open(pdf, 'rb').read()
except OSError as e:
    print(f"❌ PDF를 열 수 없다: {e}"); sys.exit(3)

# 페이지 수 — pdfinfo(poppler)는 이 환경에 없다.
# grep -c "/Type /Page" 로 세지 말 것: /Type /Pages 까지 잡혀 부정확하다.
counts = re.findall(rb'/Count\s+(\d+)', d)
if not counts:
    print("⚠️ /Count 미검출 — 페이지 수를 셀 수 없다 (PDF 자체는 생성됨)"); sys.exit(3)
pages = max(int(c) for c in counts)   # /Outlines의 /Count가 앞설 수 있어 최댓값을 쓴다
print(f"PAGES: {pages}" + (f"  (목표 {minp or 1}-{maxp})" if maxp else ""))

# 폰트 — Thin/Light가 보이면 가변 폰트 축 최솟값이 잡힌 것이다 (2026-09 실측 사고)
fonts = sorted(set(re.findall(rb'/FontName\s*/([A-Za-z0-9+,\-]+)', d)))
print("FONTS:", [f.decode() for f in fonts] or "없음")
bad_font = any(b'Thin' in f or b'Light' in f for f in fonts)
if bad_font:
    print("  ⚠️ Thin/Light 감지 — 템플릿에 웹폰트 @import가 남아 있는지 확인할 것")

# 페이지별 텍스트 밀도 + 첫 글자들 — 빈 페이지와 오버플로우 탐지 (pdftotext 대용, 역시 부재)
objs = {int(m.group(1)): m.start() for m in re.finditer(rb'(?m)^(\d+)\s+0\s+obj', d)}
def stream(n):
    if n not in objs: return None
    s = d.find(b'stream', objs[n]); e = d.find(b'endstream', s)
    if s < 0 or e < 0: return None
    raw = d[s+6:e].lstrip(b'\r\n')
    try: return zlib.decompress(raw)
    except Exception: return None     # 조용히 raw를 세면 정상 페이지를 빈 페이지로 오탐한다

empty = []
for i, c in enumerate(re.findall(rb'/Type\s*/Page[^s].*?/Contents\s+(\d+)\s+0\s+R', d, re.S), 1):
    body = stream(int(c))
    if body is None:
        print(f"  p{i}: 밀도 측정 불가 (스트림 압축 해제 실패)"); continue
    ops = len(re.findall(rb'(?:TJ|Tj)', body))
    mark = "  ⚠️ 거의 빈 페이지" if ops < 20 else ""
    if ops < 20: empty.append(i)
    print(f"  p{i}: 텍스트연산 {ops}{mark}")

fail = []
if maxp and pages > maxp: fail.append(f"{maxp}p 초과 ({pages}p)")
if minp and pages < minp: fail.append(f"{minp}p 미달 ({pages}p)")
if empty:                 fail.append(f"빈 페이지 {empty}")
if bad_font:              fail.append("폰트 오적용")
if fail:
    print("❌ 분량 게이트 실패: " + ", ".join(fail))
    print("   앞 페이지가 절반 넘게 비었으면 콘텐츠가 아니라 break-inside: avoid 계열 CSS를 먼저 의심할 것.")
    sys.exit(2)
print("✅ 통과")
PY
rc=$?
# 게이트에서 떨어진 PDF를 디스크에 남기지 않는다.
# 남기면 다음 단계가 "PDF 존재 = 생성 확인"으로 읽고 JD를 applied/로 옮긴다.
if [ "$rc" -ne 0 ]; then
  rm -f "$PDF"
  echo "🗑  실패한 PDF를 삭제했다 (부분 산출물이 '완료'로 오인되는 것을 막는다)"
fi
exit "$rc"
