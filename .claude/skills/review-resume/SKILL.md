---
name: review-resume
description: Use when resume drafts have been verified and need deep quality review for clarity, impact language, and structure. Triggers on "/review-resume", "이력서 리뷰", "품질 검토", "문장 검토", "표현 개선".
---

# review-resume

## Overview

검증 완료된 초안을 **채용자 시각에서 품질 리뷰**한다.
팩트는 맞지만 설득력이 부족한 부분, 표현이 약한 부분, 구조적 문제를 찾아 구체적인 개선 지침을 만든다.

## Input

**기본 경로** (oh-my-career 프로젝트):
- 검증 리포트: `outcome/{company}/2_verify/{company}-verify.md`
- 교차검증 게이트: `head -8 outcome/{company}/2_verify/{company}-cross-verify.md` — **게이트 줄만 읽는다**
  (지적 목록 전문이 필요한 건 `/refine-resume`이지 리뷰가 아니다. 전문을 읽으면 12KB를 0.4KB 대신 올린다)

### 🚫 시작 전 중단 조건 (2.5단계 게이트)

아래 둘 중 하나면 **리뷰를 시작하지 않고 즉시 중단**한다. 리뷰는 표현과 구조를 보는 단계라,
수치가 엉뚱한 줄에 붙어 있어도 통과시킨다 — 그래서 이 게이트가 리뷰보다 앞에 있어야 한다.

```
1) cross-verify 리포트 파일이 없다
   ❌ outcome/{company}/2_verify/{company}-cross-verify.md 가 없습니다.
      2.5단계를 건너뛰었습니다. /cross-verify 를 먼저 실행하세요.

2) 리포트의 게이트가 BLOCK이다
   ❌ 교차검증 게이트: BLOCK ({오귀속 N건, 근거없음 M건})
      지적 목록을 초안에 반영하고 /cross-verify 를 재실행하세요.
```

**"이번엔 수치가 단순해서 괜찮다"는 판단으로 넘기지 않는다.** 실제 사고는 전부 그 판단에서 났다.
- 초안: `outcome/{company}/1_draft/{company}-draft-{추천버전}.md`
- 출력: `outcome/{company}/3_review/{company}-review.md`

## Process

### Step 1: 파일 로드

한 번에 배치로 읽는다:

```
head -8 outcome/{company}/2_verify/{company}-cross-verify.md   ← 게이트 PASS/BLOCK (먼저 확인)
Read: outcome/{company}/2_verify/{company}-verify.md            ← 추천 버전 확인
Read: outcome/{company}/1_draft/{company}-draft-{추천버전}.md
```

verify가 **하이브리드를 추천했으면** 베이스 버전과 이식 대상 버전을 모두 읽고, 리뷰는 "조립된 결과물" 기준으로 작성한다. 리포트 상단 `리뷰 대상`에 조립 구성을 명시할 것 (예: `B 베이스 + A의 AI 활용 섹션`).

### Step 2: Summary/헤드라인 리뷰

채용자가 처음 8초에 읽는 부분:

| 체크포인트 | 현재 | 평가 | 개선안 |
|-----------|------|------|--------|
| 직군/레벨이 즉시 보이는가 | ... | ✅/❌ | ... |
| 가장 강한 성과가 앞에 오는가 | ... | ✅/❌ | ... |
| JD 포지션명과 언어가 일치하는가 | ... | ✅/❌ | ... |
| 3문장 이내로 읽히는가 | ... | ✅/❌ | ... |

### Step 3: 경험 Bullets 리뷰

각 bullet을 "STAR 밀도"로 평가:

```
STAR 밀도:
- S만 있음 (상황 설명만): ❌ 약함
- S+A 있음 (행동까지): ⚠️ 보통
- S+A+R 있음 (결과까지): ✅ 강함
- S+A+R+수치 있음: ⭐ 최강
```

**약한 bullet 목록화:**
```
❌ 현재: "Kafka 기반 이벤트 시스템 구축"
✅ 제안: "Kafka Envelope 패턴으로 배송 알림 시스템 구축, 독립 예외 처리로 메인 로직 보호 → 시스템 안정성 향상"
```

### Step 4: 기술 스택 섹션 리뷰

| 체크포인트 | 판정 |
|-----------|------|
| JD 필수 기술이 상단에 있는가 | ✅/❌ |
| 실제 사용 경험 없는 기술 포함 여부 | ✅/❌ |
| 버전/레벨 표기 필요한 기술 | ✅/❌ |

### Step 5: 전체 구조 리뷰

- **길이**: 적정 분량인가 (1~2페이지 기준)
- **밀도**: 정보가 균형있게 분배됐는가
- **우선순위**: 중요한 내용이 앞에 오는가
- **가독성**: 채용자가 30초 안에 핵심을 파악할 수 있는가

### Step 6: 결과 저장

`outcome/{company}/3_review/{company}-review.md`에 저장:

```markdown
# {company} 이력서 리뷰
생성일: {date}
리뷰 대상: outcome/{company}/1_draft/{company}-draft-{버전}.md

## 종합 평가
점수: X/10 — 한 줄 평

## Summary 리뷰
[Step 2 표]

## Bullets 개선 목록
### 반드시 수정 (❌)
- 현재: "..."
  제안: "..."

### 권고 수정 (⚠️)
- 현재: "..."
  제안: "..."

## 기술 스택 리뷰
[Step 4 표]

## 구조 리뷰
[Step 5 결과]

## 수정 우선순위
1. (가장 중요) ...
2. ...
3. ...
```

## Critical Rules

- 팩트를 바꾸지 않는다 — 표현과 구조만 개선한다
- "좋아 보인다"는 막연한 평가 금지 — 모든 지적은 구체적인 개선안을 함께 제시한다
- 채용자 시각으로 읽는다: "이 사람을 면접에 부르고 싶은가?"

## Next Step

```
✅ 리뷰 리포트 저장 완료 → outcome/{company}/3_review/
▶ **이어서 /refine-resume 를 바로 실행한다.** 사용자에게 묻지 않는다.
   리뷰는 권고다 — 사용자 확인을 받으려고 멈추지 말고, 반영 결과를 refine 이후에 함께 보고한다.
```

> **이어달리기 규칙** — 파이프라인은 사용자가 매 단계 커맨드를 치지 않아도 이어진다.
> 멈추는 곳은 셋뿐이다: ① `/evaluate-jd` 등급 판정 ② `/cross-verify` BLOCK ③ `/final-check` '낮음'.
> 그 외에는 **묻지 말고 다음 스킬을 바로 실행한다.** 중간에 사용자가 끼어들면 그 지시가 우선한다.

