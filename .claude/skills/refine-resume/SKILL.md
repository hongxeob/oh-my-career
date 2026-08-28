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
- 리뷰: `outcome/{company}/3_review/{company}-review.md`
- 출력: `outcome/{company}/4_refine/{company}-final.md`

## Process

### Step 1: 파일 로드 및 수정 목록 통합

```
Read: outcome/{company}/1_draft/{company}-draft-{추천버전}.md    ← 베이스
Read: outcome/{company}/2_verify/{company}-verify.md             ← 필수 삭제/수정
Read: outcome/{company}/3_review/{company}-review.md             ← 표현 개선
```

수정 목록을 우선순위 순서로 통합:
```
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
  - 예: `> {규모 지표} 일본 패션 크로스보더 커머스 {서비스}에서 검색과 전시 트래픽을 처리하는 검색 서버와 색인 파이프라인을 재구축하고 운영`
- **회사별 기술 스택 줄**: 해당 경력 항목의 bullet 목록 바로 아래에 `**기술 스택**: `code` `code` ...` 형식으로 그 회사에서 실제 사용한 기술만 나열(전체 기술 스택 표와 별개로, 회사 단위로도 표기)

### Step 3.6: 하우스 스타일 적용 (final-check 재작업 방지)

`.claude/skills/final-check/house-style.md`를 읽고 **Tier 1 전 항목**을 최종본에 적용한다.
이 단계에서 걸러야 final-check에서 되돌아오는 왕복이 없다. 특히 자주 걸리는 것:

- 산문(Summary·회사 소개 블록쿼트)의 가운뎃점 나열 → 쉼표·`~와/과`, 진짜 병렬 명사만 슬래시
- Em dash로 절 잇기 → 접속사로 녹임 (`**제목** — 부제` 헤더 형식만 예외)
- 숫자 범위 물결표(`20~30ms`) → 하이픈(`20-30ms`)
- 피동형·과잉 명사화·무생물 주어 → 능동, 동사 직접, 사람 주어

⚠️ 가운뎃점을 슬래시로 바꿀 때 **동사를 잇는 가운뎃점**(`재구축·운영` = AND)은 슬래시(OR)로 바꾸면 의미가 뒤집힌다. `및`·`하고`·쉼표를 쓴다. 일괄 치환 후 각 줄을 다시 읽어 확인할 것.

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
[ ] 전체 2페이지 이내인가 (PDF 기준)
```

### Step 5: 최종본 저장

`outcome/{company}/4_refine/{company}-final.md`에 저장:

```markdown
# {company} 지원 이력서 — 최종본
생성일: {date}
기반: outcome/{company}/1_draft/{company}-draft-{버전}.md
적용 피드백: verify + review 전체

---

[완성된 이력서 전문]

---

## 변경 이력
| 항목 | 변경 전 | 변경 후 | 근거 |
|------|---------|---------|------|
| ... | ... | ... | verify ❌ |
| ... | ... | ... | review ❌ |
```

## Critical Rules

- **새로운 내용을 창작하지 않는다** — 원본과 이전 단계 결과만 활용
- Priority 1-2는 선택이 아니다 — 전부 처리해야 Step 5로 진행
- 변경 이력은 반드시 기록한다 — 추후 다른 JD 버전 생성 시 참고용
- "거의 다 됐으니 이 정도면 됐다"는 판단 금지 — 체크리스트 전부 통과 후 저장

## Completion

```
✅ 최종본 저장 완료 → outcome/{company}/4_refine/{company}-final.md

이력서 파이프라인 완료:
  src/my-resume.md + src/pending/{company}_jd.md
  → outcome/{company}/1_draft/  (초안 3가지)
  → outcome/{company}/2_verify/ (팩트/JD 검증)
  → outcome/{company}/3_review/ (품질 리뷰)
  → outcome/{company}/4_refine/ (최종 제출본)
```
