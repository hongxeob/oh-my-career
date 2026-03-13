
# 김개발 | Backend Engineer

## 연락처 & 활동 공간

| 항목 | 정보 |
|------|------|
| **Email** | kimgaebal@example.com |
| **Phone** | 010-0000-0000 |
| **Blog** | https://kimgaebal.tistory.com/ |
| **GitHub** | https://github.com/example-user |
| **LinkedIn** | https://www.linkedin.com/in/kimgaebal |

---

## 핵심 역량

> **결제·정산 도메인에서 높은 트래픽과 데이터 정합성 문제를 아키텍처 설계와 성능 최적화로 해결하는 백엔드 엔지니어**

- **성능 최적화**: 결제 처리 파이프라인 개선으로 **응답 시간 80% 단축(1,200ms → 240ms)** 달성
- **데이터 정합성**: Redis 분산락 기반 이중 결제 방지 로직 구현으로 **레이스 컨디션 0건 달성**
- **아키텍처 설계**: 모놀리식 정산 시스템을 이벤트 드리븐 아키텍처로 전환, **배포 주기 3배 단축**

---

## 소개

안녕하세요. **결제·핀테크 도메인에 강한 백엔드 엔지니어 김개발**입니다.

B2C 핀테크 서비스에서 **결제 시스템 설계 및 정산 자동화**를 담당하며 안정성과 성능을 동시에 잡는 역량을 키웠습니다.

현재는 **월 결제 처리 건수 200만 건 규모의 간편결제 플랫폼**에서 결제 코어 API 및 정산 배치 시스템을 주도적으로 개발·운영 중입니다.

---

## 기술 스택

### Backend
- **Languages**: Java, Kotlin
- **Framework**: Spring Boot, Spring MVC, Spring Data JPA
- **ORM & Query**: JPA, QueryDSL, Hibernate
- **Database**: MySQL, PostgreSQL, Redis
- **Testing**: JUnit5, Mockito
- **Build**: Gradle

### Message Queue & Event
- Kafka, AWS SQS/SNS

### Search & Caching
- Redis (캐시, 분산락, 세션)
- Caffeine Cache

### DevOps & Infrastructure
- **Cloud**: AWS (EC2, RDS, S3, Lambda)
- **CI/CD**: Github Actions
- **Containerization**: Docker
- **Monitoring**: Prometheus, Grafana, CloudWatch

### API & Integration
- RESTful API Design, OpenFeign, WebClient
- OAuth2, JWT
- PG사 결제 API 연동 (토스페이먼츠, KG이니시스 등)

---

## 경력

### 스타트업A | Payment Core Team
**백엔드 엔지니어 | 2023.03 ~ 현재 (재직중)**

> **월 결제 처리 건수 200만 건, 월 거래액 수백억 원 규모의 간편결제 플랫폼**에서 결제 코어 백엔드 개발 담당

#### 주요 성과

##### 1. 결제 처리 파이프라인 성능 개선 — **응답 시간 80% 단축**

**Situation (상황)**
- 결제 승인 API의 동기식 처리로 인해 평균 **1,200ms 응답 시간** 발생
- 트래픽 증가 시 TPS 병목으로 결제 실패율 증가

**Task (과제)**
- 결제 승인 API 응답 시간 대폭 단축
- 피크 타임 트래픽 대응력 확보

**Action (행동)**
- **Kafka 기반 비동기 이벤트 아키텍처로 전환**: 결제 승인 → 정산 데이터 생성 프로세스 분리
- **WebClient + 코루틴 도입**: 외부 PG사 API 호출 논블로킹 전환
- **Connection Pool 최적화**: HikariCP 튜닝으로 DB 커넥션 경합 해소

**Result (결과)**
- ✅ **응답 시간: 1,200ms → 240ms (80% 단축)**
- ✅ **TPS 3배 향상** (피크 타임 결제 실패율 0%대 달성)
- ✅ **정산 처리 파이프라인 독립 운영으로 장애 격리**

---

##### 2. 정산 자동화 시스템 구축 — **수작업 오류 100% 제거**

**Situation (상황)**
- 기존 수동 정산 프로세스로 월 평균 3~5건 오류 발생, 야간 수작업 필요
- 정산 불일치 발견 시 원인 추적이 어렵고 복구에 수 시간 소요

**Task (과제)**
- 정산 자동화 및 불일치 자동 감지 시스템 구축

**Action (행동)**
- **스케줄러 + Redis 분산락**: 멱등성 보장 배치 처리 구현, 중복 실행 원천 차단
- **도메인 이벤트 기반 정산 트리거**: 결제 상태 변경 시 자동 정산 데이터 생성
- **정산 불일치 자동 감지 알림**: Slack Webhook 연동, 실시간 모니터링 체계 구축

**Result (결과)**
- ✅ **정산 오류 0건 달성** (월 3~5건 → 0건)
- ✅ **담당자 야간 수작업 주 8시간 절감**
- ✅ **정산 처리 시간 4시간 → 40분 단축 (83% 개선)**

