---
name: refine-resume
description: Use when resume drafts have been reviewed and need final refinement applying all feedback to produce the polished submission-ready version. Triggers on "/refine-resume", "이력서 완성", "최종본", "정제", "수정 반영", "제출용".
---

# refine-resume

## Overview

초안 → 검증 → 리뷰를 거쳐 나온 **모든 피드백을 반영해 제출 가능한 최종본**을 만든다.
이 단계에서 새로운 창작은 없다 — 이전 단계의 결과물을 정밀하게 적용한다.

## Input

**기본 경로** (oh-my-career 프로젝트):
- 초안: `outcome/{company}/1_draft/{company}-draft-{추천버전}.md`
- 검증: `outcome/{company}/2_verify/{company}-verify.md`
- 교차검증: `outcome/{company}/2_verify/{company}-cross-verify.md`
- 리뷰: `outcome/{company}/3_review/{company}-review.md`
- 출력: `outcome/{company}/4_refine/{company}-final.md`


### 🚫 교차검증 게이트 (모든 하류 노드가 각자 검사한다)

```bash
CV=outcome/{company}/2_verify/{company}-cross-verify.md
[ -f "$CV" ] || { echo "❌ 교차검증 리포트가 없다. /cross-verify 를 먼저 실행하라."; exit 1; }
grep -m1 '^GATE:' "$CV"      # GATE: PASS 한 줄만 본다
```

`GATE: PASS`가 아니면 **중단하고 사용자에게 보고한다.**

⚠️ **게이트를 `review-resume` 한 곳에만 두지 않는다.** 예전에 그랬는데, BLOCK 복구 경로(사용자가 "고쳐줘"라고
답한 뒤)가 하필 그 노드를 지나가지 않아서 **review와 cross-verify를 둘 다 건너뛰고 제출본이 나올 수 있었다.**
사용자의 "진행"은 *고치라는 동의*였지 *제출하라는 동의*가 아니다. 게이트는 하류 전 노드가 각자 검사한다.

⚠️ **`grep BLOCK`으로 판정하지 마라.** 리포트 본문에 회차 이력(`1차 BLOCK → 3차 PASS`)이 적히면 통과한
문서를 거부하거나 그 반대가 된다. **`^GATE:` 줄 하나만** 본다.

## Process

### Step 1: 파일 로드 및 수정 목록 통합

한 번에 배치로 읽는다:

```
Read: outcome/{company}/1_draft/{company}-draft-{추천버전}.md    ← 베이스
Read: outcome/{company}/2_verify/{company}-verify.md             ← 필수 삭제/수정
Read: outcome/{company}/2_verify/{company}-cross-verify.md       ← ❌ 오귀속 = Priority 0
Read: outcome/{company}/3_review/{company}-review.md             ← 표현 개선
Read: outcome/{company}/4_refine/{company}-changelog.md          ← 있으면 (아래)
```

⚠️ **changelog를 반드시 읽는다.** `final-check`가 최종본을 직접 고치고 그 내역을 여기 남긴다.
이 파일을 안 읽고 초안에서 다시 만들면 **그 수정이 통째로 사라진다.** 기록만 하고 읽지 않으면
로그는 남고 문서는 사라진다 — 그건 방어가 아니다.
**근거가 `final-check`인 행은 재적용한다.**

수정 목록을 우선순위 순서로 통합:
```
[Priority 0] cross-verify ❌ 오귀속 항목 — 최우선. 수치를 옳은 줄로 옮기거나 삭제
[Priority 1] verify ❌ 항목 — 반드시 처리
[Priority 2] review ❌ 항목 — 반드시 처리
[Priority 3] verify ⚠️ 항목 — 처리 권고
[Priority 4] review ⚠️ 항목 — 처리 권고
```

### Step 2: Priority 1-2 적용 (필수)

verify ❌ 항목 처리:
- 원본에 없는 수치/사실 → 삭제 또는 약화 표현으로 대체
- 과장된 표현 → 원본 기준으로 정확하게 수정

review ❌ 항목 처리:
- 약한 bullets → 제안된 개선안으로 교체
- Summary 문제 → 리뷰 제안대로 재작성

### Step 3: Priority 3-4 적용 (권고)

- ⚠️ 항목을 검토하고 문맥상 적절한 것만 반영
- 기술 스택 순서 조정 (JD 필수 기술 상단)
- 전체 길이/밀도 최종 조정

### Step 3.5: 경력 항목 표준 포맷

모든 경력 항목(각 회사)은 다음 두 요소를 반드시 포함한다:

- **회사 소개 블록쿼트**: `### 회사명 | 팀` + `**직책 | 기간**` 헤더 바로 아래에 `>` 한 줄로 회사/서비스 간략 소개(원본 my-resume.md에 있는 사실만, 새로 창작 금지)
  - 형식: `> {규모 지표} {도메인} 서비스 {서비스명}에서 {담당 영역}을 {한 일}`
  - 규모 지표·서비스명·수치는 **반드시 원본 이력서에서 가져온다**. 이 스킬에 예시로 박아두지 않는다(다른 사람 데이터가 새어 들어가는 것을 막기 위해)
- **회사별 기술 스택 줄**: 해당 경력 항목의 bullet 목록 바로 아래에 `**기술 스택**: `code` `code` ...` 형식으로 그 회사에서 실제 사용한 기술만 나열(전체 기술 스택 표와 별개로, 회사 단위로도 표기)

### Step 3.6: 하우스 스타일 적용 (final-check 재작업 방지)

`.claude/skills/final-check/house-style.md`를 읽고 **Tier 1 전 항목**을 최종본에 적용한다.
이 단계에서 걸러야 final-check에서 되돌아오는 왕복이 없다. 치환 함정(가운뎃점을 슬래시로 바꾸면 AND가 OR로
뒤집히는 것)도 그 파일에 있다.

⚠️ **금지 패턴 목록을 이 파일에 복사해두지 않는다.** 사본은 반드시 낡는다 — 실제로 `draft-resume`에 남아 있던
옛 사본이 house-style 개정 뒤에도 폐기된 규칙을 적용하게 만들었고, 그 표기가 제출본까지 갔다.

### Step 4: 최종 자가 체크

제출 전 체크리스트:

```
[ ] 이름, 연락처, 링크가 정확한가
[ ] 경력 기간 계산이 정확한가
[ ] 원본에 없는 수치가 남아있지 않은가
[ ] JD 필수 키워드가 자연스럽게 포함됐는가
[ ] Summary가 3-4문장 이내인가
[ ] 가장 강한 성과가 각 경력 최상단에 있는가
[ ] 기술 스택이 JD 순서와 정렬됐는가
[ ] 각 경력 항목에 회사 소개 블록쿼트와 회사별 기술 스택 줄이 있는가
[ ] house-style.md Tier 1 위반이 없는가 (가운뎃점·em dash·물결표·피동형)
[ ] 분량이 대략 2페이지 규모인가 (**추정**이다. 실측은 /pdf-resume 가 한다)
```

### Step 5: 최종본 저장

**파일을 둘로 나눠 저장한다.**

**① `outcome/{company}/4_refine/{company}-final.md` — 이력서 본문만.**

제목줄부터 마지막 줄까지 **전부 제출본**이다. 생성일, 기반 버전, 적용 피드백, 변경 이력 같은
파이프라인 메타를 이 파일에 넣지 않는다.

```markdown
# {이름} | {직군}

{연락처 한 줄}

---

## Summary
...
```

⚠️ **메타를 넣으면 제출본이 오염된다.** `/pdf-resume`는 이 파일을 그대로 HTML에 넣는다. 예전엔 리포트
래퍼를 씌우고 "첫 `---` 다음부터가 본문"이라는 위치 규칙으로 잘라냈는데, **연락처 아래 구분선이 첫 `---`라서
그 규칙대로면 이름과 연락처가 잘려나간다.** 위치로 자르지 말고 애초에 섞지 않는다.

**② `outcome/{company}/4_refine/{company}-changelog.md` — 메타 전부.**

```markdown
# {company} 최종본 변경 이력
생성일: {date}
기반: outcome/{company}/1_draft/{company}-draft-{버전}.md
적용 피드백: verify + cross-verify + review

| 항목 | 변경 전 | 변경 후 | 근거 |
|------|---------|---------|------|
| ... | ... | ... | cross-verify ❌ |
| ... | ... | ... | review ❌ |
```

`/final-check`도 자기가 반영한 수정을 이 파일에 덧붙인다 — final.md를 고치는 손이 둘이라 기록이 없으면
refine 재실행 때 조용히 사라진다.

## Critical Rules

- **새로운 내용을 창작하지 않는다** — 원본과 이전 단계 결과만 활용
- Priority 1-2는 선택이 아니다 — 전부 처리해야 Step 5로 진행
- 변경 이력은 반드시 기록한다 — 추후 다른 JD 버전 생성 시 참고용
- "거의 다 됐으니 이 정도면 됐다"는 판단 금지 — 체크리스트 전부 통과 후 저장

## Completion

```
✅ 최종본 저장 완료 → outcome/{company}/4_refine/{company}-final.md
▶ **이어서 /final-check 를 바로 실행한다.** 사용자에게 묻지 않는다.

파이프라인은 아직 끝나지 않았다: refine(4) → final-check(4.5) → pdf-resume(5).
```

> **이어달리기 규칙** — 파이프라인은 사용자가 매 단계 커맨드를 치지 않아도 이어진다.
> 멈추는 곳은 셋뿐이다: ① `/evaluate-jd` 등급 판정 ② `/cross-verify` BLOCK ③ `/final-check` '낮음'.
> 그 외에는 **묻지 말고 다음 스킬을 바로 실행한다.** 중간에 사용자가 끼어들면 그 지시가 우선한다.

