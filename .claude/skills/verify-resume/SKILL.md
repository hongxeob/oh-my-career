---
name: verify-resume
description: Use when resume drafts have been created and need fact-checking against the original resume and JD alignment verification. Triggers on "/verify-resume", "이력서 검증", "팩트체크", "JD 정합성", "사실 확인".
---

# verify-resume

## Overview

`/draft-resume`로 생성된 초안을 **원본 이력서 대비 팩트 검증** 및 **JD 정합성 체크**한다.
초안에서 과장되거나 누락된 부분을 발견하고, 다음 단계(/review-resume)에서 수정할 근거를 만든다.

## Input

**기본 경로** (career-management-ai 프로젝트):
- 원본 이력서: `src/my-resume.md`
- JD: `src/{company}-jd.md`
- 검증 대상: `outcome/1_draft/{company}-draft-*.md`
- 출력: `outcome/2_verify/{company}-verify.md`

## Process

### Step 1: 파일 로드

```
Read: src/my-resume.md          ← 팩트 기준
Read: src/{company}-jd.md       ← JD 기준
Read: outcome/1_draft/          ← 검증할 초안들
```

### Step 2: 팩트 검증

초안의 모든 수치/주장을 원본과 대조:

| 항목 | 초안 내용 | 원본 근거 | 판정 |
|------|-----------|-----------|------|
| 수치 | "응답 시간 99% 개선" | 원본: "4-5초 → 40-50ms" | ✅ OK |
| 수치 | 원본에 없는 수치 | 없음 | ❌ 삭제 필요 |
| 역할 | "주도적 설계" | 원본: "2인 체제 주도" | ✅ OK |
| 기술 | 원본에 없는 기술 | 없음 | ❌ 삭제 필요 |

**판정 기준:**
- ✅ OK: 원본에 근거 있음
- ⚠️ WEAK: 원본보다 과장됨 (수정 권고)
- ❌ FAIL: 원본에 없음 (반드시 삭제)

### Step 3: JD 정합성 체크

JD 필수/우대 요건 대비 초안 커버리지:

| JD 요건 | 구분 | 초안 반영 여부 | 위치 |
|---------|------|---------------|------|
| Java/Kotlin + Spring | 필수 | ✅ 반영 | 스킬 섹션 |
| 3년 이상 경력 | 필수 | ⚠️ 경력 계산 필요 | 헤더 |
| OMS/WMS 경험 | 우대 | ❌ 미반영 | - |
| AI Agent 활용 | 필수 | ⚠️ 약하게 언급 | 기타 기여 |

### Step 4: 버전별 전략 달성도

각 초안(A/B/C)이 의도한 전략을 실제로 달성했는지 평가:

```
Version A (ATS형): 키워드 밀도 점수 — X/10
Version B (임팩트형): 수치 포함 bullets 비율 — X%
Version C (스토리형): 문화 시그널 언어 사용 — X/5개
```

### Step 5: 결과 저장

`outcome/2_verify/{company}-verify.md`에 저장:

```markdown
# {company} 이력서 검증 리포트
생성일: {date}
검증 대상: outcome/1_draft/{company}-draft-*.md

## 팩트 검증 결과
[Step 2 표]

## JD 정합성 결과
[Step 3 표]

## 버전별 전략 달성도
[Step 4 결과]

## 필수 수정 사항
- [ ] ❌ 항목 1: ...
- [ ] ❌ 항목 2: ...

## 권고 수정 사항
- [ ] ⚠️ 항목 1: ...

## 추천 버전
최종 진행 추천: Version [A/B/C] — 이유: ...
```

## Critical Rules

- ❌ FAIL 항목은 반드시 삭제 — 검증자가 임의로 수정하지 않는다
- 원본 이력서에 없는 내용을 "있을 것 같다"고 추정하지 않는다
- 경력 연수 계산: 날짜 기준으로 정확히 계산한다

## Next Step

```
✅ 검증 리포트 저장 완료 → outcome/2_verify/
→ 다음 단계: /review-resume 로 품질 리뷰 실행
```
