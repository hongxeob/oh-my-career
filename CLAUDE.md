# oh-my-career

JD를 분석해 맞춤 이력서를 생성하고, 면접까지 준비하는 Claude Code 기반 구직 자동화 프로젝트.

## 디렉토리 구조

```
oh-my-career/
├── src/
│   ├── my-resume.md          # 원본 이력서 (팩트 기준 — 절대 수정 금지)
│   ├── pending/{company}_jd.md   # 미지원/진행중 JD
│   └── applied/{company}_jd.md   # 지원 완료(PDF까지 생성) JD — pdf-resume 완료 시 pending에서 자동 이동
├── instruction/              # 워크플로우 추가 지침
└── outcome/
    ├── {company}/            # 회사(=JD)별 패키지 — 모든 단계 산출물이 이 안에 모임
    │   ├── 0_evaluate/       # JD 적합도 평가 리포트
    │   ├── 1_draft/          # 초안 3가지 (A/B/C 버전)
    │   ├── 2_verify/         # 팩트 검증 + JD 정합성 리포트
    │   ├── 3_review/         # 품질 리뷰 리포트
    │   ├── 4_refine/         # 마크다운 최종본
    │   ├── 5_pdf/            # HTML + PDF 제출본
    │   ├── 6_portfolio/      # 딥다이브 포트폴리오 (선택 — 첨부 요구 시)
    │   └── interview/        # 회사별 면접 준비
    └── interview/
        └── story-bank.md     # STAR+R 스토리 뱅크 (회사 공통, 최상위 유지)
```

회사 단위로 진행 상황을 체크하므로 `outcome/{company}/`가 최상위 단위다. 신규 JD는 `outcome/{company}/` 폴더를 새로 만들고 그 안에 단계별 하위폴더를 채워나간다.

## 파일 명명 규칙

```
outcome/{company}/0_evaluate/{company}-evaluate.md
outcome/{company}/1_draft/{company}-draft-{A|B|C}.md
outcome/{company}/2_verify/{company}-verify.md
outcome/{company}/3_review/{company}-review.md
outcome/{company}/4_refine/{company}-final.md
outcome/{company}/4_refine/{company}-final-check.md
outcome/{company}/5_pdf/{company}-final.html
outcome/{company}/5_pdf/{company}-final.pdf
outcome/{company}/6_portfolio/{company}-portfolio.html
outcome/{company}/6_portfolio/{company}-portfolio.pdf
outcome/{company}/interview/{company}-interview.md
outcome/interview/story-bank.md
```

예: 카카오스타일 → `outcome/kakao-style/1_draft/kakao-style-draft-A.md`, `outcome/kakao-style/2_verify/kakao-style-verify.md` ...

## 이력서 파이프라인

| 순서 | 슬래시 커맨드 | 역할 |
|------|-------------|------|
| 0 | `/evaluate-jd` | JD vs 이력서 적합도 A-F 등급 평가 (사전 필터) |
| 1 | `/draft-resume` | JD 분석 → 전략 다른 초안 3가지 생성 |
| 2 | `/verify-resume` | 원본 대비 팩트 검증 + JD 정합성 체크 |
| 3 | `/review-resume` | 채용자 시각 품질 리뷰 (STAR 밀도, 표현) |
| 4 | `/refine-resume` | 모든 피드백 통합 → 마크다운 최종본 |
| 4.5 | `/final-check` | 채용자 시각 최종 검증 (JD 매칭·ATS·서류 통과 게이트) |
| 5 | `/pdf-resume` | MD 최종본 → HTML + PDF 변환 |
| 6 | `/portfolio` | 딥다이브 포트폴리오 생성 (선택 — 포트폴리오 첨부 요구 시) |
| - | `/story-bank` | STAR+R 스토리 뱅크 생성 + 회사별 면접 준비 |
| - | `/dashboard` | 회사별 파이프라인 진행 현황 HTML 생성 (`/dashboard {company}`로 상세 열람) |

## 핵심 규칙

- `src/my-resume.md`는 팩트 기준 — 이 파일의 수치/사실을 절대 변형하지 않는다
- 원본에 없는 숫자나 사실을 생성하지 않는다
- 각 단계 결과물은 반드시 해당 `outcome/{company}/` 하위폴더에 저장한다(회사 단위 패키지 구조)
- 단계를 건너뛰지 않는다 (draft → verify → review → refine → pdf 순서 준수)
- JD는 `src/pending/`(미지원)에 두고 시작, `/pdf-resume` 완료 시 `src/applied/`로 자동 이동 — `src/`, `outcome/` 전체는 gitignore 처리되어 있음 (개인정보 외부 노출 방지)

## 지원자 프로필

`src/my-resume.md`에 작성된 이력서를 팩트 기준으로 사용한다.
파이프라인 실행 전 반드시 본인 이력서로 교체할 것.
