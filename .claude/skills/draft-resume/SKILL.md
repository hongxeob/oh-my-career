---
name: draft-resume
description: Use when given an original resume/career data and a job description (JD), and need to generate multiple tailored resume drafts. Triggers on "/draft-resume", "이력서 초안", "resume draft", "JD 맞춤 이력서", "3가지 버전".
---

# draft-resume

## Overview

원본 커리어 데이터(팩트)와 JD를 분석해 **전략이 다른 3가지 이력서 초안**을 생성한다.
원본 데이터는 절대 변형하지 않는다 — 표현 방식만 달리한다.

## Input

**기본 경로** (oh-my-career 프로젝트):
- 원본 이력서: `src/my-resume.md`
- JD: `src/{company}-jd.md`
- 출력: `outcome/1_draft/{company}-draft-{A|B|C}.md`

다른 파일을 쓰는 경우 사용자에게 경로를 확인하라.

## Process

### Step 1: JD 분석

JD에서 다음을 추출해 표로 정리:

| 구분 | 내용 |
|------|------|
| 핵심 역할 | 이 포지션이 실제로 하는 일 |
| 필수 스킬 | must-have 요건 |
| 우대 스킬 | nice-to-have 요건 |
| 키워드 | ATS에 걸릴 핵심 단어들 |
| 문화 시그널 | 회사/팀 문화를 나타내는 표현 |
| 측정 지표 | 성과를 어떻게 측정하는지 |

### Step 2: 원본 데이터 파싱

원본에서 **팩트만** 추출 — 해석하지 않는다:

```
[회사] [기간] [직책]
- 실제 수행한 업무 (원문 그대로)
- 실제 달성한 수치 (원문 그대로)
- 실제 사용한 기술 (원문 그대로)
```

### Step 3: 3가지 버전 생성

각 버전은 **동일한 팩트, 다른 강조점**:

---

#### Version A: ATS 최적화형 (키워드 밀도 우선)

**전략:** JD 키워드를 자연스럽게 포함, ATS 통과 최적화

- Summary: JD 언어를 직접 반영, 역할 타이틀 포함
- 경험 bullets: JD 필수/우대 스킬과 1:1 매핑
- 스킬 섹션: JD 키워드 순서대로 나열
- **금지:** JD에 없는 신조어, 과도한 수식어

---

#### Version B: 임팩트 중심형 (수치/성과 우선)

**전략:** 모든 bullets를 수치화된 성과로 시작

- Summary: 가장 강력한 성과 2개로 시작
- 경험 bullets: "동사 + 수치 + 임팩트" 구조 강제
  ```
  ✅ "결제 전환율 23% 향상, 월 매출 1.2억 증가"
  ❌ "결제 시스템 개선에 기여"
  ```
- 수치가 없으면: 규모(팀 크기, 사용자 수, 기간)로 대체
- 스킬 섹션: 성과와 연결된 기술만

---

#### Version C: 스토리텔링형 (문화핏 우선)

**전략:** 성장 서사와 회사 문화 정렬

- Summary: "왜 이 회사인가" 연결되는 개인 비전
- 경험 bullets: 문제 상황 → 내 역할 → 결과의 서사
- 회사 문화 시그널 언어 자연스럽게 반영
- 팀워크, 리더십, 오너십 경험 부각

---

### Step 4: 파일 저장

각 버전을 `outcome/1_draft/{company}-draft-{A|B|C}.md`로 저장한다.

파일명 예시: `kakao-style-draft-A.md`, `kakao-style-draft-B.md`, `kakao-style-draft-C.md`

### Step 5: 출력 형식

각 버전을 다음 구조로 파일에 저장하고 대화창에도 출력:

```markdown
## Version [A/B/C]: [전략명]
**타겟 강점:** [한 줄 전략 설명]

### 헤더
이름 | 연락처 | 링크

### Summary (3-4문장)
...

### 경력
**[회사명]** | [직책] | [기간]
- ...

### 스킬
...
```

출력 후 각 버전의 **전략적 의도 1줄 요약**을 추가한다.

## Critical Rules

- 원본에 없는 숫자/사실을 생성하지 않는다 (→ /verify-resume가 검증)
- 세 버전은 전략이 달라야 한다 — 단어만 바꾸는 것은 금지
- JD와 무관한 경험은 압축하거나 제거한다
- 생성 후 반드시 `/verify-resume` 실행을 안내한다

## Next Step

```
✅ 3가지 초안 저장 완료
  → outcome/1_draft/{company}-draft-A.md
  → outcome/1_draft/{company}-draft-B.md
  → outcome/1_draft/{company}-draft-C.md
→ 다음 단계: /verify-resume 로 팩트체크 실행
```
