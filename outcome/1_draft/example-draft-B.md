## Version B: 임팩트 중심형
**전략:** 모든 성과를 수치로 시작 — 정산 오류 0건·응답 80% 단축·이중 결제 0건 등 정량 임팩트를 최전면 배치

---

# 김개발 | Backend Engineer

kimgaebal@example.com | 010-0000-0000
Blog: https://kimgaebal.tistory.com/ | GitHub: https://github.com/example-user

---

## Summary

정산 오류 **0건 달성**, 결제 승인 응답 시간 **80% 단축(1,200ms → 240ms)**, 이중 결제 **레이스 컨디션 원천 제거** — 결제·핀테크 도메인에서 구체적인 수치로 성과를 입증해온 백엔드 엔지니어입니다. Kotlin/Spring 기반으로 결제 코어 API와 정산 자동화 시스템을 직접 설계·운영하며, 성능 병목과 동시성 문제를 데이터로 추적해 근본 원인을 해결합니다. AI 오케스트레이션을 활용한 서비스를 직접 설계·개발하며 AI를 실제 제품으로 구현하는 역량을 갖추고 있습니다.

---

## 경력

### 스타트업A | Payment Core Team
**백엔드 엔지니어 | 2023.03 ~ 현재 (재직중)**

> 월 결제 처리 건수 200만 건 규모의 간편결제 플랫폼 결제 코어 백엔드 개발

**결제 코어 시스템** (Kotlin · Spring Boot · MySQL · Redis · Kafka)

- **결제 승인 응답 시간 80% 단축**: Kafka 비동기 아키텍처 전환 + WebClient + 코루틴으로 외부 PG사 API 논블로킹 전환. 1,200ms → 240ms, TPS 3배 향상
- **정산 오류 0건 달성**: 스케줄러 + Redis 분산락 멱등 배치 + 도메인 이벤트 자동 트리거. 월 3~5건 → 0건, 처리 시간 4시간 → 40분 (83% 단축)
- **이중 결제 0건 달성**: Redis 멱등키 TTL + 분산락 + 결제 상태 머신으로 race condition 원천 제거
- **조회 응답 시간 65% 개선**: 커서 기반 페이지네이션으로 대용량 결제 이력 조회 최적화
- 구독 결제 지수 백오프 재시도 구현, 구독 유지율 12% 향상

**기술 리더십**
- 팀 기술 스터디 주도: 클린 코드 with TDD, Spring 트랜잭션, DDD
- RFC 기반 결제 시스템 의사결정 문서화 및 온보딩 가이드 작성

---

### 스타트업B | Platform Team
**백엔드 엔지니어 | 2022.01 ~ 2023.02 (1년 2개월)**

> 구독 서비스 플랫폼 백엔드 개발

- **API 응답 시간 60% 개선**: QueryDSL fetch join + 복합 인덱스 적용으로 N+1 문제 해결
- **배포 시간 80% 단축**: Github Actions + Docker CI/CD 자동화, 40분 → 8분
- 구독 정기 결제 스케줄러 + PG사 빌링키 자동 갱신 플로우 구현

---

## 개인 프로젝트 (AI 오케스트레이션)

### paytrack — 영수증 기반 가계부 자동화
🔗 https://github.com/example-user/paytrack

Kotlin · Spring Boot · OpenAI API · PostgreSQL · Redis
Claude Code · Codex · Gemini CLI

- OCR + LLM 파이프라인으로 영수증 → 카테고리 자동 분류
- **멀티 AI 툴 협업**: Claude Code(설계·리뷰) · Codex(구현·빌드) · Gemini CLI(리서치)

### splitbill — 모임 정산 자동화
🔗 https://github.com/example-user/splitbill

Java 17 · Spring Boot · MySQL · Redis · AWS

- LLM 기반 비정형 채팅 파싱 → 자동 정산 생성
- Redis 분산락으로 동시 정산 요청 race condition 제거

## 기술 스택

**Language & Framework**: Kotlin, Java · Spring Boot, Spring MVC · JPA, QueryDSL
**Database**: MySQL, PostgreSQL · Redis (분산락, 캐시) · Kafka
**Infrastructure**: AWS (EC2, RDS, S3) · Docker · Github Actions
**Architecture**: DDD · 이벤트 드리븐 · 멱등성 패턴
