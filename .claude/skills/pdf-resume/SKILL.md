---
name: pdf-resume
description: Use when a finalized resume markdown exists and needs to be converted to HTML and PDF for submission. Triggers on "/pdf-resume", "pdf 변환", "이력서 pdf", "HTML 변환", "제출용 pdf".
---

# pdf-resume

## Overview

`outcome/{company}/4_refine/{company}-final.md`를 **스타일드 HTML로 변환하고 PDF를 생성**한다.
이 단계는 콘텐츠를 수정하지 않는다 — 레이아웃과 프레젠테이션만 처리한다.

## Input

- `outcome/{company}/4_refine/{company}-final.md` — refine-resume 단계 완성본
- `.claude/skills/pdf-resume/template.html` — HTML/CSS 템플릿 (CSS를 매번 새로 쓰지 않는다)
- `src/photo.jpg` — 프로필 사진 (있을 때만 삽입, 없으면 생략)

## Output

- `outcome/{company}/5_pdf/{company}-final.html`
- `outcome/{company}/5_pdf/{company}-final.pdf`

## Process

### Step 1: 파일 로드 및 회사명 감지

```
Read: outcome/{company}/4_refine/{company}-final.md
```

- 파일이 없으면 즉시 중단:
  ```
  ❌ outcome/{company}/4_refine/{company}-final.md 파일이 없습니다.
     먼저 /refine-resume를 실행해 최종본을 생성하세요.
  ```
- 폴더명/파일명에서 `{company}` 자동 파싱 (예: `outcome/kakao-style/4_refine/kakao-style-final.md` → `kakao-style`)
- `src/photo.jpg` 존재 여부 확인

### Step 2: HTML 변환 (템플릿 치환)

**CSS를 직접 작성하지 않는다.** 같은 디렉토리의 `template.html`을 읽어 placeholder만 치환한다.

```
Read: .claude/skills/pdf-resume/template.html
```

치환 대상:

| Placeholder | 채울 내용 |
|-------------|----------|
| `{{NAME}}` / `{{COMPANY_LABEL}}` | 이름 / 지원 회사명(title 태그용) |
| `{{JOB_TITLE}}` | 직함 (예: Backend Engineer) |
| `{{CONTACT_LINE}}` | 이메일·전화·GitHub·Blog·LinkedIn (`<a>` 링크 포함) |
| `{{PHOTO}}` 주석 블록 | `src/photo.jpg` 있으면 `<img class="photo">` 유지, 없으면 img 태그째 삭제 |
| `{{SUMMARY}}` | 최종본 Summary 문단 |
| `{{CAREER_BLOCKS}}` | 회사마다 `.company-block` 반복 (아래 규칙) |
| `{{STACK_ROWS}}` | 기술 스택 표 행 (JD 필수 기술이 위로) |

`.company-block` 반복 규칙:
- `.company-header` = 회사명·팀·직책 + 기간
- `.company-intro` = 최종본의 `>` 블록쿼트 한 줄
- 최종본에 `####` 소제목이 있으면 `<h4>`로, 없으면 `<ul>`만
- `.stack` = 회사별 기술 스택 줄, 기술마다 `<code>` 하나씩

템플릿 CSS는 손대지 않는다. 분량 조정이 필요하면 Step 4 렌더 확인 후 `font-size`/`margin`만 미세 조정한다.

**⚠️ `break-inside: avoid` 추가 금지** — `section`이나 `.company-block`에 걸면 큰 블록이 통째로 다음 페이지로 밀려 앞 페이지가 절반 빈 채 3페이지가 된다. 템플릿에서 의도적으로 뺀 속성이다.

**서브 불렛 가이드라인** — 가독성을 위해 긴 bullet은 중첩 `<ul>`로 분리한다:

- **서브 불렛을 써야 하는 경우**: 하나의 bullet에 세미콜론(`;`) 또는 독립적인 기술 결정이 2개 이상 나열될 때
- **패턴**: 헤더 `<li>`에는 임팩트·수치만, 기술 세부·원인·해결은 서브 `<li>`로

```html
<li>
  <strong>[태그] 임팩트 설명</strong> → 결과 수치
  <ul>
    <li>원인 또는 기술 결정 1</li>
    <li>원인 또는 기술 결정 2</li>
  </ul>
</li>
```

- **서브 불렛이 불필요한 경우**: 단일 흐름(문제→해결→결과)이 자연스럽게 이어지는 짧은 bullet

### Step 3: HTML 저장

```
outcome/{company}/5_pdf/ 디렉토리 생성 (없을 경우)
outcome/{company}/5_pdf/{company}-final.html 저장
```

Write 도구로 HTML 전문을 저장한다.

### Step 4: PDF 변환

HTML 저장 완료 후 Chrome headless 명령을 실행한다:

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless --disable-gpu \
  --print-to-pdf="outcome/{company}/5_pdf/{company}-final.pdf" \
  --no-pdf-header-footer \
  "file:///$(pwd)/outcome/{company}/5_pdf/{company}-final.html"
```

- Bash 실행이 가능한 경우 직접 실행하여 PDF 생성 완료 확인
- 실행 실패 시 위 명령어를 사용자에게 출력하고 수동 실행 안내

**페이지 수 확인 (필수)** — 같은 명령에 이어 붙여 한 번에 확인한다:

```bash
pdfinfo outcome/{company}/5_pdf/{company}-final.pdf | grep -E "Pages|File size"
```

`grep -c "/Type /Page"`로 세지 말 것 — `/Type /Pages`까지 잡혀 부정확하다.

목표는 2페이지. 3페이지가 나오면 페이지 경계를 확인한다:

```bash
pdftotext -layout outcome/{company}/5_pdf/{company}-final.pdf - | awk 'BEGIN{p=1} /\f/{p++;next}{print p": "$0}'
```

앞 페이지가 절반 넘게 비었는데 다음 페이지가 꽉 차 있으면 `break-inside: avoid` 계열이 원인이다(Step 2 경고 참조). 콘텐츠를 줄이기 전에 CSS부터 의심할 것.

### Step 5: JD 파일 pending → applied 이동

PDF 생성 확인 후, `src/pending/{company}_jd.md`(또는 `{company}-jd.md`)가 존재하면 `src/applied/`로 이동한다(`mv`).
`src/pending/`에 없으면(이미 applied에 있거나 다른 위치) 건너뛴다 — 실패로 취급하지 않는다.

## Critical Rules

- **콘텐츠 수정 금지** — 마크다운의 텍스트를 한 글자도 바꾸지 않는다
- **4_refine 파일 없으면 즉시 중단** — 이전 단계 건너뛰기 방지
- **CSS 재작성 금지** — `template.html`을 읽어 placeholder만 치환한다. 스타일을 바꿔야 하면 템플릿 파일 자체를 고쳐 모든 회사에 반영되게 한다
- **사진은 있을 때만** — `src/photo.jpg` 없으면 사진 영역 자체를 생략
- **px 단위 사용 금지** — 사진·여백은 반드시 mm 단위 (px는 인쇄 시 축소됨)

## Completion

```
✅ HTML 저장 완료 → outcome/{company}/5_pdf/{company}-final.html
✅ PDF 생성 완료 → outcome/{company}/5_pdf/{company}-final.pdf
✅ JD 이동 완료 → src/pending/{company}_jd.md → src/applied/{company}_jd.md

이력서 파이프라인 완료:
  src/my-resume.md + src/applied/{company}_jd.md
  → outcome/{company}/1_draft/  (초안 3가지)
  → outcome/{company}/2_verify/ (팩트/JD 검증)
  → outcome/{company}/3_review/ (품질 리뷰)
  → outcome/{company}/4_refine/ (마크다운 최종본)
  → outcome/{company}/5_pdf/    (HTML + PDF 제출본)
```
