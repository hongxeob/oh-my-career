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


### 🚫 교차검증 게이트 (모든 하류 노드가 각자 검사한다)

```bash
CV=outcome/{company}/2_verify/{company}-cross-verify.md
[ -f "$CV" ] || { echo "❌ 교차검증 리포트가 없다. /cross-verify 를 먼저 실행하라."; exit 1; }
grep -m1 '^GATE:' "$CV"      # GATE: PASS 한 줄만 본다
```

`GATE: PASS`가 아니면 **중단하고 사용자에게 보고한다.**

⚠️ **게이트를 `review-resume` 한 곳에만 두지 않는다.** 예전에 그랬는데, BLOCK 복구 경로(사용자가 "고쳐줘"라고
답한 뒤)가 하필 그 노드를 지나가지 않아서 **review와 cross-verify를 둘 다 건너뛰고 제출본이 나올 수 있었다.**
사용자의 "진행"은 *고치라는 동의*였지 *제출하라는 동의*가 아니다. 게이트는 하류 전 노드가 각자 검사한다.

⚠️ **`grep BLOCK`으로 판정하지 마라.** 리포트 본문에 회차 이력(`1차 BLOCK → 3차 PASS`)이 적히면 통과한
문서를 거부하거나 그 반대가 된다. **`^GATE:` 줄 하나만** 본다.

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

**`{company}-final.md`는 제출본 그 자체다 — 첫 줄부터 마지막 줄까지 전부 HTML에 넣는다.**
파이프라인 메타는 `{company}-changelog.md`에 따로 있다.

⚠️ **위치로 자르지 않는다.** 예전엔 "첫 `---` 다음부터 `## 변경 이력` 직전까지가 본문"이라는 규칙이었는데
두 가지가 깨져 있었다: ① 연락처 아래 구분선이 첫 `---`라서 **이름과 연락처가 잘려나간다**
② `## 변경 이력`이 별도 파일로 빠져 끝 앵커를 못 찾는다.

**옛 형식(리포트 래퍼가 씌워진 final.md)을 만나면** 아래만 걷어내고 나머지는 전부 본문으로 취급한다:
- 상단 메타(`# {company} 지원 이력서 — 최종본`, `생성일:`, `기반:`, `적용 피드백:`)
- `## 변경 이력` 표와 `**전략적 의도**` 문단

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

**⚠️ `break-inside: avoid` 추가 금지** — `section`이나 `.company-block`에 걸면 큰 블록이 통째로 다음 페이지로 밀려 **앞 페이지가 절반 빈 채로 페이지가 하나 늘어난다.** 템플릿에서 의도적으로 뺀 속성이다.

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

HTML 저장 후 공용 스크립트 한 번으로 렌더와 검사를 끝낸다. 렌더, 페이지 수, 폰트, 페이지별 텍스트 밀도가
한 번에 나온다. **셸 명령을 여기 새로 적지 않는다** — 환경 지식은 `_shared/render-pdf.sh` 한 곳에만 둔다.

```bash
# 마지막 인자 = 최대 페이지. 값의 출처는 CLAUDE.md 「분량 기준」의 **상한**이다.
# 바꾸려면 거기를 먼저 고친다 (이 파일이 그 숫자를 갖는 유일한 스킬이다 — 강제하는 쪽이라서).
bash .claude/skills/_shared/render-pdf.sh \
  outcome/{company}/5_pdf/{company}-final.html \
  outcome/{company}/5_pdf/{company}-final.pdf 3
echo "rc=$?"   # 0=통과  2=분량 게이트 실패  3=환경 오류
```

**렌더 전 분량 예산** — 렌더해봐야 페이지 수를 아는 왕복을 줄인다. 템플릿 CSS가 고정이라 바이트와 페이지가
거의 비례한다: **본문 HTML 약 6KB당 1페이지**(2026-09 실측: 12,114 B → 정확히 2p).
Step 3에서 HTML을 저장한 직후 `wc -c`로 재고, CLAUDE.md 「분량 기준」의 상한 × 6KB를 넘으면 렌더하기 전에 줄인다.
**목표를 넘었다는 이유만으로는 줄이지 않는다** — 상한 안이면 그대로 낸다.

스크립트가 `❌ 목표 초과`로 끝나면 페이지 경계를 본다. 앞 페이지가 절반 넘게 비었는데 다음 페이지가 꽉 차 있으면
`break-inside: avoid` 계열이 원인이다(Step 2 경고 참조). **콘텐츠를 줄이기 전에 CSS부터 의심할 것.**

### 🔴 rc=0이어도 마지막 페이지 밀도를 본다

분량 상한이 목표보다 크므로, **CSS 결함으로 늘어난 페이지가 게이트를 통과한다.** 상한이 목표와 같았을 땐
페이지 수 게이트가 이걸 대신 잡아줬지만 이제 안 잡는다. 스크립트의 빈 페이지 검사도 `ops < 20`,
즉 **완전히 빈** 페이지만 걸러서 "절반 빈 페이지"는 통과한다.

그래서 **rc=0이고 페이지 수가 목표를 넘었으면** 스크립트가 출력한 페이지별 밀도를 직접 본다:

