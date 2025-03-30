<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<c:set var="pageTitle" value="Quiz Result" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/quiz/categories">Categories</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Result</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-clipboard-check me-2 text-primary"></i>Quiz Result
            </h1>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-lg-8">
            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <c:choose>
                                <c:when test="${category.name eq 'Python'}">
                                    <i class="fab fa-python me-2 text-primary"></i>
                                </c:when>
                                <c:when test="${category.name eq 'Java'}">
                                    <i class="fab fa-java me-2 text-danger"></i>
                                </c:when>
                                <c:when test="${category.name eq 'C'}">
                                    <i class="fas fa-code me-2 text-success"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-folder me-2 text-warning"></i>
                                </c:otherwise>
                            </c:choose>
                            ${category.name} -
                            <span class="badge
                                <c:choose>
                                    <c:when test="${difficulty eq 'EASY'}">bg-success</c:when>
                                    <c:when test="${difficulty eq 'MEDIUM'}">bg-warning text-dark</c:when>
                                    <c:when test="${difficulty eq 'HARD'}">bg-danger</c:when>
                                </c:choose>
                            ">
                                ${difficulty} Level
                            </span>
                        </h5>
                        <span class="fs-5
                            <c:choose>
                                <c:when test="${result.passed}">result-passed</c:when>
                                <c:otherwise>result-failed</c:otherwise>
                            </c:choose>
                        ">
                            <c:choose>
                                <c:when test="${result.passed}">
                                    <i class="fas fa-check-circle me-1"></i>PASSED
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-times-circle me-1"></i>FAILED
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="row mb-4">
                        <div class="col-md-4 mb-3 mb-md-0">
                            <div class="d-flex flex-column align-items-center">
                                <div class="display-4 fw-bold mb-2
                                    <c:choose>
                                        <c:when test="${result.passed}">text-success</c:when>
                                        <c:otherwise>text-danger</c:otherwise>
                                    </c:choose>
                                ">
                                    ${result.score}%
                                </div>
                                <p class="text-muted mb-0">Your Score</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3 mb-md-0">
                            <div class="d-flex flex-column align-items-center">
                                <div class="display-4 fw-bold mb-2">${result.correctAnswers}/${result.totalQuestions}</div>
                                <p class="text-muted mb-0">Correct Answers</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="d-flex flex-column align-items-center">
                                <div class="display-4 fw-bold mb-2">${passingScore}%</div>
                                <p class="text-muted mb-0">Passing Score</p>
                            </div>
                        </div>
                    </div>

                    <div class="text-center py-3">
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar
                                <c:choose>
                                    <c:when test="${result.passed}">bg-success</c:when>
                                    <c:otherwise>bg-danger</c:otherwise>
                                </c:choose>
                            "
                                 role="progressbar" style="width: ${result.score}%;"
                                 aria-valuenow="${result.score}" aria-valuemin="0" aria-valuemax="100">
                                ${result.score}%
                            </div>
                        </div>
                        <div class="mt-2 text-muted">
                            <small>
                                Time Taken:
                                <fmt:formatNumber value="${result.timeTakenSeconds / 60}" pattern="#" var="minutes" />
                                <fmt:formatNumber value="${result.timeTakenSeconds % 60}" pattern="00" var="seconds" />
                                ${minutes}:${seconds}
                            </small>
                        </div>
                    </div>

                    <hr class="my-4">

                    <div class="text-center mb-4">
                        <h5>Need to improve?</h5>
                        <p class="mb-3">Here are your options:</p>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                            <a href="${pageContext.request.contextPath}/quiz/start?categoryId=${category.id}&difficulty=${difficulty}"
                               class="btn btn-outline-primary me-md-2">
                                <i class="fas fa-redo me-2"></i>Try Again
                            </a>

                            <c:if test="${result.passed && difficulty eq 'EASY'}">
                                <a href="${pageContext.request.contextPath}/quiz/start?categoryId=${category.id}&difficulty=MEDIUM"
                                   class="btn btn-warning">
                                    <i class="fas fa-arrow-up me-2"></i>Try Medium Level
                                </a>
                            </c:if>

                            <c:if test="${result.passed && difficulty eq 'MEDIUM'}">
                                <a href="${pageContext.request.contextPath}/quiz/start?categoryId=${category.id}&difficulty=HARD"
                                   class="btn btn-danger">
                                    <i class="fas fa-arrow-up me-2"></i>Try Hard Level
                                </a>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/quiz/categories" class="btn btn-outline-secondary">
                                <i class="fas fa-list me-2"></i>Other Categories
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">
                        <i class="fas fa-trophy me-2 text-warning"></i>Your Achievements
                    </h5>
                </div>
                <div class="card-body p-4">
                    <c:choose>
                        <c:when test="${result.passed}">
                            <div class="text-center mb-4">
                                <div class="display-1 text-warning">
                                    <i class="fas fa-medal"></i>
                                </div>
                                <h5 class="mt-3">Congratulations!</h5>
                                <p class="text-muted">You've passed the ${difficulty} level for ${category.name}!</p>
                            </div>

                            <c:choose>
                                <c:when test="${difficulty eq 'EASY'}">
                                    <div class="alert alert-success" role="alert">
                                        <i class="fas fa-unlock me-2"></i>
                                        <strong>Medium level unlocked!</strong> Try more challenging questions.
                                    </div>
                                </c:when>
                                <c:when test="${difficulty eq 'MEDIUM'}">
                                    <div class="alert alert-success" role="alert">
                                        <i class="fas fa-unlock me-2"></i>
                                        <strong>Hard level unlocked!</strong> Test your expertise with the toughest questions.
                                    </div>
                                </c:when>
                                <c:when test="${difficulty eq 'HARD'}">
                                    <div class="alert alert-success" role="alert">
                                        <i class="fas fa-crown me-2"></i>
                                        <strong>Master achievement unlocked!</strong> You've conquered all levels in this category!
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center mb-4">
                                <div class="display-1 text-secondary">
                                    <i class="fas fa-puzzle-piece"></i>
                                </div>
                                <h5 class="mt-3">Keep Practicing!</h5>
                                <p class="text-muted">You need ${passingScore}% to pass this level.</p>
                            </div>

                            <div class="alert alert-info" role="alert">
                                <i class="fas fa-info-circle me-2"></i>
                                <strong>Don't give up!</strong> Review the concepts and try again.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">
                        <i class="fas fa-chart-line me-2 text-primary"></i>Your Progress
                    </h5>
                </div>
                <div class="card-body p-4">
                    <h6>Category: ${category.name}</h6>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-1">
                            <span>Easy</span>
                            <span class="badge bg-success">85%</span>
                        </div>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 85%;"
                                 aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-1">
                            <span>Medium</span>
                            <span class="badge bg-warning text-dark">70%</span>
                        </div>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 70%;"
                                 aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>

                    <div>
                        <div class="d-flex justify-content-between mb-1">
                            <span>Hard</span>
                            <span class="badge bg-danger">45%</span>
                        </div>
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar bg-danger" role="progressbar" style="width: 45%;"
                                 aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-white text-center py-3">
                    <a href="${pageContext.request.contextPath}/quiz/progress" class="btn btn-outline-primary btn-sm">
                        <i class="fas fa-chart-line me-1"></i>View Detailed Progress
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />