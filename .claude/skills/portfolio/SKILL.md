---
name: portfolio
description: Use when a résumé is finalized and the application also asks for a portfolio/deep-dive attachment. Builds a self-contained deep-dive portfolio PDF (2-3 flagship projects, CSS-rendered architecture diagrams) that shows the depth the 경력기술서 intentionally withheld. Triggers on "/portfolio", "포트폴리오", "딥다이브", "portfolio 첨부".
---

# portfolio

## Overview

경력기술서(`4_refine`)가 **짧게·스캔·호기심 남기기**라면, 포트폴리오는 **깊게·보여주기·호기심 해소**다.
지원 폼이 경력기술서 텍스트박스와 별도로 "포트폴리오 첨부"를 요구할 때, 대표 프로젝트 2~3개를
아키텍처 다이어그램 + 설계 의사결정(왜) + 트러블슈팅 딥다이브 + 수치로 깊게 푼 PDF를 만든다.

**핵심 정체성: 경력기술서 ≠ 포트폴리오.** 경력기술서서 아낀 메커니즘·트레이드오프를 여기서 푼다.
경력기술서와 문장을 재탕하면 실패다.

## Input

> 경로 이름(`{RESUME}`, `{JD}`)의 정의는 **CLAUDE.md 「경로 해석」** 한 곳에 있다. 파일을 못 찾으면 스킬을 고치지 말고 그 표를 고친다.

- 팩트 기준: `{RESUME}`
- 강조점 파악: `outcome/{company}/4_refine/{company}-final.md`
- 프로젝트 우선순위: `{JD}`  — JD에 중요한 프로젝트를 flagship으로
- 선택: instruction/ 이미지·배경 자료 (있으면 문제 정의에 반영, 단 PDF엔 외부 이미지 임베드 금지 — §Critical 참조)

## Output

- `outcome/{company}/6_portfolio/{company}-portfolio.html`
- `outcome/{company}/6_portfolio/{company}-portfolio.pdf`

## Design Rubric (작성 시 강제)

- **A. 선택과 집중** — flagship 2~3개만. JD 매칭 최상위 프로젝트. 전 경력 나열 금지.
- **B. 깊이 우선** — 프로젝트마다 `문제 → 아키텍처 → 설계 결정(왜) → 트러블슈팅 딥다이브 → 결과(수치)`. "무엇을 했다"가 아니라 **"왜 그렇게 설계했나"**. 경력기술서서 뺀 메커니즘(구현 디테일·트레이드오프)을 여기서 푼다.
- **C. 중복 금지** — 경력기술서와 같은 문장 재탕 시 실패. 확장·심화여야 한다.
- **D. 시각화 필수** — before/after·flow 다이어그램을 **CSS 박스로 자체 렌더**. 텍스트 벽 금지.
- **E. 팩트 고정** — 모든 수치·기술은 `my-resume.md` 근거. 없으면 생성 금지. "왜 어려웠나" 같은 서술도 원본 사실 범위 내에서만.
- **F. 자기완결** — A4 인쇄, 폰트 임베드, px 금지 mm 단위, PDF 3~6p.

## Process

### Step 1: 로드 및 flagship 선정
```
Read: {RESUME}, outcome/{company}/4_refine/{company}-final.md, {JD}
```
JD 핵심 요구와 최상위로 매칭되는 프로젝트 2~3개 선정. 각 프로젝트에 원본에서 쓸 수 있는
`문제 / 설계결정 / 트러블슈팅 / 수치` 재료가 충분한지 확인 (부족하면 다른 프로젝트로 교체).

### Step 2: HTML 작성

구조: `커버(이름·intro·목차) → 프로젝트별 섹션(break-before: page) → 마무리`.

각 프로젝트 섹션 골격:
- `<h2>` 제목 + `<p class="lead">` 한 줄 요약 + meta(기간·역할) + 태그
- **문제** (bullet)
- **아키텍처 다이어그램** (before→after 또는 정상/장애 flow) — 아래 CSS 패턴
- **핵심 설계 결정** (각 bullet에 "왜")
- 필요 시 **트러블슈팅 딥다이브** (별도 서브 페이지) + "왜 어려웠나" callout
- **결과** (`.result` 박스, 수치 강조)
- 링크 (PR·블로그, 있을 때만, 주제 일치할 때만)

