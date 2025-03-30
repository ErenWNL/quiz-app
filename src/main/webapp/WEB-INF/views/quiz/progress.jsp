<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Progress" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">My Progress</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-chart-line me-2 text-primary"></i>My Progress
            </h1>
            <p class="lead">Track your improvement across different categories and difficulty levels</p>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Categories Overview</h5>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <c:forEach items="${categories}" var="category">
                            <a href="#category-${category.id}" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-1">
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
                                                ${category.name}
                                        </h6>
                                    </div>
                                    <c:set var="highestLevel" value="${accessMap[category.id]['HARD'] ? 'HARD' : (accessMap[category.id]['MEDIUM'] ? 'MEDIUM' : 'EASY')}" />
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${highestLevel eq 'EASY'}">bg-success</c:when>
                                            <c:when test="${highestLevel eq 'MEDIUM'}">bg-warning text-dark</c:when>
                                            <c:when test="${highestLevel eq 'HARD'}">bg-danger</c:when>
                                        </c:choose>
                                    ">
                                            ${highestLevel}
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-8 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Detailed Progress</h5>
                </div>
                <div class="card-body p-4">
                    <c:forEach items="${categories}" var="category" varStatus="catStatus">
                        <div id="category-${category.id}" class="${catStatus.index > 0 ? 'mt-5' : ''}">
                            <h4>
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
                                    ${category.name}
                            </h4>
                            <p class="text-muted">${category.description}</p>

                            <div class="table-responsive">
                                <table class="table table-bordered progress-table">
                                    <thead class="table-light">
                                    <tr>
                                        <th>Level</th>
                                        <th>Status</th>
                                        <th>Highest Score</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${difficultyLevels}" var="level">
                                        <tr>
                                            <td>
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${level eq 'EASY'}">bg-success</c:when>
                                                            <c:when test="${level eq 'MEDIUM'}">bg-warning text-dark</c:when>
                                                            <c:when test="${level eq 'HARD'}">bg-danger</c:when>
                                                        </c:choose>
                                                    ">
                                                            ${level}
                                                    </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${accessMap[category.id][level]}">
                                                        <span class="badge bg-success">Unlocked</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Locked</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="me-2">${scoresMap[category.id][level]}%</div>
                                                    <div class="progress flex-grow-1" style="height: 8px;">
                                                        <div class="progress-bar
                                                                <c:choose>
                                                                    <c:when test="${level eq 'EASY'}">bg-success</c:when>
                                                                    <c:when test="${level eq 'MEDIUM'}">bg-warning</c:when>
                                                                    <c:when test="${level eq 'HARD'}">bg-danger</c:when>
                                                                </c:choose>
                                                            "
                                                             role="progressbar" style="width: ${scoresMap[category.id][level]}%;"
                                                             aria-valuenow="${scoresMap[category.id][level]}" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${accessMap[category.id][level]}">
                                                        <a href="${pageContext.request.contextPath}/quiz/start?categoryId=${category.id}&difficulty=${level}"
                                                           class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-play-circle me-1"></i>Take Quiz
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-sm btn-outline-secondary" disabled>
                                                            <i class="fas fa-lock me-1"></i>Locked
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />