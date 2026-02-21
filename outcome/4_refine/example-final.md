# 피치페이 지원 이력서 — 최종본
생성일: 2026-01-01
기반: outcome/1_draft/example-draft-B.md (임팩트 중심형)
적용 피드백: outcome/2_verify/example-verify.md + outcome/3_review/example-review.md 전체

---

# 김개발 | Backend Engineer

kimgaebal@example.com | 010-0000-0000
Blog: https://kimgaebal.tistory.com/ | GitHub: https://github.com/example-user

---

## Summary

정산 오류 **0건 달성**, 결제 승인 응답 시간 **80% 단축(1,200ms → 240ms)**, 이중 결제 **레이스 컨디션 원천 제거** — 결제·핀테크 도메인에서 구체적인 수치로 성과를 입증해온 백엔드 엔지니어입니다. Kotlin/Spring 기반으로 결제 코어 API와 정산 자동화 시스템을 직접 설계·운영하며, 성능 병목과 동시성 문제를 데이터로 추적해 근본 원인을 해결합니다. AI 오케스트레이션을 활용한 서비스를 개발·검증·제품화까지 직접 진행한 경험을 보유하고 있습니다.

---

## 경력

### 스타트업A | Payment Core Team
**백엔드 엔지니어 | 2023.03 ~ 현재 (재직중)**

> 월 결제 처리 건수 200만 건, 월 거래액 수백억 원 규모의 간편결제 플랫폼 결제 코어 백엔드 개발

**결제 코어 시스템** (Kotlin · Spring Boot · MySQL · Redis · Kafka)

- **결제 승인 응답 시간 80% 단축**: Kafka 비동기 이벤트 아키텍처로 결제 승인·정산 파이프라인 분리, WebClient + 코루틴으로 외부 PG사 API 논블로킹 전환. 1,200ms → 240ms, TPS 3배 향상
- **정산 오류 0건 달성**: 스케줄러 + Redis 분산락 멱등 배치로 중복 실행 원천 차단, 도메인 이벤트 기반 정산 자동 트리거, Slack Webhook 불일치 실시간 감지. 월 3~5건 → 0건, 처리 시간 4시간 → 40분 (83% 단축)
- **이중 결제 0건 달성**: Redis 멱등키 TTL + 분산락으로 동시 결제 요청 직렬화, 결제 상태 머신 도입으로 잘못된 상태 전이 차단
- **결제 내역 조회 응답 65% 개선**: 커서 기반 페이지네이션으로 대용량 이력 조회 최적화 (OFFSET 방식 대비 일정한 응답 시간 보장)
- 구독 결제 지수 백오프 재시도 구현, 구독 유지율 12% 향상

**기술 리더십**
- 백엔드 팀 기술 스터디 주도 (DDD·트랜잭션·클린 코드 with TDD): 코드 리뷰 품질 향상 및 신규 입사자 온보딩 기간 단축
- RFC 기반 결제 시스템 의사결정 문서화 및 온보딩 가이드 작성

---

### 스타트업B | Platform Team
**백엔드 엔지니어 | 2022.01 ~ 2023.02 (1년 2개월)**

> 구독 서비스 플랫폼 백엔드 개발

- **구독 결제 시스템 설계**: 정기 결제 스케줄러 구축, PG사 빌링키 관리 및 자동 갱신 플로우 구현
- **API 응답 시간 60% 개선**: QueryDSL fetch join + 복합 인덱스 적용으로 N+1 문제 해결
- **배포 시간 80% 단축**: Github Actions + Docker CI/CD 자동화, 40분 → 8분
- Spring RestDocs 기반 테스트 자동 API 문서화 도입

---

## 개인 프로젝트 (AI 오케스트레이션)

### paytrack — 영수증 기반 가계부 자동화
🔗 https://github.com/example-user/paytrack

Kotlin · Spring Boot · OpenAI API · PostgreSQL · Redis · React
Claude Code · Codex · Gemini CLI

- OCR + GPT-4 파이프라인: 영수증 이미지 → 금액/카테고리 자동 구조화
- Redis TTL 기반 월별 예산 소진 알림, Slack/이메일 연동
- **AI 툴 역할 분담**: Claude Code(설계·리뷰) · Codex(구현·빌드 검증) · Gemini CLI(리서치·아이디어 확장) — 1인 개발 생산성 극대화

### splitbill — 모임 정산 자동화
🔗 https://github.com/example-user/splitbill

Java 17 · Spring Boot · MySQL · Redis · AWS · Docker

- LLM 기반 비정형 채팅 파싱 → 자동 정산 생성
- Redis 분산락으로 동시 정산 요청 race condition 제거
- Bucket4j Rate Limiting으로 악용 방지

## 기술 스택

**Language & Framework**: Kotlin, Java · Spring Boot, Spring MVC · JPA, QueryDSL
**결제/정산**: PG사 API 연동, 빌링키 관리, 멱등성 패턴, 결제 상태 머신
**Database**: MySQL, PostgreSQL · Redis (분산락, 멱등키, 캐시) · Kafka
**Infrastructure**: AWS (EC2, RDS, S3) · Docker · Github Actions
**Architecture**: DDD · 이벤트 드리븐 아키텍처 · 멱등성 패턴
