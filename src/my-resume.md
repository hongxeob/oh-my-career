
# 🚀 이홍섭 | Backend Engineer

## 📞 연락처 & 활동 공간

| 항목 | 정보 |
|------|------|
| 📧 **Email** | [hongggg66772291@gmail.com](mailto:hongggg66772291@gmail.com) |
| 📱 **Phone** | 010-6677-2291 |
| 💼 **Blog** | [https://hongseob.tistory.com/](https://hongseob.tistory.com/) |
| 🐙 **GitHub** | [https://github.com/hongxeob](https://github.com/hongxeob) |
| 🔗 **LinkedIn** | [https://www.linkedin.com/in/hongseob](https://www.linkedin.com/in/hongseob) |

---

## 💡 핵심 역량

> **대규모 트래픽과 복잡한 비즈니스 요구사항을 체계적인 아키텍처 설계와 성능 최적화로 해결하는 백엔드 엔지니어**

- **성능 최적화**: 데이터베이스 쿼리 최적화, 검색 엔진 도입으로 **응답 시간 100배 단축(4-5초 → 40-50ms)** 달성
- **아키텍처 설계**: 레거시 시스템을 DDD 기반 설계로 리아키텍처링하여 **개발 생산성 및 확장성 향상**
- **실무 협업**: 주니어 개발자로서 시니어와 협업하며 **아키텍처 의사결정에 적극 참여**, 팀 기술 스터디 주도

---

## 🎯 소개

안녕하세요. **시스템 설계와 성능 최적화에 강한 백엔드 엔지니어 이홍섭**입니다.

B2B 물류/운송 솔루션에서 **배차 최적화 및 재고 관리 시스템**을 구축하며 효율적인 시스템 설계와 문제 해결 역량을 길렀습니다.

현재는 **MAU 180만의 일본 패션 플랫폼 NUGU**에서 **검색 엔진 도입, 레거시 검색 인프라 단독 재구축, 차세대 플랫폼 아키텍처 설계** 등 핵심 프로젝트를 주도적으로 진행 중입니다.

더 나은 코드와 시스템을 만들기 위해 **지속적으로 학습하고, 동료와 함께 성장**하는 것을 즐기며, **구체적인 지표로 성과를 입증**하는 엔지니어입니다.

---

## 🔨 기술 스택

### Backend
- **Languages**: Java, Kotlin, Go
- **Framework**: Spring Boot, Spring MVC, Spring Data JPA
- **ORM & Query**: JPA, QueryDSL, Hibernate
- **Database**: MySQL, PostgreSQL, Redis, MongoDB
- **Testing**: JUnit5, Mockito
- **Build**: Gradle

### Message Queue & Event
- Kafka, RabbitMQ, AWS SNS/SQS

### Search & Caching
- OpenSearch, Elasticsearch (검색 엔진)
- Redis (캐시, 분산락)
- Caffeine Cache

### DevOps & Infrastructure
- **Cloud**: AWS (EC2, RDS, S3, Lambda)
- **CI/CD**: Github Actions
- **Containerization**: Docker
- **Web Server**: Nginx
- **Monitoring**: CloudWatch

### API & Integration
- RESTful API Design, OpenFeign, WebClient
- OAuth2, JWT
- 외부 API 통합 (Kakao Mobility, etc.)

---

## 💼 경력

### (주) 메디쿼터스 | 일본사업부 · 백엔드팀 전시/검색 개발 스쿼드
**백엔드 엔지니어 | 2025.06 ~ 현재 (재직중)**

> **MAU 180만, 월 매출 규모 수십억 원대의 일본 패션 크로스보더 커머스 플랫폼 NUGU**에서 핵심 백엔드 개발 담당
> 웹/앱 전반에서 사용자에게 노출되는 상품·큐레이션 조회 화면의 대부분 트래픽을 처리하는 **검색·전시 서버** 담당

#### 🏆 주요 성과

##### 1️⃣ NUGU 플랫폼 검색 성능 개선 (젤다 1.1) - **응답 시간 99% 단축**

**Situation (상황)**
- 기존 NUGU 플랫폼의 상품 리스트 조회는 복잡한 DB 쿼리와 JOIN으로 인해 **평균 4-5초의 느린 응답 시간** 발생
- 검색의 경우 기존 Elasticsearch에서 wildcard 남용(`*term*`)·nested/dis_max 중첩·순차 다중 검색이 복합적으로 겹쳐 추가 지연 발생
- 사용자 입력 검색어에 대해 정확도 낮은 결과 반환

**Task (과제)**
- 상품 조회 성능 대폭 개선 필요
- 검색 정확도 및 다국어 지원 강화

**Action (행동)**
- **OpenSearch 검색 엔진 도입**: DB 쿼리 기반 조회를 검색 엔진 기반 아키텍처로 전면 개편; 기존 ES wildcard 남용 구조를 형태소 분석 기반으로 전면 재설계
- **형태소 분석기 적용**: 일본어 뿐만 아니라 한국어, 영어 등 **다국어 검색 지원**
- **Score 기반 정렬**: 검색어 Score 기반 정렬 로직 적용으로 사용자 의도에 부합하는 상품 우선 노출

**Result (결과)**
- ✅ **응답 시간: 4-5초 → 40-50ms (99% 개선, 100배 향상)**
- ✅ **검색 정확도 대폭 향상**
- ✅ **다국어 검색 지원으로 글로벌 확장성 확보**
- ✅ **기존 Elasticsearch 서버 완전 제거 → 연 700-800만원 인프라 비용 절감**

---

##### 2️⃣ NUGU 2.0 차세대 플랫폼 스켈레톤 구축 (Nova 프로젝트) - **2인 체제 주도적 설계**

**Situation (상황)**
- NUGU 플랫폼의 차세대 버전(2.0) 개발 준비 필요
- 향후 대규모 팀 확장 대비 기반 구조 필요

**Task (과제)**
- 확장성 있는 프로젝트 아키텍처 설계
- 신규 개발자의 빠른 온보딩 환경 구성

**Action (행동)**
- **Ports & Adapters 패턴** 기반의 확장 가능한 프로젝트 구조 설계 (domain/infra 완전 분리)
- **도메인-인프라 계층 분리**로 의존성 최소화 및 유지보수성 향상
- **공통 모듈화 및 개발 컨벤션** 수립으로 향후 개발 생산성 기반 마련
- **상세한 기술 문서 및 온보딩 가이드** 작성

**Result (결과)**
- ✅ **확장 가능한 아키텍처 설계로 향후 팀 확장 시 빠른 개발 속도 확보**
- ✅ **신규 입사자도 문서 기반 빠른 프로젝트 이해 및 합류 지원**
- ✅ **개발 컨벤션 통일로 코드 품질 및 일관성 보장**

---

##### 3️⃣ NUGU-현대백화점 콜라보 프로젝트 - **확장 가능한 아키텍처의 가치 검증**

**Situation (상황)**
- NUGU와 현대백화점의 콜라보 프로젝트 진행
- 현대관 전용 상품 조회 및 필터링 로직 필요

**Task (과제)**
- 현대관 전용 검색/조회/필터링 기능 추가
- 기존 코드 영향 최소화하며 빠른 배포 필요

**Action (행동)**
- 젤다 1.1에서 구축한 **유연한 아키텍처 활용**
- 기존 코드 수정 없이 **새로운 비즈니스 요구사항 대응 (Strategy 패턴 적용)**
- **신속한 개발 및 배포**

**Result (결과)**
- ✅ **기존 코드 수정 없이 새로운 기능 추가로 사이드 이펙트 최소화**
- ✅ **우수한 아키텍처 설계의 실제 비즈니스 가치 검증**
- ✅ **콜라보 프로젝트 일정 내 성공적 완료**

---

##### 4️⃣ 전시팀 레거시 검색 인프라 완전 재구축 — 테크리드와 2인 설계·구축, 이후 단독 유지보수·개선 주도, 응답 시간 97% 단축

**기술 스택**: `Kotlin` `Spring Boot` `OpenSearch` `CDC`

**Situation (상황)**
- 전시팀 검색 서버가 Go + Python + Elasticsearch 레거시 구조로 파편화 운영 중
- 와일드카드 기반 검색 + 상품·스타일룩·셀러 전 타입을 단일 요청으로 일괄 조회하는 구조로 검색 응답 최대 **7초** 소요
- 색인 동기화를 pg_notify LISTEN/NOTIFY 기반 단일 Go 리스너로 처리 — 서버 재시작·다운 시 이벤트 유실, 재처리 불가, 단일 장애점(SPOF)

**Task (과제)**
- OpenSearch 기반 Kotlin 서버로 전시팀 검색 인프라 전체 재구축 (단독 주도)
- 전시/큐레이션 검색 기능 고도화

**Action (행동)**
- **6개 이상 엔티티 인덱스 전면 설계 및 마이그레이션**: 상품·셀러·카테고리·기획전(DisplayGroup)·앰배서더·스타일룩; alias 기반 무중단 인덱스 전환 (v2 인덱스 생성 → 데이터 마이그레이션 → alias cutover)
- **Debezium+Kafka 기반 Near Real-Time Indexing 파이프라인** 구축 — pg_notify 단일 리스너 대비 at-least-once 보장·offset 기반 재처리·컨슈머 그룹별 장애 격리 확보 (31개 토픽·테이블별 컨슈머 그룹 분리, 대용량 엔티티 10-partition 전략 포함)
- 와일드카드 → 형태소 분석 기반 검색 전환 + 타입별 분리 조회로 쿼리 구조 근본 개선
- 검색 품질 다수 개선: 셀러명 정확도 향상, 일본어 후리가나(読み) 검색 지원, 재고 우선 노출, 단어 경계 오검색 수정

**Result (결과)**
- ✅ **응답 시간: 최대 7초 → 20~30ms (97% 단축)**
- ✅ Go + Python + ES 레거시 완전 제거, Kotlin + OpenSearch 단일 스택 통일
- ✅ 다수 검색 품질 이슈 해소, 일본 사용자 검색 경험 개선
- ✅ **기존 Elasticsearch 서버 완전 제거 → 연 700-800만원 인프라 비용 절감**

---

##### 5️⃣ 전시 API 전면 재설계 — 한 방 API → 목적별 분리, 첫 페이지 로딩 99.5% 단축

**Situation (상황)**
- OS 전환 이전부터 전시 서버 API 대부분이 "한 방 API" 구조: 스타일룩의 경우 리스트·상세·상품·셀러(앰배서더) 데이터를 단일 응답으로 묶어 반환
- 리스트 페이지에서도 상세·연관 데이터까지 전부 불러오는 구조로 응답 사이즈 과대, 첫 리스트 페이지 로딩 최대 **12,000ms** 소요

**Task (과제)**
- OS 전환 후속 단계로, 약 10개 API 전면 재설계
- 프론트·백엔드 모두 명시적이고 재사용 가능한 API 구조로 개편

**Action (행동)**
- 스타일룩 기준: 리스트용 / 상세용 / 해당 스타일룩의 상품 / 셀러(앰배서더) API로 목적 단위 분리
- 동일 패턴으로 기존 한 방 API 약 10개 전면 재개발

**Result (결과)**
- ✅ **첫 리스트 페이지 로딩: 12,000ms → 300ms (97.5% 단축)**
- ✅ **응답 사이즈 대폭 감소** (불필요 데이터 제거)
- ✅ **FE·BE 모두 명시적·재사용 가능한 API 구조로 개선** — 프론트 개발 편의성 및 유지보수성 향상

---

##### 6️⃣ BFF 검색/전시 Fallback Cache + Circuit Breaker 구축 — nova-search 장애 시 무중단 응답

**기술 스택**: `Kotlin` `Spring Boot` `Redis` `Circuit Breaker`

**Situation (상황)**
- 검색/전시 도메인 서버 장애 발생 시 BFF가 10초 timeout까지 대기 후 에러 반환 — 사용자에게 검색/전시 화면 공백 노출
- 장애 전파 차단 로직 부재로 해당 도메인 서버 복구 전까지 전 사용자 영향

**Task (과제)**
- 검색/전시 서버 장애 시에도 마지막 성공 응답을 즉시 반환하여 사용자 영향 최소화
- timeout 대기 없이 빠른 폴백 경로 확보

**Action (행동)**
- **Write-on-success / Read-on-failure 캐싱 패턴**: BFF의 검색/전시 서비스 레이어에서 해당 도메인(전시/검색) 서버 호출 성공 시 Redis에 응답 저장, 실패 시 Redis에서 즉시 꺼내 반환
- **Circuit Breaker 적용**: SearchAdapter 메서드에 CB를 적용해 nova-search 서버 장애 시 10초 timeout 대기 없이 즉시 예외를 던져 캐시 폴백으로 연결
- **키워드 검색 예외 처리**: 무한 조합으로 캐싱 불가한 키워드 검색 API는 장애 시 빈 응답 반환으로 명시적 분기

**Result (결과)**
- ✅ **nova-search 장애 시 10초 timeout → 즉시 폴백으로 사용자 노출 영향 제거**
- ✅ 장애 전파 차단으로 검색/전시 화면 무중단 응답 보장
- ✅ CB 상태 기반 자동 복구 흐름 확보

---

#### 🔧 기타 주요 기여
- **문서 자동화 파이프라인 설계·팀 전파**: QA·기획팀의 반복적인 검색 조건 문의 해소를 위해 Claude Code Hook → `/update-search-spec` 스킬 → CI Python 스크립트 Confluence 자동 동기화 파이프라인 직접 설계; "특정 클래스 변경 시 CI가 자동 감지·동기화" 패턴을 팀 전체 문서화에 전파 → 반복 문의 구조적 해소, 팀 전체 수동 문서화 공수 제거
- **Go → Kotlin 마이그레이션**: 마이그레이션 대상을 패키지 단위로 분할하고 패키지별 CLAUDE.md·SKILL.md 가이드를 작성해 AI 분할 정복 방식으로 전환 속도 단축; Claude Code(설계·리뷰) · Codex(구현) · Gemini CLI(리서치) 역할 분담 방법론을 팀 전체에 교육·전파

- **Tempo 기반 분산 트레이싱 구축 및 관측 가능성 기반 성능 개선**: RDS+OpenSearch 혼재 API에 레이턴시 존재했으나 OTel 미비로 어느 구간이 병목인지 특정 불가 → Spring MVC tracing 필터 등록 방식 수정, suspend 엔드포인트 HTTP trace 연결, OpenSearch 조회 span을 repository AOP로 중앙화, coroutine Dispatchers.IO 경계에서도 trace context 전파 → OpenSearch/JPA 후속 호출이 같은 HTTP trace 아래 연결 → trace 데이터로 RDS 구간(200~300ms)이 병목임을 특정 → 캐시 적용으로 40~60ms (약 80% 개선)

---

### 위밋 모빌리티 | Platform Team
**백엔드 엔지니어 | 2024.04 ~ 2025.06 (1년 2개월)**

> **제주도 당일 배송 서비스 "제주오늘"과 물류 최적화 SaaS "루티(ROOUTY)"를 운영하는 플랫폼 회사**

#### 🏆 주요 성과

##### 1️⃣ 콜드체인 3PL 통합 운영 프로젝트 - **주니어 주도의 아키텍처 설계 및 성능 개선**

**기술 스택**: `Kotlin` `Spring Boot` `MySQL` `MongoDB` `JPA` `QueryDSL`

**주요 성과**:

- **아키텍처 설계 & DDD 도입**
  - 프로젝트 초기 요구사항 분석 및 DB/아키텍처 설계 주도
  - Layered Architecture → DDD 기반 설계로 전환
  - 복잡한 비즈니스 로직을 효율적으로 관리하고 유연한 API 설계 달성

- **주문 시스템 개선** ⭐ **복잡도 90% 감소**
  - Layered Architecture에서 도메인 로직이 서비스 레이어에 집중되며 1000줄 이상으로 비대해진 구조
  - 책임 분리 & 인터페이스 기반 추상화 & Strategy/Factory 패턴 적용
  - 유지보수성 및 테스트 용이성 대폭 향상

- **카카오 모빌리티 API 연동 최적화** ⭐ **API 처리 시간 46% 단축**
  - FeignClient 블로킹 I/O로 외부 API 호출이 직렬 처리되어 전체 응답이 지연되는 구조
  - FeignClient → **WebClient 전환 (논블로킹)**
  - **코루틴 기반 비동기 처리 & RateLimiter 도입**
  - 대량 API 처리 시간 평균 **46% 감소** [(자세히 보기)](https://hongseob.tistory.com/110)
  - JDBC 벌크 업데이트로 쿼리 수 **92% 감소**

- **MongoDB 기반 배차 경로 최적화** ⭐ **대용량 데이터 처리 성능 향상**
  - 대용량 경로 데이터 효율적 저장을 위해 MongoDB 도입
  - 복합 인덱스를 통한 배송일자, 센터, 차량 기준의 조회 성능 최적화

- **도메인 이벤트 기반 재고 이관 시스템** ⭐ **응답 시간 90% 단축**
  - 애그리거트 간 직접 호출 강결합이 응답 지연과 장애 전파의 원인
  - 성능 개선: **950ms → 96ms (90% 단축)**

- **재고 동시성 문제 해결**
  - 바코드 스캔 기반 입/출고에서 발생한 동시성 문제
  - **Redis 분산락 구현**으로 데이터 정합성 확보

- **분산 환경 스케줄러 동기화** ⭐ **작업 중복 실행 방지**
  - 다중 서버 환경에서 스케줄러 락 메커니즘 도입
  - 작업 중복 실행 방지 & 데이터 일관성 확보

- **대량 메일 발송 시스템 최적화** ⭐ **성능 60% 향상**
  - 코루틴 기반 비동기/병렬 처리 도입
  - 발송 시간: **인당 5초 → 일괄 4-5초로 단축**
  - 약 **60% 이상의 성능 향상** 달성

---

##### 2️⃣ 제주오늘 서비스 개선 & Node.js → Spring 마이그레이션

**기술 스택**: `Kotlin` `Spring Boot` `MySQL` `Redis` `MongoDB` `Kafka` `FCM` `RabbitMQ`

**주요 성과**:

- **관리자 & 드라이버 히스토리 페이지 개선** ⭐ **대용량 데이터 처리 성능 최적화**
  - QueryDSL을 활용한 동적 필터링 & 검색 기능
  - 커서 기반 페이지네이션으로 대용량 데이터 처리 성능 최적화

- **FCM 토큰 관리 시스템 개선** ⭐ **데이터베이스 부하 감소**
  - RDB → **Redis로 마이그레이션**
  - TTL 기반 토큰 신선도 관리 & 캐싱으로 DB 부하 감소

- **Kafka 기반 이벤트 시스템 구축** ⭐ **멱등성 보장 & 시스템 안정성 향상**
  - 배송 상태 변경에 따른 실시간 알림 발송 & 데이터 관리
  - **Envelope 패턴** 기반 표준화된 메시지 처리
  - 독립적인 예외 처리 체계로 시스템 안정성 극대화

- **Node.js → Spring 마이그레이션** ⭐ **아키텍처 개선 & 팀 역량 강화**
  - Koa.js 기반 서비스를 **Kotlin + Spring 기반 MSA로 마이그레이션**
  - 시스템 아키텍처 개선 & 대규모 리팩토링 수행
  - 백엔드 팀의 기술 스택 통일

---

#### 📚 기술 리더십
- **백엔드 팀 기술 스터디 주도**: 클린 코드 with TDD, Spring/JPA 지식 공유
- **기술 이슈 정리 및 공유**: Node.js 개발자들을 위한 Spring, JPA, 트랜잭션, DDD 관련 컨텐츠 작성 [(자세히 보기)](https://github.com/hongxeob/develop-issues)

---

## 👷🏽 개인 프로젝트

### 1. cardra — AI 카드뉴스 생성 서비스

> **키워드 입력만으로 트렌드 이슈를 카드뉴스로 자동 생성하는 AI 서비스. 단순 API 호출이 아닌 AI 모델·어댑터·폴백·잡 실행을 조합한 오케스트레이션 구조.**

🔗 [GitHub Repository](https://github.com/hongxeob/cardra)

**기술 스택**: `Kotlin` `Spring Boot` `OpenAI API` `Gemini API` `PostgreSQL` `React` `TypeScript`

#### 🎯 핵심 내용

- **멀티 에이전트 오케스트레이션 설계**: OpenAI/Gemini 라우팅 + 폴백 체인으로 AI 공급자 장애 시 자동 전환
- **quick/deep 모드 분기**: 카드 생성 및 리서치 오케스트레이션 파이프라인 분기로 품질·속도 최적화
- **비동기 잡 오케스트레이션**: 리서치 작업 생성/상태/결과/취소 API + running future 정리
- **AgentAdapter 추상화**: AI 공급자 교체 가능한 확장 구조 설계
- **AI 툴 역할 분담**: Codex(멀티 파일 구현·빌드 검증) · Claude Code(설계·리스크 리뷰) · Gemini CLI(리서치·아이디어 확장) — 툴별 적합 역할 명세화 후 협업 주도

---

### 2. solo-boss — 1인 사업자용 AI CRM

> **카카오톡 상담 입력 기반 AI CRM. "이번 주 매출을 높이려면 누구에게 연락해야 하는가"를 AI가 제시.**

🔗 [GitHub Repository](https://github.com/hongxeob/solo-boss)

**기술 스택**: `Kotlin` `Spring Boot 3.4` `Spring AI` `PostgreSQL(pgvector)` `Flyway` `Next.js 14`

#### 🎯 핵심 내용

- **AI 파이프라인 설계**: webhook 수신 → 멱등 처리 → LLM 구조화 → confidence scoring → HITL(사람 개입) 분기 → 팔로업/리마인드/주간 코칭 리포트
- **문서 주도 AI 개발 (Vibe Coding × Agent Orchestration)**: agent.md · skills.md 등 에이전트 역할 명세 기반으로 UX 시나리오 → 이벤트/API 계약 → OpenAPI → 구현 프롬프트 사이클 운영
- **문서 오케스트레이션**: UX 시나리오 → API/이벤트 명세 → OpenAPI 계약 고정 → 백엔드 구현 프롬프트 생성

---

### 3. oh-my-career — Claude Code 기반 맞춤 이력서 자동화 파이프라인

> **JD 분석부터 PDF 제출본까지, Claude Code 슬래시 커맨드 기반 5단계 이력서 자동화 파이프라인**

🔗 [GitHub Repository](https://github.com/hongxeob/oh-my-career)

**기술 스택**: `Claude Code` `Claude API` `Bash` `Markdown` `HTML/CSS`

#### 🎯 핵심 내용

- **5단계 파이프라인 설계**: draft(전략적 초안 3종) → verify(팩트·JD 정합성 검증) → review(채용자 시각 품질 리뷰) → refine(피드백 통합 최종본) → pdf(HTML·PDF 변환) 전 과정 자동화
- **AI 에이전트 워크플로우 설계**: 슬래시 커맨드 기반 단계별 에이전트 독립 실행, 팩트 기준(원본 이력서) 고정 + JD 정합성 검증으로 AI 할루시네이션 방지 구조 구축
- **Skills 기반 재사용 아키텍처**: 회사별 JD만 교체하면 동일 파이프라인 반복 실행 가능한 모듈형 워크플로우 — 각 단계를 독립 Skill로 캡슐화
- **검증 주도 AI 개발**: verify 단계에서 원본 이력서와의 팩트 대조 + JD 키워드 정합성 리포트 자동 생성으로 신뢰성 확보

---

### 4. 모띠클 (Motticle) - 아티클 큐레이션 & 공유 플랫폼

> **파편화된 다양한 타입의 아티클을 태그 기반으로 관리하고 공유하는 서비스**

🔗 [GitHub Repository](https://github.com/hongxeob/motticle)
📅 **2023.12 ~ 2024.03** (개인 프로젝트)

**기술 스택**: `Java 17` `Spring Boot` `MySQL` `Redis` `JPA` `QueryDSL` `AWS` `Docker` `Github Actions`

#### 🎯 핵심 기능 & 성과

- **API 설계 & 문서화** ⭐ **테스트 기반 API 문서화**
  - Notion을 이용한 API 명세 작성
  - Spring RestDocs로 테스트 기반 자동 문서화

- **테스트 기반 개발** ⭐ **견고한 코드 품질**
  - 가성비 있는 단위 테스트로 코드 품질 향상

- **비동기 데이터 처리** ⭐ **크롤링 성능 85% 개선**
  - HTML 메타 데이터 크롤링: **8.06s → 1.25s (85% 개선)**
  - Stream, parallelStream, CompletableFuture 단계적 활용

- **로컬 캐시 Caffeine 도입** ⭐ **최종 성능 95% 개선**
  - 크롤링 지연 시간: **8.06s → 397ms (95.08% 개선)** [(자세히 보기)](https://hongseob.tistory.com/96)

- **데이터베이스 인덱싱** ⭐ **인증 성능 70% 향상**
  - email 컬럼 인덱싱으로 Index Only Scan 유도
  - 성능 개선: **평균 80ms → 20-30ms (70% 개선)**

- **Rate Limiting** ⭐ **서버 보호**
  - Bucket4j를 활용한 처리율 제한으로 서버 부하 방지

- **실시간 알림 시스템** ⭐ **확장 가능한 아키텍처**
  - Redis Pub/Sub 기반 SSE 실시간 알림
  - Scale Out 상황을 고려한 설계

- **비동기 이벤트 & 트랜잭션 관리** ⭐ **시스템 안정성 극대화**
  - 비동기 이벤트로 결합도 감소
  - 트랜잭션 전파 레벨 설정으로 알림 실패 시 메인 로직 보호

- **CI/CD 파이프라인** ⭐ **무중단 배포**
  - AWS, Docker, Github Actions 활용 Blue/Green 배포 자동화

- **Frontend 구현** ⭐ **서비스화 완성**
  - HTML, CSS, JS를 활용한 화면 구현

- **OAuth2 소셜 로그인** ⭐ **사용자 편의성**
  - 카카오톡 소셜 로그인 구현

---

### 5. TimeGuard Alert - 네이버 예약 취소 알리미

> **네이버 예약 시스템에서 취소 가능한 예약을 자동으로 감지하여 알려주는 서비스**

🔗 [GitHub Repository](https://github.com/hongxeob/TimeGuard_Alert)
📅 **2023.08** (개인 프로젝트 - 해커톤)

**기술 스택**: `Java 17` `Spring Boot` `OpenFeign` `TelegramBots`

#### 🎯 핵심 성과

- **단기간 서비스 개발**: 24시간 Due Date를 가진 자체 해커톤으로 MVP 완성

- **외부 API 분석 & 연동**: FeignClient를 이용하여 네이버 예약 API 응답 분석 및 예약 가능 여부 판단

- **Telegram Bot 통합**: CLI가 아닌 사용자 친화적 Telegram 인터페이스 구현

- **스케줄러 기반 자동화**: 주기적 자동 확인으로 사용자 수동 조작 불필요

---

## 🌟 소프트스킬

### 문제 해결 & 이성적 판단
- **메디쿼터스 검색 성능 개선**: 느린 DB 쿼리 + 기존 ES wildcard 남용 문제를 **다양한 해결 방안 검토 후 OpenSearch 도입·재설계**로 대폭 성능 개선
- **전시팀 검색 응답 지연 (최대 7초)**: 와일드카드 기반 전 타입 일괄 조회를 근본 원인으로 파악 → OpenSearch 재구축 + 형태소 분석·타입별 분리 조회 설계로 **97% 단축 (7초 → 20~30ms)**
- **카카오 모빌리티 API 병목**: FeignClient의 블로킹 I/O 문제를 **WebClient + 코루틴 기반 비동기 처리**로 해결하여 46% 성능 향상

### 협업 & 팀 성장 주도
- **메디쿼터스**: 시니어 개발자 1명과 2인 체제로 **핵심 프로젝트 주도** (검색 엔진 도입, 차세대 플랫폼 아키텍처 설계)
- **위밋 모빌리티**: 백엔드 팀 **기술 스터디 주도** (클린 코드, Spring/JPA, 트랜잭션, DDD)
- **기술 문서 작성**: Node.js 팀원들을 위해 **Spring/JPA 관련 기술 이슈 정리 및 공유** [(자세히 보기)](https://github.com/hongxeob/develop-issues)

### 신속한 실행력
- **Nova 프로젝트**: 차세대 플랫폼 스켈레톤을 **신속하게 설계 & 구현** (2인 체제, 상세한 기술 문서 작성)
- **현대백화점 콜라보**: 우수한 아키텍처의 확장성을 활용하여 **기존 코드 수정 없이 신기능 추가**

### 지속적 학습 & 성장
- **AI 활용 능력**: Go → Kotlin 마이그레이션 시 **AI를 활용한 효율적 프롬프트 작성** 및 팀 AI 교육 진행
- **블로그**: 성능 최적화, 비동기 처리, 캐싱 등 **학습한 내용을 정기적으로 정리** [(자세히 보기)](https://hongseob.tistory.com/)

---

## 📜 교육

- **프로그래머스 백엔드 데브코스** 4기 수료

---

## 🎓 기술 블로그 & 저장소

| 항목 | 링크 |
|------|------|
| **개인 블로그** | [https://hongseob.tistory.com/](https://hongseob.tistory.com/) |
| **GitHub** | [https://github.com/hongxeob](https://github.com/hongxeob) |
| **기술 이슈 정리** | [https://github.com/hongxeob/develop-issues](https://github.com/hongxeob/develop-issues) |

---

## ✨ 마지막으로

> **"좋은 설계는 결과로 증명된다"**

저는 단순히 기능을 구현하는 것을 넘어, **시스템 설계와 성능 최적화로 비즈니스 가치를 창출**하는 백엔드 엔지니어입니다.

메디쿼터스에서의 **검색 성능 99% 개선, 차세대 플랫폼 아키텍처 설계**, 위밋 모빌리티에서의 **다양한 성능 최적화 및 기술 리더십**을 통해 이를 증명했습니다.

앞으로도 **더 좋은 코드, 더 나은 시스템**을 만들기 위해 지속적으로 학습하고, 함께 성장하고 싶습니다.

---

**마지막 수정일**: 2026년 2월 21일
**Contact**: hongggg66772291@gmail.com | 010-6677-2291
