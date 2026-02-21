# oh-my-career 🚀

JD를 분석해 맞춤 이력서를 **5단계 파이프라인**으로 자동 생성하는 Claude Code 기반 이력서 작성 자동화 시스템.

> 📦 **예시 파일 포함**: `src/my-resume.md` (가상 인물), `src/example-jd.md`, `outcome/` 예시 출력물로 파이프라인 전체 흐름을 즉시 확인할 수 있습니다.

---

## ⚠️ AI를 보조 도구로 활용하세요

이 파이프라인은 이력서 작성을 **자동화**하지만, 최종 결과물의 품질은 **당신의 검토**에 달려 있습니다.

> **각 단계 결과물을 반드시 직접 열어서 읽어보세요.**<br>
> AI가 생성한 내용 중 어색한 표현, 불필요한 내용, 또는 본인 스타일과 맞지 않는 부분은 직접 수정하거나 제거하는 것을 권장합니다.<br>
> 에이전트의 출력을 100% 신뢰하지 말고, 항상 **본인이 최종 편집자**라는 관점으로 활용하세요.

---

## 파이프라인 개요

```
src/my-resume.md  +  src/{company}-jd.md
          │
          ▼
   /draft-resume  →  outcome/1_draft/{company}-draft-{A|B|C}.md
          │
          ▼
  /verify-resume  →  outcome/2_verify/{company}-verify.md
          │
          ▼
  /review-resume  →  outcome/3_review/{company}-review.md
          │
          ▼
  /refine-resume  →  outcome/4_refine/{company}-final.md
          │
          ▼
    /pdf-resume   →  outcome/5_pdf/{company}-final.html + .pdf
```

---

## 🚀 빠른 시작

### 1단계: 파일 준비

```
src/
├── my-resume.md      ← 내 원본 이력서 작성 (팩트 기준, 절대 수정 금지)
└── {company}-jd.md   ← 지원 회사 JD 붙여넣기
```

> `{company}` 예시: `kakao`, `toss`, `line-plus` 등 회사명 영문 소문자

💡 **JD 수집 팁**: 채용 공고 URL 앞에 `r.jina.ai/`를 붙이면 광고·노이즈 없이 깨끗한 텍스트 형태로 JD를 가져올 수 있습니다.
```
# 예시
https://r.jina.ai/careers.kakao.com/jobs/12345
```
가져온 내용을 `src/{company}-jd.md`에 붙여넣으면 AI가 훨씬 정확하게 분석합니다.

### 2단계: Claude Code에서 파이프라인 실행

```bash
# Claude Code 실행
claude

# 슬래시 커맨드 순서대로 실행
/draft-resume
/verify-resume
/review-resume
/refine-resume
/pdf-resume
```

각 커맨드를 실행하면 Claude가 자동으로 파일을 읽고 결과물을 `outcome/` 하위 폴더에 저장합니다.

---

## 📁 디렉토리 구조

```
oh-my-career/
├── src/
│   ├── my-resume.md          # 원본 이력서 (팩트 기준 — 절대 수정 금지)
│   └── {company}-jd.md       # 지원 회사 JD
├── instruction/              # 워크플로우 추가 지침 (선택)
├── .claude/
│   └── skills/               # 파이프라인 스킬 정의
│       ├── draft-resume/
│       ├── verify-resume/
│       ├── review-resume/
│       ├── refine-resume/
│       └── pdf-resume/
└── outcome/
    ├── 1_draft/              # 초안 3가지 (A/B/C 버전)
    ├── 2_verify/             # 팩트 검증 + JD 정합성 리포트
    ├── 3_review/             # 품질 리뷰 리포트
    ├── 4_refine/             # 마크다운 최종본
    └── 5_pdf/                # HTML + PDF 제출본
```

---

## 📝 파일 명명 규칙

```
outcome/1_draft/{company}-draft-{A|B|C}.md
outcome/2_verify/{company}-verify.md
outcome/3_review/{company}-review.md
outcome/4_refine/{company}-final.md
outcome/5_pdf/{company}-final.html
outcome/5_pdf/{company}-final.pdf
```

**예시** (피치페이 지원 시):
```
src/peachpay-jd.md
outcome/1_draft/peachpay-draft-A.md
outcome/1_draft/peachpay-draft-B.md
outcome/1_draft/peachpay-draft-C.md
outcome/2_verify/peachpay-verify.md
outcome/3_review/peachpay-review.md
outcome/4_refine/peachpay-final.md
outcome/5_pdf/peachpay-final.html
outcome/5_pdf/peachpay-final.pdf
```

