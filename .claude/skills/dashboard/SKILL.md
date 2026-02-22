---
name: dashboard
description: Use when you want to visualize the resume pipeline status. Triggers on "/dashboard", "대시보드", "파이프라인 현황", "진행 상태 확인".
---

# dashboard

## Overview

`outcome/` 폴더를 스캔해 회사별 파이프라인 진행 상태를 읽고, 브라우저에서 바로 열 수 있는 자기 완결형 `dashboard.html`을 프로젝트 루트에 생성한다.

---

## Process

### Step 1: 회사 감지

`outcome/` 하위 5개 폴더를 모두 스캔해 `{company}-*.md` 패턴 파일에서 회사명을 유니크하게 수집한다.

```
Glob: outcome/1_draft/*-draft-A.md   → 주요 감지 소스
Glob: outcome/2_verify/*-verify.md
Glob: outcome/3_review/*-review.md
Glob: outcome/4_refine/*-final.md
Glob: outcome/5_pdf/*-final.html
Glob: outcome/5_pdf/*-final.pdf
```

파일명에서 회사명 파싱 규칙:
- `kakao-style-draft-A.md` → 회사명: `kakao-style`
- `naver-verify.md` → 회사명: `naver`
- `toss-final.html` → 회사명: `toss`

수집한 회사명 중복 제거 후 알파벳 순 정렬.

### Step 2: 단계별 존재 확인 (회사마다)

각 회사에 대해 아래 파일 존재 여부를 확인한다:

| 단계 | 파일 | done 조건 |
|------|------|-----------|
| draft | `outcome/1_draft/{company}-draft-A.md` | A 파일 존재 |
| verify | `outcome/2_verify/{company}-verify.md` | 존재 |
| review | `outcome/3_review/{company}-review.md` | 존재 |
| refine | `outcome/4_refine/{company}-final.md` | 존재 |
| pdf | `outcome/5_pdf/{company}-final.html` 또는 `-final.pdf` | 둘 중 하나 존재 |

draft의 B, C 파일도 각각 존재 여부 확인:
- `outcome/1_draft/{company}-draft-B.md`
- `outcome/1_draft/{company}-draft-C.md`

### Step 3: 파일 읽기

존재하는 MD 파일을 Read 도구로 전부 읽어 내용 수집:

```
Read: outcome/1_draft/{company}-draft-A.md  (있는 경우)
Read: outcome/1_draft/{company}-draft-B.md  (있는 경우)
Read: outcome/1_draft/{company}-draft-C.md  (있는 경우)
Read: outcome/2_verify/{company}-verify.md  (있는 경우)
Read: outcome/3_review/{company}-review.md  (있는 경우)
Read: outcome/4_refine/{company}-final.md   (있는 경우)
```

HTML/PDF 파일은 읽지 않는다.

### Step 4: 다음 단계 커맨드 결정 (회사마다)

```
draft 없음   → /draft-resume {company}
verify 없음  → /verify-resume {company}
review 없음  → /review-resume {company}
refine 없음  → /refine-resume {company}
pdf 없음     → /pdf-resume {company}
전부 완료    → "🎉 파이프라인 완료"
```

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
- `content: null`인 탭은 "아직 생성되지 않았습니다" 안내

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

- 회사명은 파일명에서 자동 파싱 — 사용자 입력 불필요
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
