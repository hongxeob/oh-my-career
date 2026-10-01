#!/bin/bash
# 교차검증 게이트. refine, review, final-check, pdf-resume가 시작 전에 각자 부른다.
# 사용: bash .claude/skills/_shared/check-gate.sh <company>
# 종료코드: 0 = PASS, 1 = 리포트 없음 또는 PASS 아님
#
# 게이트를 한 노드에만 두지 않는 이유: BLOCK 복구 경로가 그 노드를 지나가지 않아
# review와 cross-verify를 둘 다 건너뛴 제출본이 나올 수 있었다. 사용자의 "진행"은 고치라는 동의지 제출 동의가 아니다.
# grep BLOCK으로 판정하지 않는 이유: 본문의 회차 이력("1차 BLOCK → 3차 PASS")에 걸린다. ^GATE: 줄 하나만 본다.
[ -n "${1:-}" ] || { echo "사용: check-gate.sh <company>"; exit 1; }
C="$1"
CV="outcome/$C/2_verify/$C-cross-verify.md"
[ -f "$CV" ] || { echo "❌ $CV 가 없다. /cross-verify 를 먼저 실행하라."; exit 1; }
G=$(grep -m1 '^GATE:' "$CV")
grep -m1 '^검증 대상:' "$CV"
echo "$G"
[ "$G" = "GATE: PASS" ] || { echo "❌ 게이트가 PASS가 아니다. 중단하고 사용자에게 보고한다."; exit 1; }
