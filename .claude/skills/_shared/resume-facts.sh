#!/bin/bash
# 팩트 원본 상단 세 블록(수치 귀속표, 시스템 경계, 인용 금지 목록)을 원문 그대로 출력한다.
# draft-resume, cross-verify, final-check가 쓴다. 원본 경로와 줄 번호는 바뀌므로 매번 찾는다.
# 사용: bash .claude/skills/_shared/resume-facts.sh        (첫 줄에 원본 경로를 출력)
# 종료코드: 0 = 세 블록 모두 있음, 1 = 원본 없음 또는 블록 누락 → 호출한 스킬은 중단한다
# 실패 모드는 에러가 아니라 조용한 통과다(원본을 못 읽으면 모든 문장이 "지적 없음"이 된다). 그래서 소리를 낸다.
R=$(find src -name 'my-resume.md' -not -path '*example*' | head -1)
[ -n "$R" ] || { echo "❌ 팩트 원본(my-resume.md)을 찾을 수 없다. CLAUDE.md 「경로 해석」 표를 고친다 (스킬을 고치지 않는다)."; exit 1; }
for k in '수치 귀속표' '시스템 경계' '인용 금지 목록'; do
  grep -q "^#.*$k" "$R" || { echo "❌ 원본에 「$k」 블록이 없다. 검증 기준이 없으므로 중단한다."; exit 1; }
done
echo "RESUME=$R"
awk '/^#.*수치 귀속표/{on=1} /^#.*인용 금지 목록/{last=1} on && last && /^## / && !/인용 금지/{exit} on' "$R"
