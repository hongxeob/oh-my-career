---
name: dashboard
description: Use when you want to visualize the resume pipeline status. Triggers on "/dashboard", "대시보드", "파이프라인 현황", "진행 상태 확인".
---

# dashboard

## Overview

`outcome/` 폴더를 스캔해 회사별 파이프라인 진행 상태를 읽고, 브라우저에서 바로 열 수 있는 자기 완결형 `dashboard.html`을 프로젝트 루트에 생성한다.

## 실행 모드 (인자에 따라 읽는 양이 다르다)

`dashboard.html`은 자기 완결형이라 MD 콘텐츠를 파일 안에 임베드해야 한다.
회사가 20개면 전 회사 전 단계를 임베드할 때 산출물 전체가 컨텍스트에 올라가므로, 기본은 **현황 모드**다.

| 호출 | 모드 | 읽는 파일 | 용도 |
|------|------|----------|------|
| `/dashboard` | **현황 모드** (기본) | MD 본문을 읽지 않음 — 파일 **존재 여부만** 확인 | 전체 진행 상황 한눈에 |
| `/dashboard {company}` | **상세 모드** | 해당 회사 MD만 전부 Read | 특정 회사 산출물 열람 |
| `/dashboard --all` | **전체 상세** | 전 회사 MD 전부 Read (느리고 토큰 많이 씀) | 명시 요청 시에만 |

**현황 모드에서는 Step 3(파일 읽기)을 건너뛴다.** 스테퍼·다음 단계 커맨드만 렌더하고,
콘텐츠 탭 자리에는 "이 회사 상세는 `/dashboard {company}` 로 열람" 안내를 넣는다.

---

## Process

### Step 1: 회사 감지

`outcome/` 바로 아래 서브폴더 목록이 곧 회사 목록이다 (회사별 패키지 구조: `outcome/{company}/{stage}/`).

```bash
find outcome -mindepth 3 -maxdepth 3 -type f \( -name '*.md' -o -name '*.pdf' -o -name '*.html' \) | sort
```

**한 번의 `find`로 회사 목록과 단계별 파일 존재를 동시에 얻는다.** 회사마다 8종을 따로 확인하면 회사 수에
비례해 왕복이 늘어난다.

⚠️ **`0_evaluate` 기준으로 회사를 찾지 않는다.** 예전엔 `Glob: outcome/*/0_evaluate/*-evaluate.md`를 썼는데,
평가를 건너뛰고 draft부터 시작한 회사가 목록에서 통째로 빠졌다.

`outcome/interview/`(공통 스토리 뱅크 전용, 회사 아님)는 회사 목록에서 제외한다.
회사명 중복 제거 후 알파벳 순 정렬.

### Step 2: 단계별 존재 확인 (회사마다)

각 회사 폴더 `outcome/{company}/` 아래 파일 존재 여부를 확인한다:

| 단계 | 파일 | done 조건 |
|------|------|-----------|
| evaluate | `outcome/{company}/0_evaluate/{company}-evaluate.md` | 존재 |
| draft | `outcome/{company}/1_draft/{company}-draft-A.md` | A 파일 존재 |
| verify | `outcome/{company}/2_verify/{company}-verify.md` | 존재 |
| **cross-verify** | `outcome/{company}/2_verify/{company}-cross-verify.md` | 존재 **&& 게이트가 PASS** (`head -8`로 게이트 줄 확인) |
| review | `outcome/{company}/3_review/{company}-review.md` | 존재 |
| refine | `outcome/{company}/4_refine/{company}-final.md` | 존재 |
| **final-check** | `outcome/{company}/4_refine/{company}-final-check.md` | 존재 |
| pdf | `outcome/{company}/5_pdf/{company}-final.pdf` | **PDF 존재** |
| portfolio (선택) | `outcome/{company}/6_portfolio/{company}-portfolio.pdf` | 존재 |

⚠️ **pdf의 done 조건에 `.html`을 넣지 않는다.** 예전엔 `html 또는 pdf`였는데, Chrome을 못 찾아 HTML만 남고
제출본이 없는 상태를 "pdf 완료"로 칠했다. 제출할 수 있는 건 PDF다.

⚠️ **cross-verify와 final-check를 빠뜨리지 않는다.** 이 둘은 건너뛰기를 막으려고 만든 게이트인데, 대시보드가
추적하지 않으면 **게이트를 건너뛴 회사가 "완료"로 표시되어** 장치가 무력화된다.

draft의 B, C 파일도 각각 존재 여부 확인:
- `outcome/{company}/1_draft/{company}-draft-B.md`
- `outcome/{company}/1_draft/{company}-draft-C.md`

### Step 3: 파일 읽기 (상세 모드에서만)

**현황 모드면 이 단계를 통째로 건너뛴다** — 모든 `content`를 `null`로 두고 Step 4로 간다.

상세 모드일 때만, 대상 회사의 존재하는 MD 파일을 Read 도구로 읽어 내용 수집:

```
Read: outcome/{company}/1_draft/{company}-draft-A.md  (있는 경우)
Read: outcome/{company}/1_draft/{company}-draft-B.md  (있는 경우)
Read: outcome/{company}/1_draft/{company}-draft-C.md  (있는 경우)
Read: outcome/{company}/2_verify/{company}-verify.md  (있는 경우)
Read: outcome/{company}/3_review/{company}-review.md  (있는 경우)
Read: outcome/{company}/4_refine/{company}-final.md   (있는 경우)
```

HTML/PDF 파일은 읽지 않는다.

### Step 3.5: 회사명 파싱 규칙 (참고)

폴더명이 곧 회사명이므로 파일명에서 다시 파싱할 필요는 없다:
- `outcome/kakao-style/1_draft/kakao-style-draft-A.md` → 회사명: `kakao-style`
- `outcome/toss/2_verify/toss-verify.md` → 회사명: `toss`