---

##### 3. 이중 결제 방지 시스템 — **데이터 정합성 100% 확보**

**Situation (상황)**
- 네트워크 타임아웃 시 클라이언트 재시도로 인한 이중 결제 발생 가능성 존재
- 분산 환경에서 동시 요청 처리 중 race condition 위험

**Task (과제)**
- 이중 결제 원천 차단 및 멱등성 보장 아키텍처 구현

**Action (행동)**
- **Redis 기반 멱등키 관리**: TTL 설정으로 동일 요청 자동 차단
- **Redis 분산락 구현**: 동시 결제 요청 직렬화로 race condition 제거
- **결제 상태 머신 도입**: 결제 생명주기 상태 전이 검증으로 잘못된 상태 전이 차단

**Result (결과)**
- ✅ **이중 결제 건수 0건 달성**
- ✅ **결제 상태 정합성 100% 확보**

---

#### 기타 주요 기여
- **구독 갱신 재시도 로직 고도화**: 결제 실패 시 지수 백오프 재시도 구현, 구독 유지율 12% 향상
- **결제 내역 조회 성능 최적화**: 커서 기반 페이지네이션 도입, 대용량 이력 조회 응답 시간 65% 개선

---

### 스타트업B | Platform Team
**백엔드 엔지니어 | 2022.01 ~ 2023.02 (1년 2개월)**

> **구독 서비스 플랫폼 백엔드 개발**

#### 주요 성과

- **구독 결제 시스템 설계 & 개발**: 정기 결제 스케줄러 구축, PG사 빌링키 관리 및 자동 갱신 플로우 구현
- **N+1 문제 해결 & 인덱스 튜닝**: QueryDSL fetch join 및 복합 인덱스 적용, API 응답 시간 평균 60% 개선
- **CI/CD 파이프라인 구축**: Github Actions + Docker 기반 자동 배포, 배포 시간 40분 → 8분 단축
- **Spring RestDocs 기반 API 문서 자동화**: 테스트 기반 API 문서화로 프론트엔드 협업 효율 향상

---

## 개인 프로젝트

### 1. paytrack — 개인 가계부 + 소비 패턴 분석 서비스

> **영수증 사진 한 장으로 지출을 자동 분류하고 소비 패턴을 분석하는 AI 기반 가계부 서비스**

🔗 [GitHub Repository](https://github.com/example-user/paytrack)

**기술 스택**: `Kotlin` `Spring Boot` `PostgreSQL` `Redis` `OpenAI API` `React` `TypeScript`

#### 핵심 내용

- **OCR + LLM 파이프라인**: 영수증 이미지 → Tesseract OCR → GPT-4 구조화 → 카테고리 자동 분류
- **예산 알림 시스템**: Redis TTL 기반 월별 예산 소진 임박 알림 (Slack/이메일 연동)
- **Spring RestDocs**: 테스트 기반 API 문서 자동화

---

### 2. splitbill — 모임 정산 자동화 서비스

> **카카오톡 대화 내역에서 지출 항목을 자동 파싱하여 더치페이 정산을 자동화하는 서비스**

🔗 [GitHub Repository](https://github.com/example-user/splitbill)

**기술 스택**: `Java 17` `Spring Boot` `MySQL` `Redis` `AWS` `Docker` `Github Actions`

#### 핵심 성과

- **LLM 기반 대화 파싱**: 비정형 채팅 텍스트에서 금액/참여자/항목 자동 추출
- **동시 정산 요청 처리**: Redis 분산락으로 동시 정산 확인/취소 요청 race condition 제거
- **Rate Limiting**: Bucket4j 처리율 제한으로 악용 방지

---

## 소프트스킬

### 문제 해결 & 데이터 기반 의사결정
- **결제 응답 지연 이슈**: APM 프로파일링으로 PG사 API 호출 병목 특정 → WebClient + 코루틴 전환으로 근본 해결
- **정산 오류 반복 발생**: 원인 추적 후 멱등성 미보장 문제 발견 → 분산락 + 도메인 이벤트 아키텍처로 재설계

### 협업 & 팀 성장
- **기술 스터디 주도**: 클린 코드 with TDD, Spring 트랜잭션, DDD 관련 팀 내 세미나 진행
- **RFC 문서화**: 결제 시스템 주요 의사결정 과정을 RFC 형식으로 기록, 온보딩 가이드 작성

### 지속적 학습
- **AI 활용**: LLM 기반 코드 리뷰 자동화 도구 도입, 코드 리뷰 시간 30% 단축
- **기술 블로그**: 결제 시스템 설계, Redis 분산락 패턴, 코루틴 비동기 처리 등 정기 포스팅

---

**마지막 수정일**: 2026년 01월 01일
**Contact**: kimgaebal@example.com | 010-0000-0000
