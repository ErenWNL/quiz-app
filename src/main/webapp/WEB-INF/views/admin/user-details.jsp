<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="User Details" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
                    <li class="breadcrumb-item active" aria-current="page">User Details</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-user me-2 text-primary"></i>User Details
            </h1>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-4 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">User Information</h5>
                </div>
                <div class="card-body">
                    <div class="text-center mb-4">
                        <div class="avatar-circle mb-3">
                            <span class="avatar-initials">${fn:substring(user.fullName, 0, 1)}</span>
                        </div>
                        <h4>${user.fullName}</h4>
                        <p class="text-muted mb-0">@${user.username}</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-muted">Email</label>
                        <div class="fw-medium">${user.email}</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-muted">Status</label>
                        <div>
                            <c:choose>
                                <c:when test="${user.enabled}">
                                    <span class="badge bg-success">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">Disabled</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-muted">Roles</label>
                        <div>
                            <c:forEach items="${user.roles}" var="role" varStatus="loop">
                                <span class="badge bg-info">${role.name}</span>${!loop.last ? ' ' : ''}
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-white py-3">
                    <div class="d-grid gap-2">
                        <form action="${pageContext.request.contextPath}/admin/users/${user.id}/toggle-status" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-outline-warning w-100">
                                <i class="fas ${user.enabled ? 'fa-toggle-off' : 'fa-toggle-on'} me-2"></i>
                                ${user.enabled ? 'Disable' : 'Enable'} User
                            </button>
                        </form>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back to Users
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card border-0 shadow mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Quiz History</h5>
                </div>
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
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty user.results}">
                                <tr>
                                    <td colspan="6" class="text-center py-4">
                                        <div class="text-muted">
                                            <i class="fas fa-info-circle me-2"></i>This user hasn't taken any quizzes yet.
                                        </div>
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach items="${user.results}" var="result" begin="0" end="4">
                                <tr>
                                    <td>${result.category.name}</td>
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
                                    <td>${result.score}%</td>
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
                                        <fmt:formatDate value="${result.completionTime}" pattern="MMM dd, yyyy" />
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/quiz/result/${result.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Progress Summary</h5>
                </div>
                <div class="card-body">
                    <c:if test="${empty user.progress}">
                        <div class="text-center py-4 text-muted">
                            <i class="fas fa-info-circle me-2"></i>No progress data available for this user.
                        </div>
                    </c:if>

                    <c:if test="${not empty user.progress}">
                        <div class="row">
                            <c:forEach items="${user.progress}" var="progress">
                                <div class="col-md-4 mb-4">
                                    <h6 class="mb-2">${progress.category.name}</h6>
                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="small">Easy</span>
                                            <span class="small">${progress.easyHighestScore}%</span>
                                        </div>
                                        <div class="progress" style="height: 8px;">
                                            <div class="progress-bar bg-success" role="progressbar"
                                                 style="width: ${progress.easyHighestScore}%;"
                                                 aria-valuenow="${progress.easyHighestScore}"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="small">Medium</span>
                                            <span class="small">${progress.mediumHighestScore}%</span>
                                        </div>
                                        <div class="progress" style="height: 8px;">
                                            <div class="progress-bar bg-warning" role="progressbar"
                                                 style="width: ${progress.mediumHighestScore}%;"
                                                 aria-valuenow="${progress.mediumHighestScore}"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="small">Hard</span>
                                            <span class="small">${progress.hardHighestScore}%</span>
                                        </div>
                                        <div class="progress" style="height: 8px;">
                                            <div class="progress-bar bg-danger" role="progressbar"
                                                 style="width: ${progress.hardHighestScore}%;"
                                                 aria-valuenow="${progress.hardHighestScore}"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .avatar-circle {
        width: 100px;
        height: 100px;
        background-color: #0d6efd;
        border-radius: 50%;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 auto;
    }

    .avatar-initials {
        font-size: 48px;
        font-weight: 500;
    }
</style>

<jsp:include page="../common/footer.jsp" />