- 어떤 페이지의 밀도가 앞 페이지들의 **절반 이하**면 CSS 결함을 의심한다 (콘텐츠가 모자란 게 아니다)
- 마지막 페이지가 몇 줄뿐이면 그 몇 줄을 줄여 한 페이지를 없앨 수 있는지 먼저 본다
- **밀도가 고르면 그대로 낸다.** 목표를 넘었다는 이유만으로 내용을 깎지 않는다 (CLAUDE.md 「분량 기준」)

Chrome이 없어 스크립트가 멈추면 스크립트가 출력하는 설치 명령을 사용자에게 안내한다.


### Step 5: JD 파일 pending → applied 이동 (건너뛰지 않는다)

PDF 생성 확인 후 JD를 `applied/`로 옮긴다.

```bash
PENDING=$(find src -type d -name pending | head -1)      # 경로는 바뀐다. 디렉토리 이름으로 찾는다
# 가드 없이 진행하면 dirname "" = "." 이라 리포 루트에 applied/ 를 만들고
# mv 소스가 "/파일명" (파일시스템 루트)이 된다. 게다가 mkdir 은 exit 0 이라 조용하다.
[ -n "$PENDING" ] && [ -d "$PENDING" ] || { echo "❌ pending 디렉토리를 찾을 수 없다. 중단한다."; exit 1; }
APPLIED=$(dirname "$PENDING")/applied
mkdir -p "$APPLIED"
ls "$PENDING"                                            # 먼저 실제 파일명을 본다
mv "$PENDING/<실제파일명>" "$APPLIED/"
```

⚠️ **`{company}*_jd.md` 글롭에 의존하지 않는다.** 회사 폴더명과 JD 파일명이 다른 표기를 쓴다:
회사 폴더는 하이픈(`some-corp`)인데 JD 파일은 언더스코어에 직무 접미사가 붙어 있거나(`some_corp_server_jd.md`),
폴더명과 JD 파일명의 회사 표기 자체가 다를 수 있다.
글롭은 이 둘 다 매치하지 못한다. **`ls`로 눈으로 확인하고 옮긴다.**

**이미 `applied/`에 있으면 성공으로 간주하고 넘어간다** (재실행 안전). PDF만 다시 뽑을 때 이 단계가 실패로
보이면 안 된다.

🚫 **Step 4가 rc=0이 아니면 이 단계를 실행하지 않는다.** 렌더 스크립트는 실패 시 PDF를 지우지만,
이 이동은 파일시스템에 남는 유일한 "지원함" 신호이고 되돌리는 절차가 없다. 게이트에서 떨어진 문서를
"지원 완료"로 기록하지 않는다.

**JD가 pending/에 없으면 건너뛰지 말고 어디 있는지 찾아 옮긴다.** 이 이동이 "지원함 / 안 함"을 구분하는
유일한 장치다. 실제로 경로가 어긋났다는 이유로 이 단계를 건너뛴 적이 있고(2026-09), 그 결과 어디까지
지원했는지 파일 구조로 알 수 없는 상태가 됐다. 경로가 문서와 다르면 **문서를 고치고 옮긴다.**

## Critical Rules

- **콘텐츠 수정 금지** — 마크다운 문장의 **표현·수치·사실을 바꾸지 않는다**. 허용되는 것은 마크업 변환뿐이다: 마크다운 → HTML 태그, 그리고 서브 불렛 분리(문장을 절 경계에서 나눠 중첩 `<ul>`로 옮기는 것 — 단어를 고쳐 쓰는 것이 아니다)
- **4_refine 파일 없으면 즉시 중단** — 이전 단계 건너뛰기 방지
- **CSS 재작성 금지** — `template.html`을 읽어 placeholder만 치환한다. 스타일을 바꿔야 하면 템플릿 파일 자체를 고쳐 모든 회사에 반영되게 한다
- **사진은 있을 때만** — `src/photo.jpg` 없으면 사진 영역 자체를 생략
- **px 단위 사용 금지** — 사진·여백은 반드시 mm 단위 (px는 인쇄 시 축소됨)

## Completion

```
✅ HTML 저장 완료 → outcome/{company}/5_pdf/{company}-final.html
✅ PDF 생성 완료 → outcome/{company}/5_pdf/{company}-final.pdf ({N}페이지)
{JD를 옮겼으면}  ✅ JD 이동 완료 → pending/{실제 파일명} → applied/{실제 파일명}
{옮길 게 없었으면} ⏭️ JD 이동 생략 — pending/에 해당 JD 없음 (이미 applied면 성공으로 친다)

이력서 파이프라인 완료:
  {RESUME} + {JD}
  → outcome/{company}/0_evaluate/ (JD 적합도)
  → outcome/{company}/1_draft/    (초안 3가지)
  → outcome/{company}/2_verify/   (팩트/JD 검증 + 교차검증)
  → outcome/{company}/3_review/   (품질 리뷰)
  → outcome/{company}/4_refine/   (최종본 + 최종 검토)
  → outcome/{company}/5_pdf/      (HTML + PDF 제출본)
```
