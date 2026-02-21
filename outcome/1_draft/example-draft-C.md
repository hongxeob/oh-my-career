## Version C: 도메인 전문성 중심형
**전략:** 결제·핀테크 도메인 전문가로 포지셔닝. JD 키워드(결제, 정산, 멱등성, 분산락)를 전면 배치하여 도메인 적합성 강조.

---

# 김개발 | Backend Engineer — 결제·정산 도메인 전문

kimgaebal@example.com | 010-0000-0000
Blog: https://kimgaebal.tistory.com/ | GitHub: https://github.com/example-user

---

## Summary

결제 승인부터 정산 자동화까지 **결제 도메인 전 영역을 설계·운영한 백엔드 엔지니어**입니다. Redis 분산락 기반 이중 결제 방지, Kafka 이벤트 드리븐 정산 파이프라인, 멱등성 보장 배치 처리를 직접 구현하며 **데이터 정합성과 성능을 동시에 달성**했습니다. AI 오케스트레이션 서비스를 직접 개발하며 AI를 제품으로 구현하는 역량을 보유하고 있습니다.

---

## 경력

### 스타트업A | Payment Core Team
**백엔드 엔지니어 | 2023.03 ~ 현재 (재직중)**

> 월 결제 처리 건수 200만 건, 월 거래액 수백억 원 규모 간편결제 플랫폼

**결제 코어 시스템** (Kotlin · Spring Boot · MySQL · Redis · Kafka · AWS)

**[결제 성능 최적화]**
- Kafka 비동기 이벤트 아키텍처로 결제 승인·정산 파이프라인 분리: 응답 시간 1,200ms → 240ms (80% 단축), TPS 3배 향상
- WebClient + 코루틴으로 외부 PG사 API 논블로킹 전환, HikariCP 튜닝으로 DB 커넥션 경합 해소

**[정산 자동화]**
- 도메인 이벤트 기반 정산 자동 트리거: 결제 상태 변경 시 정산 데이터 자동 생성
- Redis 분산락 기반 멱등성 보장 배치: 중복 실행 원천 차단, 정산 오류 0건 달성 (처리 시간 4시간 → 40분)
- Slack Webhook 정산 불일치 실시간 감지 알림 구축

**[데이터 정합성]**
- Redis 멱등키 TTL 관리 + 분산락으로 이중 결제 race condition 원천 제거
- 결제 상태 머신 도입: 잘못된 상태 전이 차단, 결제 정합성 100% 확보
- 구독 갱신 지수 백오프 재시도: 일시적 PG사 장애 시 자동 복구, 구독 유지율 12% 향상

**기술 리더십**
- RFC 기반 결제 시스템 설계 의사결정 문서화
- 팀 내 결제 도메인 온보딩 가이드 작성 및 기술 스터디 주도

---

### 스타트업B | Platform Team
**백엔드 엔지니어 | 2022.01 ~ 2023.02 (1년 2개월)**

> 구독 서비스 플랫폼 백엔드 개발

- 정기 결제 스케줄러 및 PG사 빌링키 자동 갱신 플로우 설계·구현
- QueryDSL fetch join + 복합 인덱스 튜닝으로 구독 조회 API 응답 60% 개선
- Github Actions + Docker CI/CD 자동화 구축 (배포 시간 40분 → 8분)

---

## 개인 프로젝트 (AI 활용)

### paytrack — 영수증 기반 가계부 자동화
🔗 https://github.com/example-user/paytrack

Kotlin · Spring Boot · OpenAI API · PostgreSQL · Redis · React

- OCR + GPT-4 파이프라인: 영수증 → 금액/카테고리 자동 구조화
- Redis TTL 기반 예산 알림 + Slack 연동
- **AI 툴 분담**: Claude Code(설계·리뷰) · Codex(구현) · Gemini CLI(리서치)

### splitbill — 모임 정산 자동화
🔗 https://github.com/example-user/splitbill

Java 17 · Spring Boot · MySQL · Redis · Docker

- LLM 채팅 파싱 + Redis 분산락 동시 정산 처리

## 기술 스택

**Language & Framework**: Kotlin, Java · Spring Boot · JPA, QueryDSL
**결제/정산**: PG사 API 연동 (토스페이먼츠/KG이니시스), 빌링키 관리, 멱등성 패턴
**Database**: MySQL, PostgreSQL · Redis (분산락, 멱등키, 캐시) · Kafka
**Infrastructure**: AWS (EC2, RDS, S3) · Docker · Github Actions
**Architecture**: DDD · 이벤트 드리븐 · 결제 상태 머신