**다이어그램 CSS 패턴** (외부 이미지 없이 자체 렌더):
```css
.diagram { display:flex; gap:8px; font-size:8.6pt; }
.dcol { flex:1; }
.box { border:1px solid #bbb; border-radius:3px; padding:5px 6px; margin:4px 0; text-align:center; background:#fafafa; }
.box.bad { background:#fbeeee; border-color:#e0b4b4; }   /* 문제/장애 */
.box.good{ background:#eef6ee; border-color:#b7d7b7; }   /* 개선 */
.box.hl  { background:#eaf1fb; border-color:#b3ccef; font-weight:700; } /* 결과 */
.arrow { text-align:center; color:#999; }
.dvs { display:flex; align-items:center; font-weight:700; color:#888; } /* before → after 구분자 */
.flow { display:flex; align-items:center; gap:6px; flex-wrap:wrap; }    /* 가로 flow */
```
before/after = `.diagram > .dcol(Before) + .dvs(→) + .dcol(After)`.
정상/장애 = `.flow`에 `.box` 나열 + `→`.

프린트 CSS: `@page { size:A4; margin:16mm }`, Noto Sans KR 임베드, `li{break-inside:avoid}`,
`.page{break-before:page}`.

### Step 3-4: PDF 변환과 렌더 게이트

공용 스크립트가 렌더, 페이지 수, 폰트, 페이지별 텍스트 밀도를 한 번에 낸다. **셸 명령을 여기 새로 적지 않는다** —
Chrome 경로와 검사 방법은 `_shared/render-pdf.sh` 한 곳에만 둔다(예전에 각자 적었다가 이 스킬만 낡아서 죽었다).

```bash
bash .claude/skills/_shared/render-pdf.sh \
  outcome/{company}/6_portfolio/{company}-portfolio.html \
  outcome/{company}/6_portfolio/{company}-portfolio.pdf 6
```

- `⚠️ 거의 빈 페이지` 또는 오버플로우(한 줄만 넘어간 페이지) → 밀도 조정(font-size, line-height, padding, 또는 해당 문장 축약) 후 재실행.
- 목표 3-6p, 빈 페이지 0, 다이어그램 안 깨짐.
- **반복 상한 3회.** 3회에 못 맞추면 멈추고 사용자에게 현재 페이지 구성과 막힌 지점을 보고한다. 무한 루프 금지.
- 렌더 전 예산: 본문 HTML 약 12KB = 2페이지(2026-09 실측). 3-6p면 대략 18-36KB. `wc -c`로 먼저 재고 크게 벗어나면 렌더하기 전에 조정한다.

## Verification (작성 후 별도 검증 패스 — 자기승인 금지)

작성 패스와 분리해 검증. `code-reviewer`/`verifier` 또는 final-check 페르소나로 실행. 5게이트:

| 게이트 | 방법 | 통과 기준 |
|--------|------|-----------|
| 팩트 | 포트폴리오 수치/주장 vs `my-resume.md` 대조 | 날조 0 |
| 중복 | 경력기술서(`outcome/{company}/4_refine/`)와 문장 중복 확인 | 재탕 아닌 심화 |
| 깊이 | 프로젝트별 `문제+설계결정(왜)+트러블슈팅/다이어그램+수치` | 4요소 구비 |
| 렌더 | Step 4 페이지별 스캔 | 빈 페이지·오버플로우 0, 3~6p |
| 채용자 시각 | final-check 페르소나 "면접 부르고 싶은가" | 보통 이상 |

## Critical Rules

- **외부 이미지 임베드 금지** — 다이어그램은 CSS 박스로만. instruction 이미지는 문제 정의의 *근거*로만 쓰고 PDF엔 넣지 않는다 (경로 깨짐·전송 실패 방지).
- **팩트 고정** — `my-resume.md`에 없는 수치·사실 생성 금지. 트러블슈팅 서술도 원본 사실 범위 내.
- **경력기술서와 중복 금지** — 같은 문장 복붙이면 포트폴리오 존재 이유 없음.
- **flagship 2~3개** — 많으면 깊이가 죽는다. 나열은 경력기술서가 한다.

## Next Step

```
✅ 포트폴리오 완료 → outcome/{company}/6_portfolio/{company}-portfolio.pdf

경력기술서(PDF/텍스트박스)와 함께 제출:
  - 경력기술서 텍스트박스 ← 4_refine 기반 plain text
  - 포트폴리오 첨부 ← 6_portfolio PDF (딥다이브)
```
