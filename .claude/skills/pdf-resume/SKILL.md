---
name: pdf-resume
description: Use when a finalized resume markdown exists and needs to be converted to HTML and PDF for submission. Triggers on "/pdf-resume", "pdf 변환", "이력서 pdf", "HTML 변환", "제출용 pdf".
---

# pdf-resume

## Overview

`outcome/4_refine/{company}-final.md`를 **스타일드 HTML로 변환하고 PDF를 생성**한다.
이 단계는 콘텐츠를 수정하지 않는다 — 레이아웃과 프레젠테이션만 처리한다.

## Input

- `outcome/4_refine/{company}-final.md` — refine-resume 단계 완성본
- `src/photo.jpg` — 프로필 사진 (있을 때만 삽입, 없으면 생략)

## Output

- `outcome/5_pdf/{company}-final.html`
- `outcome/5_pdf/{company}-final.pdf`

## Process

### Step 1: 파일 로드 및 회사명 감지

```
Read: outcome/4_refine/{company}-final.md
```

- 파일이 없으면 즉시 중단:
  ```
  ❌ outcome/4_refine/{company}-final.md 파일이 없습니다.
     먼저 /refine-resume를 실행해 최종본을 생성하세요.
  ```
- 파일명에서 `{company}` 자동 파싱 (예: `kakao-style-final.md` → `kakao-style`)
- `src/photo.jpg` 존재 여부 확인

### Step 2: HTML 변환

마크다운을 아래 구조의 완전한 HTML 문서로 변환한다.

**헤더 섹션** — 이름·직함·연락처 + 사진 (우상단):
```html
<header>
  <div class="header-info">
    <h1>{이름}</h1>
    <p class="title">{직함}</p>
    <p class="contact">{이메일} | {전화} | {GitHub/링크}</p>
  </div>
  <!-- photo.jpg 존재 시만 포함 -->
  <img class="photo" src="../../src/photo.jpg" alt="프로필 사진">
</header>
```

**인쇄 CSS 필수 포함**:
```css
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

@page {
  size: A4;
  margin: 18mm;
}

@media print {
  body { padding: 0; margin: 0; }
  .no-print { display: none; }
}

body {
  font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
  font-size: 10pt;
  line-height: 1.6;
  color: #222;
}

header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 8mm;
}

.photo {
  width: 30mm;
  height: 38mm;
  object-fit: cover;
  object-position: center top;
  border-radius: 2px;
}

section {
  break-inside: avoid;
  margin-bottom: 6mm;
}

h2 {
  font-size: 11pt;
  font-weight: 700;
  border-bottom: 1px solid #333;
  padding-bottom: 2px;
  margin-bottom: 4px;
}

ul { padding-left: 1.2em; margin: 2px 0; }
li { margin-bottom: 2px; }

table {
  width: 100%;
  border-collapse: collapse;
  font-size: 9.5pt;
}
th, td { padding: 3px 6px; border: 1px solid #ddd; }
th { background: #f5f5f5; font-weight: 600; }
```

**섹션 구조**: 각 섹션을 `<section>` 태그로 감싼다. 페이지 분리가 필요한 섹션에는 `style="break-before: page;"` 추가.

### Step 3: HTML 저장

```
outcome/5_pdf/ 디렉토리 생성 (없을 경우)
outcome/5_pdf/{company}-final.html 저장
```

Write 도구로 HTML 전문을 저장한다.

### Step 4: PDF 변환

HTML 저장 완료 후 Chrome headless 명령을 실행한다:

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless --disable-gpu \
  --print-to-pdf="outcome/5_pdf/{company}-final.pdf" \
  --no-pdf-header-footer \
  "file:///$(pwd)/outcome/5_pdf/{company}-final.html"
```

- Bash 실행이 가능한 경우 직접 실행하여 PDF 생성 완료 확인
- 실행 실패 시 위 명령어를 사용자에게 출력하고 수동 실행 안내

## Critical Rules

- **콘텐츠 수정 금지** — 마크다운의 텍스트를 한 글자도 바꾸지 않는다
- **4_refine 파일 없으면 즉시 중단** — 이전 단계 건너뛰기 방지
- **사진은 있을 때만** — `src/photo.jpg` 없으면 사진 영역 자체를 생략
- **px 단위 사용 금지** — 사진·여백은 반드시 mm 단위 (px는 인쇄 시 축소됨)

## Completion

```
✅ HTML 저장 완료 → outcome/5_pdf/{company}-final.html
✅ PDF 생성 완료 → outcome/5_pdf/{company}-final.pdf

이력서 파이프라인 완료:
  src/my-resume.md + src/{company}-jd.md
  → outcome/1_draft/  (초안 3가지)
  → outcome/2_verify/ (팩트/JD 검증)
  → outcome/3_review/ (품질 리뷰)
  → outcome/4_refine/ (마크다운 최종본)
  → outcome/5_pdf/    (HTML + PDF 제출본)
```
