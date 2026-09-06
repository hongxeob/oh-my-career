---
name: verify-resume
description: Use when resume drafts have been created and need fact-checking against the original resume and JD alignment verification. Triggers on "/verify-resume", "이력서 검증", "팩트체크", "JD 정합성", "사실 확인".
---

# verify-resume

## Overview

`/draft-resume`로 생성된 초안을 **원본 이력서 대비 팩트 검증** 및 **JD 정합성 체크**한다.
초안에서 과장되거나 누락된 부분을 발견하고, 다음 단계(/review-resume)에서 수정할 근거를 만든다.

## Input

> 경로 이름(`{RESUME}`, `{JD}`)의 정의는 **CLAUDE.md 「경로 해석」** 한 곳에 있다. 파일을 못 찾으면 스킬을 고치지 말고 그 표를 고친다.

**기본 경로** (oh-my-career 프로젝트):
- 원본 이력서: `{RESUME}` (= `src/.my/my-resume.md`)
- JD: `{JD}` (= `src/.my/jd/pending/{company}_jd.md`) (또는 `src/.my/jd/applied/`)
- 검증 대상: `outcome/{company}/1_draft/{company}-draft-*.md`
- 출력: `outcome/{company}/2_verify/{company}-verify.md`

## Process

### Step 1: 파일 로드

```
Read: {RESUME}                                 ← 팩트 기준 (= src/.my/my-resume.md)
Read: src/.my/jd/pending/{company}_jd.md              ← JD 기준
Glob: outcome/{company}/1_draft/{company}-draft-*.md   ← 검증할 초안들 (디렉토리를 Read하면 실패한다)
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
| {JD에서 뽑은 요건} | 필수/우대 | ✅ 반영 / ⚠️ 약함 / ❌ 미반영 | {섹션} |

⚠️ **예시 요건을 이 파일에 적어두지 않는다.** 다른 회사 JD가 박혀 있으면 그 요건을 찾는 쪽으로 판정이 끌려간다.

### Step 4: 버전별 전략 달성도

각 초안(A/B/C)이 의도한 전략을 실제로 달성했는지 평가:

```
Version A (ATS형): 키워드 밀도 점수 — X/10
Version B (임팩트형): 수치 포함 bullets 비율 — X%
Version C (스토리형): 문화 시그널 언어 사용 — X/5개
```

### Step 5: 결과 저장

`outcome/{company}/2_verify/{company}-verify.md`에 저장:

```markdown
# {company} 이력서 검증 리포트
생성일: {date}
검증 대상: outcome/{company}/1_draft/{company}-draft-*.md

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
최종 진행 추천: Version [A/B/C] 또는 하이브리드 — 이유: ...
```

**하이브리드 추천이 가능하다.** 한 버전이 통째로 이기지 않는 경우가 흔하므로, 그때는 아래 형식으로 적는다:

```
최종 진행 추천: B 베이스 + A의 [구체적 요소] 이식
- 베이스가 B인 이유: ...
- A에서 가져올 것: [섹션/bullet을 구체적으로 지목]
```

베이스 버전과 이식할 요소를 **파일·섹션 단위로 지목**해야 refine 단계에서 그대로 조립할 수 있다.

## Critical Rules

- **원본을 못 읽으면 리포트를 내지 않는다** — 대조 기준이 없으면 모든 항목이 ✅로 나오고, 그건 검증이 아니라
  검증한 척이다. 파일을 못 찾으면 중단하고 사용자에게 알린다.
  경로가 CLAUDE.md 「경로 해석」 표와 다르면 스킬이 아니라 **그 표를 고친다**
- ❌ FAIL 항목은 반드시 삭제 — 검증자가 임의로 수정하지 않는다
- 원본 이력서에 없는 내용을 "있을 것 같다"고 추정하지 않는다
- 경력 연수 계산: 날짜 기준으로 정확히 계산한다

## Next Step

```
✅ 검증 리포트 저장 완료 → outcome/{company}/2_verify/
▶ **이어서 /cross-verify 를 바로 실행한다.** 사용자에게 묻지 않는다.
   ❌ FAIL 항목이 있어도 멈추지 않는다 — 교차검증까지 돌려서 지적을 모아 한 번에 반영하는 편이 왕복이 적다.
```

> **이어달리기 규칙** — 파이프라인은 사용자가 매 단계 커맨드를 치지 않아도 이어진다.
> 멈추는 곳은 셋뿐이다: ① `/evaluate-jd` 등급 판정 ② `/cross-verify` BLOCK ③ `/final-check` '낮음'.
> 그 외에는 **묻지 말고 다음 스킬을 바로 실행한다.** 중간에 사용자가 끼어들면 그 지시가 우선한다.