### Step 4: 다음 단계 커맨드 결정 (회사마다)

```
evaluate 없음        → /evaluate-jd {company}
draft 없음           → /draft-resume {company}
verify 없음          → /verify-resume {company}
cross-verify 없음    → /cross-verify {company}
cross-verify BLOCK   → ⛔ 교차검증 BLOCK — /refine-resume 로 지적 반영 후 /cross-verify 재실행
review 없음          → /review-resume {company}
refine 없음          → /refine-resume {company}
final-check 없음     → /final-check {company}
pdf 없음             → /pdf-resume {company}
전부 완료            → "🎉 파이프라인 완료"
```

### Step 4.5: JD 지원 상태 수렴 (놓친 이동 자동 복구)

PDF가 있는데 JD가 아직 `pending/`에 있으면 **여기서 옮기고 화면에 표시한다.**

```bash
find src -type d -name pending -o -type d -name applied | while read d; do echo "[$d]"; ls "$d"; done
```

`/pdf-resume` Step 5가 이 이동을 하지만, 파일명 표기가 어긋나 건너뛴 적이 있다(2026-09). 대시보드는 어차피
`outcome/` 전체를 스캔하므로 **여기가 마지막 그물**이다. 커맨드를 하나 더 만들지 않고 여기서 수렴시킨다.
회사 폴더명과 JD 파일명 표기가 다를 수 있으니(하이픈 vs 언더스코어, 직무 접미사) 글롭에 의존하지 말고
`ls` 결과를 눈으로 대조한다.

### Step 5: dashboard.html 생성

아래 스펙대로 완전한 HTML 파일을 Write 도구로 `dashboard.html`에 저장한다.

---

## dashboard.html 스펙

### 기술 스택

- Vanilla HTML/CSS/JS (빌드 도구 없음)
- `marked.js` CDN: `https://cdn.jsdelivr.net/npm/marked/marked.min.js`
- 모든 MD 콘텐츠는 `<script>` 태그 내 JS 객체로 임베드

### JS 데이터 구조

```js
const PIPELINE_DATA = {
  generatedAt: "{YYYY-MM-DD HH:MM}",
  companies: [
    {
      name: "kakao-style",
      stages: {
        draft: { done: true,  tabs: { A: "...md content...", B: "...md...", C: "...md..." } },
        verify: { done: true,  content: "...md content..." },
        review: { done: true,  content: "...md content..." },
        refine: { done: false, content: null },
        pdf:    { done: false, content: null }
      },
      nextCommand: "/refine-resume kakao-style"
    }
  ]
};
```

MD 콘텐츠를 JS 문자열로 임베드할 때 백틱(`` ` ``)과 `\`는 이스케이프 처리한다.

### CSS 색상 팔레트

```css
--bg:         #1a1a2e;
--card:       #16213e;
--accent:     #0f3460;
--done:       #4caf50;
--pending:    #555;
--text:       #eee;
--text-dim:   #999;
--content-bg: #ffffff;
```

### UI 컴포넌트

**1. 헤더**
```
oh-my-career Dashboard  |  생성: {generatedAt}
```

**2. 회사 탭 (상단)**
- 회사별 버튼, 클릭 시 해당 회사 뷰로 전환
- 활성 탭은 `--accent` 색상

**3. 진행률 스테퍼**
```
● draft ─── ● verify ─── ○ review ─── ○ refine ─── ○ pdf
```
- 완료(done: true): 채워진 원 `●` + 초록색(`--done`)
- 미완료(done: false): 빈 원 `○` + 회색(`--pending`)

**4. 콘텐츠 탭 (있는 것만 표시)**
`Draft A | Draft B | Draft C | Verify | Review | Final`

**5. 마크다운 뷰어**
- `marked.js`로 렌더링
- `max-height: 65vh; overflow-y: auto;`
- 흰색 배경(`--content-bg`), 패딩 24px
- `content: null`인 탭 안내 문구는 모드에 따라 다르다:
  - 단계 미완료 → "아직 생성되지 않았습니다"
  - 현황 모드라 안 읽음 → "상세 열람: `/dashboard {company}`"

**6. 다음 단계 박스 (하단 고정)**
```
다음 단계:  /refine-resume kakao-style   [📋 복사]
```
- 코드 스타일 배경 (`#0d1117`)
- [📋 복사] 버튼 클릭 → `navigator.clipboard.writeText()` → "✅ 복사됨!" 1.5초 표시
- 전부 완료 시: "🎉 파이프라인 완료" 표시 (복사 버튼 없음)
- 회사 전환 시 해당 회사의 다음 커맨드로 업데이트

**파일이 하나도 없는 경우**
빈 회사 목록 상태의 HTML 생성 + 시작 안내:
```
아직 실행된 파이프라인이 없습니다.
/draft-resume {회사명} 으로 시작하세요.
```

---

## Critical Rules

- 회사명은 폴더명에서 자동 감지 — 사용자 입력 불필요
- **기본은 현황 모드** — 인자 없이 호출됐는데 전 회사 MD를 읽지 않는다
- MD 콘텐츠를 요약하거나 수정하지 않음 — 원문 그대로 임베드
- HTML/PDF 파일은 콘텐츠 탭에 표시하지 않음 (존재 여부만 확인)
- `dashboard.html`은 항상 프로젝트 루트에 덮어씌워 저장
- 파일이 없어도 에러 없이 빈 대시보드 HTML 생성

---

## Completion

```
✅ dashboard.html 생성 완료

브라우저에서 열기:
  file:///…/oh-my-career/dashboard.html

감지된 회사: {count}개 — {company1}, {company2}, ...
```
