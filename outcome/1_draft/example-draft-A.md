## Version A: 상세 서술형
**전략:** 경력의 깊이와 기술적 의사결정 과정을 상세히 기술. 안정성과 신뢰감 강조.

---

# 김개발 | Backend Engineer

kimgaebal@example.com | 010-0000-0000
Blog: https://kimgaebal.tistory.com/ | GitHub: https://github.com/example-user

---

## Summary

결제 승인 응답 시간 **80% 단축(1,200ms → 240ms)**, 정산 오류 **0건 달성**, 이중 결제 **레이스 컨디션 원천 제거** — 결제·핀테크 도메인에서 데이터 정합성과 성능을 함께 잡아온 백엔드 엔지니어입니다. Kotlin/Spring 기반으로 결제 코어 API와 정산 배치 시스템을 직접 설계·운영하며, 장애 원인을 프로파일링으로 추적해 근본 해결을 추구합니다. RFC 기반 기술 문서화와 팀 기술 스터디 주도로 함께 성장하는 개발 문화를 실천합니다.

---

## 경력

### 스타트업A | Payment Core Team
**백엔드 엔지니어 | 2023.03 ~ 현재 (재직중)**

> 월 결제 처리 건수 200만 건, 월 거래액 수백억 원 규모의 간편결제 플랫폼 핵심 백엔드 개발

**결제 코어 시스템** (Kotlin · Spring Boot · MySQL · Redis · Kafka)

- **결제 승인 응답 시간 80% 단축**: Kafka 비동기 이벤트 아키텍처로 전환, 결제 승인과 정산 데이터 생성 프로세스 분리. WebClient + 코루틴으로 외부 PG사 API 논블로킹 전환. 응답 시간 1,200ms → 240ms, TPS 3배 향상
- **정산 자동화로 수작업 오류 100% 제거**: 스케줄러 + Redis 분산락 기반 멱등성 보장 배치 처리 구현. 도메인 이벤트 기반 정산 자동 트리거, Slack 알림 연동으로 불일치 실시간 감지. 정산 오류 월 3~5건 → 0건, 처리 시간 4시간 → 40분
- **이중 결제 레이스 컨디션 원천 제거**: Redis 멱등키 TTL 관리 + 분산락으로 동시 결제 요청 직렬화. 결제 상태 머신 도입으로 잘못된 상태 전이 차단. 이중 결제 건수 0건 달성
- **결제 내역 조회 성능 최적화**: 커서 기반 페이지네이션 도입으로 대용량 이력 조회 응답 시간 65% 개선 (OFFSET 방식 대비 일정한 응답 시간 보장)
- 구독 결제 재시도 로직 지수 백오프 구현, 구독 유지율 12% 향상

**기술 리더십**
- 팀 기술 스터디 주도: 클린 코드 with TDD, Spring 트랜잭션, DDD, 결제 시스템 설계 패턴
- RFC 문서화: 결제 시스템 주요 의사결정 과정 기록, 신규 입사자 온보딩 가이드 작성

---

### 스타트업B | Platform Team
**백엔드 엔지니어 | 2022.01 ~ 2023.02 (1년 2개월)**

> 구독 서비스 플랫폼 백엔드 개발

- **구독 결제 시스템 설계**: 정기 결제 스케줄러 구축, PG사 빌링키 관리 및 자동 갱신 플로우 구현
- **쿼리 최적화**: QueryDSL fetch join 및 복합 인덱스 적용, API 응답 시간 평균 60% 개선
- **CI/CD 파이프라인 구축**: Github Actions + Docker 기반 자동 배포, 배포 시간 40분 → 8분 단축
- Spring RestDocs 기반 테스트 자동 API 문서화 도입

---

## 개인 프로젝트 (AI 활용)

### paytrack — 영수증 기반 가계부 자동화
🔗 https://github.com/example-user/paytrack

Kotlin · Spring Boot · PostgreSQL · Redis · OpenAI API · React

- OCR + LLM 파이프라인: 영수증 이미지 → Tesseract OCR → GPT-4 구조화 → 카테고리 자동 분류
- Redis TTL 기반 월별 예산 소진 알림 시스템 (Slack/이메일 연동)
- **AI 도구 활용**: Claude Code(설계·리뷰) · Codex(구현) · Gemini CLI(리서치) 역할 분담

### splitbill — 모임 정산 자동화
🔗 https://github.com/example-user/splitbill

Java 17 · Spring Boot · MySQL · Redis · AWS · Docker

- LLM 기반 채팅 텍스트 파싱으로 금액/참여자/항목 자동 추출
- Redis 분산락으로 동시 정산 요청 race condition 제거

## 기술 스택

**Language & Framework**: Kotlin, Java · Spring Boot, Spring MVC · JPA, QueryDSL
**Database**: MySQL, PostgreSQL · Redis (분산락, 캐시) · Kafka
**Infrastructure**: AWS (EC2, RDS, S3) · Docker · Github Actions
**Architecture**: DDD · 이벤트 드리븐 아키텍처 · 멱등성 패턴
