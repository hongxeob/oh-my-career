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
- 초안: `outcome/{company}/1_draft/{company}-draft-{추천버전}.md`
- 출력: `outcome/{company}/3_review/{company}-review.md`

## Process

### Step 1: 파일 로드

```
Read: outcome/{company}/2_verify/{company}-verify.md    ← 추천 버전 확인
Read: outcome/{company}/1_draft/{company}-draft-{추천버전}.md
```

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
→ 다음 단계: /refine-resume 로 최종 완성본 생성
```