---

## 🔍 각 단계 설명

### 1. `/draft-resume` — 전략별 초안 3가지 생성

`src/my-resume.md`와 JD를 분석해 **서로 다른 전략**의 초안 3가지를 자동 생성합니다.

| 버전 | 전략 |
|------|------|
| A | 상세 서술형 — 기술 깊이·의사결정 과정 강조 |
| B | 임팩트 중심형 — 수치 성과를 최전면 배치 |
| C | 도메인 전문성 중심 — JD 키워드 밀도 최대화 |

> 👀 **검토 포인트**: 세 버전을 비교하며 본인의 강점을 가장 잘 드러내는 버전을 선택하세요. AI가 과장하거나 원본에 없는 내용을 추가했는지 반드시 확인하세요.

### 2. `/verify-resume` — 팩트 검증 + JD 정합성 체크

- 원본 이력서 대비 **수치/사실 오류 검출**
- JD 필수·우대 항목별 **커버리지 매핑**
- 버전별 **추천 순위** 결정

> 👀 **검토 포인트**: ❌ 항목은 반드시 처리해야 하지만, ⚠️ 항목은 맥락에 따라 유지할 수도 있습니다. 리포트를 맹목적으로 따르지 말고 직접 판단하세요.

### 3. `/review-resume` — 채용자 시각 품질 리뷰

- Summary/Bullets **STAR 밀도 분석**
- 표현 개선 제안 (Action only → Action + Result)
- 분량, 구조, 키워드 커버리지 종합 점수

> 👀 **검토 포인트**: 제안된 표현이 어색하거나 본인 목소리와 다르다면 그냥 넘기세요. 리뷰는 참고용이지 정답이 아닙니다.

### 4. `/refine-resume` — 마크다운 최종본 생성

- 검증·리뷰 피드백을 모두 반영한 **마크다운 최종본** 생성
- 콘텐츠 완성 단계 — 레이아웃 변환은 5단계에서 처리

> 👀 **검토 포인트**: 최종본을 처음부터 끝까지 직접 읽어보세요. 이전 단계에서 놓친 어색한 부분, 불필요한 내용, 삭제할 항목이 있다면 이 단계에서 직접 편집하는 것이 좋습니다.

### 5. `/pdf-resume` — HTML + PDF 변환

- `outcome/4_refine/{company}-final.md`를 **스타일드 HTML**로 변환
- Chrome headless로 **A4 PDF** 자동 생성
- 프로필 사진(`src/photo.jpg`) 존재 시 헤더 우상단에 자동 삽입
- 콘텐츠 수정 없이 레이아웃·인쇄 CSS만 처리

> 👀 **검토 포인트**: 생성된 PDF를 열어 페이지 잘림, 폰트, 여백, 사진 위치를 눈으로 확인하세요. 필요 시 HTML 파일을 직접 수정한 뒤 PDF를 재생성하면 됩니다.

---

## 🔒 핵심 규칙

- `src/my-resume.md`는 팩트 기준 — **이 파일의 수치/사실을 절대 변형하지 않는다**
- 원본에 없는 숫자나 사실을 생성하지 않는다
- 각 단계 결과물은 반드시 해당 `outcome/` 하위폴더에 저장한다
- **단계를 건너뛰지 않는다** (draft → verify → review → refine → pdf 순서 준수)

---

## 📂 예시 파일

이 레포에는 가상 인물 **김개발**을 기준으로 한 예시 파일이 포함되어 있습니다.

```
src/my-resume.md          → 가상 인물 예시 이력서 (결제/핀테크 백엔드 엔지니어)
src/example-jd.md         → 가상 회사 "피치페이" JD
outcome/1_draft/          → 전략별 초안 3가지 예시
outcome/2_verify/         → 팩트 검증 리포트 예시
outcome/3_review/         → 품질 리뷰 리포트 예시
outcome/4_refine/         → 마크다운 최종본 예시
outcome/5_pdf/            → HTML + PDF 예시
```

실제 사용 시 `src/my-resume.md`를 본인 이력서로 교체하고 지원 회사 JD 파일을 추가하면 됩니다.

---

## 🛠️ 사전 요구사항

- [Claude Code](https://claude.ai/code) 설치
- `~/.claude/` 디렉토리에 스킬 파일이 있거나 프로젝트 내 `.claude/skills/` 경로에 스킬이 위치해야 합니다

---

## 라이선스

MIT
