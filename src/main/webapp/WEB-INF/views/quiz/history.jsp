<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Quiz History" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Quiz History</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-history me-2 text-primary"></i>Quiz History
            </h1>
            <p class="lead">Review your past quiz attempts and track your progress</p>
        </div>
    </div>

    <div class="card border-0 shadow">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Category</th>
                        <th>Difficulty</th>
                        <th>Score</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Time Taken</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${results}" var="result">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${result.category.name eq 'Python'}">
                                        <i class="fab fa-python me-2 text-primary"></i>
                                    </c:when>
                                    <c:when test="${result.category.name eq 'Java'}">
                                        <i class="fab fa-java me-2 text-danger"></i>
                                    </c:when>
                                    <c:when test="${result.category.name eq 'C'}">
                                        <i class="fas fa-code me-2 text-success"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-folder me-2 text-warning"></i>
                                    </c:otherwise>
                                </c:choose>
                                    ${result.category.name}
                            </td>
                            <td>
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${result.difficulty eq 'EASY'}">bg-success</c:when>
                                            <c:when test="${result.difficulty eq 'MEDIUM'}">bg-warning text-dark</c:when>
                                            <c:when test="${result.difficulty eq 'HARD'}">bg-danger</c:when>
                                        </c:choose>
                                    ">
                                            ${result.difficulty}
                                    </span>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="me-2">${result.score}%</div>
                                    <div class="progress flex-grow-1" style="height: 6px;">
                                        <div class="progress-bar
                                                <c:choose>
                                                    <c:when test="${result.passed}">bg-success</c:when>
                                                    <c:otherwise>bg-danger</c:otherwise>
                                                </c:choose>
                                            "
                                             role="progressbar" style="width: ${result.score}%;"
                                             aria-valuenow="${result.score}" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${result.passed}">
                                        <span class="badge bg-success">PASSED</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">FAILED</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${result.completionTime}" pattern="MMM dd, yyyy HH:mm" />
                            </td>
                            <td>
                                <fmt:formatNumber value="${result.timeTakenSeconds / 60}" pattern="#" var="minutes" />
                                <fmt:formatNumber value="${result.timeTakenSeconds % 60}" pattern="00" var="seconds" />
                                    ${minutes}:${seconds}
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/quiz/result/${result.id}" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-eye me-1"></i>View
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty results}">
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <div class="text-muted">
                                    <i class="fas fa-info-circle me-2"></i>You haven't taken any quizzes yet.
                                </div>
                                <a href="${pageContext.request.contextPath}/quiz/categories" class="btn btn-primary mt-3">
                                    <i class="fas fa-play-circle me-2"></i>Start a Quiz
                                </a>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />