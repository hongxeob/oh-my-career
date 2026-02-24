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
- 초안: `outcome/1_draft/{company}-draft-{추천버전}.md`
- 검증: `outcome/2_verify/{company}-verify.md`
- 리뷰: `outcome/3_review/{company}-review.md`
- 출력: `outcome/4_refine/{company}-final.md`

## Process

### Step 1: 파일 로드 및 수정 목록 통합

```
Read: outcome/1_draft/{company}-draft-{추천버전}.md    ← 베이스
Read: outcome/2_verify/{company}-verify.md             ← 필수 삭제/수정
Read: outcome/3_review/{company}-review.md             ← 표현 개선
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
[ ] 전체 2페이지 이내인가 (PDF 기준)
```

### Step 5: 최종본 저장

`outcome/4_refine/{company}-final.md`에 저장:

```markdown
# {company} 지원 이력서 — 최종본
생성일: {date}
기반: outcome/1_draft/{company}-draft-{버전}.md
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
✅ 최종본 저장 완료 → outcome/4_refine/{company}-final.md

이력서 파이프라인 완료:
  src/my-resume.md + src/{company}-jd.md
  → outcome/1_draft/  (초안 3가지)
  → outcome/2_verify/ (팩트/JD 검증)
  → outcome/3_review/ (품질 리뷰)
  → outcome/4_refine/ (최종 제출본)
```
