# oh-my-career

JD를 분석해 맞춤 이력서를 생성하고, 면접까지 준비하는 Claude Code 기반 구직 자동화 프로젝트.

## 디렉토리 구조

```
oh-my-career/
├── src/
│   └── .my/                  # 개인정보 영역 (gitignore)
│       ├── my-resume.md      # 원본 이력서 (팩트 기준 — 절대 수정 금지)
│       └── jd/
│           ├── pending/{company}_jd.md   # 미지원/진행중 JD
│           └── applied/{company}_jd.md   # 지원 완료(PDF까지 생성) — pdf-resume 완료 시 자동 이동
├── instruction/              # 워크플로우 추가 지침 (선택 — 없어도 파이프라인은 돈다)
└── outcome/
    ├── {company}/            # 회사(=JD)별 패키지 — 모든 단계 산출물이 이 안에 모임
    │   ├── 0_evaluate/       # JD 적합도 평가 리포트
    │   ├── 1_draft/          # 초안 3가지 (A/B/C 버전)
    │   ├── 2_verify/         # 팩트 검증 + JD 정합성 리포트
    │   ├── 3_review/         # 품질 리뷰 리포트
    │   ├── 4_refine/         # 마크다운 최종본
    │   ├── 5_pdf/            # HTML + PDF 제출본
    │   ├── 6_portfolio/      # 딥다이브 포트폴리오 (선택 — 첨부 요구 시)
    │   └── interview/        # 회사별 면접 준비 + 복기 리포트·녹취
    └── interview/           # 회사 공통 자산 (최상위 유지)
        ├── story-bank.md     # STAR+R 스토리 뱅크
        ├── debrief-index.md  # 면접 복기 회차 누적 + 반복 지적 추적
        ├── question-bank.md  # 실제로 받은 질문 은행 (회사 무관 누적)
        ├── whiteboard-3frames.md # 화이트보드 3프레임 — 수기 작성 (생성 스킬 없음)
        └── cdc-pipeline-script.md # 색인 파이프라인 대본 — 수기 작성 (생성 스킬 없음)
```

회사 단위로 진행 상황을 체크하므로 `outcome/{company}/`가 최상위 단위다. 신규 JD는 `outcome/{company}/` 폴더를 새로 만들고 그 안에 단계별 하위폴더를 채워나간다.

## 파일 명명 규칙

```
outcome/{company}/0_evaluate/{company}-evaluate.md
outcome/{company}/1_draft/{company}-draft-{A|B|C}.md
outcome/{company}/2_verify/{company}-verify.md
outcome/{company}/2_verify/{company}-cross-verify.md
outcome/{company}/3_review/{company}-review.md
outcome/{company}/4_refine/{company}-final.md
outcome/{company}/4_refine/{company}-final-check.md
outcome/{company}/4_refine/{company}-changelog.md
outcome/{company}/5_pdf/{company}-final.html
outcome/{company}/5_pdf/{company}-final.pdf
outcome/{company}/6_portfolio/{company}-portfolio.html
outcome/{company}/6_portfolio/{company}-portfolio.pdf
outcome/{company}/interview/{company}-interview.md
outcome/{company}/interview/{company}-debrief-{N}차.md
outcome/{company}/interview/raw/{company}-{N}차-녹취.md
outcome/interview/story-bank.md
outcome/interview/debrief-index.md
outcome/interview/question-bank.md
outcome/interview/whiteboard-3frames.md    (수기 — 생성 스킬 없음)
outcome/interview/cdc-pipeline-script.md   (수기 — 생성 스킬 없음)
```

예: 카카오스타일 → `outcome/kakao-style/1_draft/kakao-style-draft-A.md`, `outcome/kakao-style/2_verify/kakao-style-verify.md` ...

## 경로 해석 (여기서만 정의한다)

스킬은 아래 **이름**으로 파일을 가리킨다. 경로가 바뀌면 **이 표만 고친다.**

| 이름 | 현재 경로 |
|------|-----------|
| `{RESUME}` | `src/.my/my-resume.md` |
| `{JD}` | `src/.my/jd/pending/{company}_jd.md` (지원 완료 후 `src/.my/jd/applied/`) |

⚠️ **스킬 파일에 경로를 하드코딩하지 않는다.** 예전에 12개 스킬이 각자 `src/my-resume.md`를 적어뒀는데,
원본을 `src/.my/`로 옮기자 7개 스킬과 동기화 훅이 **한꺼번에 조용히 죽었다.** 파일을 못 읽어도 에러가 아니라
"근거를 못 찾았다"는 판정으로 나와서, `/cross-verify`가 원본 없이 통과를 낼 수 있는 상태였다.

표와 실제가 어긋났을 때 스킬이 스스로 찾는 방법:

```bash
find src -name 'my-resume.md' -not -name 'example*'    # 원본
find src -name '*_jd.md' -not -name 'example*'         # JD
```

찾은 경로가 이 표와 다르면 **표를 고치고 진행한다.** 스킬 쪽을 고치지 않는다.

## 이력서 파이프라인

| 순서 | 슬래시 커맨드 | 역할 |
|------|-------------|------|
| 0 | `/evaluate-jd` | JD vs 이력서 적합도 A-F 등급 평가 (사전 필터) — 🛑 **게이트** |
| 1 | `/draft-resume` | JD 분석 → 전략 다른 초안 3가지 생성 |
| 2 | `/verify-resume` | 원본 대비 팩트 검증 + JD 정합성 체크 |
| 2.5 | `/cross-verify` | 독립 서브 에이전트 5개로 수치 귀속과 인용 금지 재검증 — 🛑 **BLOCK 시 게이트** |
| 3 | `/review-resume` | 채용자 시각 품질 리뷰 (STAR 밀도, 표현) |
| 4 | `/refine-resume` | 모든 피드백 통합 → 마크다운 최종본 |
| 4.5 | `/final-check` | 채용자 시각 최종 검증 (JD 매칭, ATS) — 🛑 **'낮음' 시 게이트** |
| 5 | `/pdf-resume` | MD 최종본 → HTML + PDF 변환 |
| 6 | `/portfolio` | 딥다이브 포트폴리오 생성 (선택 — 포트폴리오 첨부 요구 시) |
| - | `/story-bank` | STAR+R 스토리 뱅크 생성 + 회사별 면접 준비 |
| - | `/interview-debrief` | 면접 녹취 → 시니어 면접관 시각 복기 리포트 + 회차 누적 추적 |
| - | `/dashboard` | 회사별 파이프라인 진행 현황 HTML 생성 (`/dashboard {company}`로 상세 열람) |

## 핵심 규칙

- `src/.my/my-resume.md`는 팩트 기준 — 이 파일의 수치/사실을 절대 변형하지 않는다
- 원본에 없는 숫자나 사실을 생성하지 않는다
- 각 단계 결과물은 반드시 해당 `outcome/{company}/` 하위폴더에 저장한다(회사 단위 패키지 구조)
- 단계를 건너뛰지 않는다 (draft → verify → cross-verify → review → refine → final-check → pdf 순서 준수)
- **파이프라인은 자동으로 이어진다** — 사용자가 매 단계 커맨드를 치지 않는다. 멈추는 곳은 셋뿐이다:
  ① `/evaluate-jd` 등급 판정(지원 여부는 사람이 정한다) ② `/cross-verify` **BLOCK** ③ `/final-check` **'낮음'**
  그 외에는 묻지 말고 다음 스킬을 바로 실행하고, 끝나면 각 단계에서 무엇을 바꿨는지 한 번에 보고한다
- `/cross-verify` 리포트가 없거나 BLOCK이면 `/review-resume`가 시작을 거부한다 — 수치는 맞는데 **붙은 자리가 틀린** 사고를 여기서 막는다
- JD는 `src/.my/jd/pending/`(미지원)에 두고 시작, `/pdf-resume` 완료 시 `src/.my/jd/applied/`로 자동 이동 — **이 이동을 건너뛰면 어디까지 지원했는지 파일 구조로 알 수 없게 된다** — `src/`, `outcome/` 전체는 gitignore 처리되어 있음 (개인정보 외부 노출 방지)

## 지원자 프로필

`src/.my/my-resume.md`에 작성된 이력서를 팩트 기준으로 사용한다.
파이프라인 실행 전 반드시 본인 이력서로 교체할 것.
