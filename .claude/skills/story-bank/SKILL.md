---
name: story-bank
description: Use when the user wants to build or update their interview story bank, prepare for behavioral interviews, or match STAR stories to a specific company. Triggers on "/story-bank", "스토리 뱅크", "면접 준비", "STAR 스토리", "면접 질문", "behavioral interview".
---

# story-bank

## Overview

이력서의 경험들을 **STAR+R(Reflection) 면접 스토리**로 구조화하고, JD별로 예상 질문과 매칭해 면접을 준비한다.
평가·이력서 작성 과정에서 축적된 경험을 재활용해 **5-10개 마스터 스토리**로 대부분의 행동 면접 질문에 대응한다.

## Input

- 원본 이력서: `src/.my/my-resume.md`
- JD (선택): `src/.my/jd/pending/{company}_jd.md` (또는 `src/.my/jd/applied/`) — 있으면 해당 JD 맞춤, 없으면 범용 스토리 뱅크 생성
- 기존 평가 (선택): 평가 리포트에서 **예상 질문 섹션만** 뽑는다. 리포트 전문은 49KB인데 필요한 건 6KB다
  ```bash
  sed -n '/^## 예상 면접 질문/,/^## /p' outcome/{company}/0_evaluate/{company}-evaluate.md
  ```

## Output

- 범용 스토리 뱅크: `outcome/interview/story-bank.md` (회사 공통 자산, 최상위 유지 — 최초 1회 생성, 이후 누적 업데이트)
- 회사별 면접 준비: `outcome/{company}/interview/{company}-interview.md`

## Process

### Step 1: 마스터 스토리 추출 (최초 실행 또는 업데이트 시)

`src/.my/my-resume.md`에서 성과 기반 경험을 추출해 STAR+R 구조로 변환:

```markdown
### 스토리 #{번호}: {한줄 제목}
**출처**: {회사} — {프로젝트/성과명}
**태그**: #성능최적화 #장애대응 #아키텍처 #리더십 #협업 #DDD #문제해결

**S (Situation)**: 어떤 상황이었는가 (1-2문장)
**T (Task)**: 내가 맡은 과제/책임 (1문장)
**A (Action)**: 구체적으로 내가 한 행동 (2-3문장, 기술 결정 포함)
**R (Result)**: 정량적 결과 (수치 필수)
**Reflection**: 이 경험에서 배운 점, 다시 한다면 어떻게 할 것인지 (1-2문장)

**활용 가능 질문**:
- "{이 스토리로 답변할 수 있는 면접 질문 1}"
- "{이 스토리로 답변할 수 있는 면접 질문 2}"
```

**태그 분류 기준**:
- `#성능최적화` — 응답 시간, 처리량 개선
- `#장애대응` — 장애 감지, 복구, 방지
- `#아키텍처` — 시스템 설계, 패턴 적용, 인프라 구축
- `#리더십` — 주도적 제안, 팀 교육, 의사결정
- `#협업` — 크로스팀 협업, 지식 공유
- `#문제해결` — 근본 원인 분석, 창의적 해결
- `#DDD` — 도메인 주도 설계, 아키텍처 전환
- `#데이터파이프라인` — CDC, 색인, 이벤트 처리

### Step 2: 회사별 면접 준비 (JD가 있을 때)

JD와 평가 리포트를 기반으로 예상 질문을 생성하고 마스터 스토리와 매칭:

```markdown
# {company} 면접 준비

## JD 기반 예상 질문 + 스토리 매칭

### 기술 면접 예상 질문
| # | 예상 질문 | 추천 스토리 | 핵심 포인트 |
|---|----------|-----------|------------|
| 1 | {질문} | 스토리 #{번호} | {이 질문에서 강조할 점} |

### 행동 면접 예상 질문
| # | 예상 질문 | 추천 스토리 | 핵심 포인트 |
|---|----------|-----------|------------|
| 1 | {질문} | 스토리 #{번호} | {이 질문에서 강조할 점} |

### 커버되지 않는 질문 (준비 필요)
- {스토리로 커버가 안 되는 예상 질문} → {대응 전략 제안}

## 역질문 추천
- {회사/팀에 대해 물어볼 만한 질문 3-5개}
```

### Step 3: 스토리 뱅크 누적 업데이트

- `outcome/interview/story-bank.md`가 이미 존재하면 **기존 스토리를 유지**하고 신규 경험만 추가
- 이력서(`src/.my/my-resume.md`)에 새 경험이 추가됐으면 해당 경험을 새 스토리로 변환해 append
- 스토리 번호는 순차 증가, 기존 번호는 변경하지 않음
- 상단에 **스토리 인덱스 테이블** 유지:

```markdown
## 스토리 인덱스

| # | 제목 | 회사 | 태그 | 활용 횟수 |
|---|------|------|------|----------|
| 1 | {성과 한줄 제목} | {회사} | #성능최적화 #아키텍처 | 3 |
| 2 | {성과 한줄 제목} | {회사} | #데이터파이프라인 #장애대응 | 2 |
```

### Step 4: 저장

- 범용: `outcome/interview/story-bank.md`
- 회사별: `outcome/{company}/interview/{company}-interview.md`

## Critical Rules

- **이력서에 없는 경험으로 스토리를 만들지 않는다** — 팩트 기준 엄수
- **수치는 이력서 원본 그대로** — Result의 숫자를 과장하거나 변형하지 않음
- **Reflection은 진정성 있게** — 뻔한 교훈이 아닌 실제로 배울 수 있는 인사이트
- **기존 스토리 뱅크를 덮어쓰지 않는다** — 항상 누적 업데이트
- **하나의 스토리로 여러 질문을 커버** — 5-10개 마스터 스토리가 목표

## Next Step

```
✅ 스토리 뱅크 생성/업데이트 완료

범용 모드:
  → outcome/interview/story-bank.md 생성 완료
  → /story-bank {company} 로 회사별 면접 준비 가능

회사별 모드:
  → outcome/{company}/interview/{company}-interview.md 생성 완료
  → 예상 질문 + 스토리 매칭 확인 후 면접 준비
```
