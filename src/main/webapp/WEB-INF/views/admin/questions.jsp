<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle" value="Manage Questions" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-md-8">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Manage Questions</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-question-circle me-2 text-primary"></i>Manage Questions
            </h1>
            <p class="lead">Create and manage quiz questions</p>
        </div>
        <div class="col-md-4 text-md-end d-flex align-items-center justify-content-md-end mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/admin/questions/new" class="btn btn-primary">
                <i class="fas fa-plus-circle me-2"></i>Add New Question
            </a>
        </div>
    </div>

    <div class="card border-0 shadow mb-4">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0">Filter Questions</h5>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/questions" method="get" class="row g-3">
                <div class="col-md-5">
                    <label for="categoryId" class="form-label">Category</label>
                    <select name="categoryId" id="categoryId" class="form-select">
                        <option value="">All Categories</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.id}" ${selectedCategoryId == category.id ? 'selected' : ''}>
                                    ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-5">
                    <label for="difficulty" class="form-label">Difficulty</label>
                    <select name="difficulty" id="difficulty" class="form-select">
                        <option value="">All Difficulties</option>
                        <c:forEach items="${difficulties}" var="difficulty">
                            <option value="${difficulty}" ${selectedDifficulty == difficulty ? 'selected' : ''}>
                                    ${difficulty}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-filter me-2"></i>Filter
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="card border-0 shadow">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Questions List</h5>
            <span class="badge bg-info">${questionsPage.totalElements} Questions</span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Question</th>
                        <th>Category</th>
                        <th>Difficulty</th>
                        <th>Options</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${questionsPage.content}" var="question">
                        <tr>
                            <td>${question.id}</td>
                            <td>
                                <div style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        ${question.content}
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${question.category.name eq 'Python'}">
                                        <i class="fab fa-python me-2 text-primary"></i>
                                    </c:when>
                                    <c:when test="${question.category.name eq 'Java'}">
                                        <i class="fab fa-java me-2 text-danger"></i>
                                    </c:when>
                                    <c:when test="${question.category.name eq 'C'}">
                                        <i class="fas fa-code me-2 text-success"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-folder me-2 text-warning"></i>
                                    </c:otherwise>
                                </c:choose>
                                    ${question.category.name}
                            </td>
                            <td>
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${question.difficulty eq 'EASY'}">bg-success</c:when>
                                            <c:when test="${question.difficulty eq 'MEDIUM'}">bg-warning text-dark</c:when>
                                            <c:when test="${question.difficulty eq 'HARD'}">bg-danger</c:when>
                                        </c:choose>
                                    ">
                                            ${question.difficulty}
                                    </span>
                            </td>
                            <td>
                                <span class="badge bg-secondary">${fn:length(question.options)}</span>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/admin/questions/${question.id}/edit" class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="${pageContext.request.contextPath}/admin/questions/${question.id}/delete" method="post" class="d-inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-sm btn-outline-danger"
                                                onclick="return confirm('Are you sure you want to delete this question?')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty questionsPage.content}">
                        <tr>
                            <td colspan="6" class="text-center py-4">
                                <div class="text-muted">
                                    <i class="fas fa-info-circle me-2"></i>No questions found.
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/questions/new" class="btn btn-primary mt-3">
                                    <i class="fas fa-plus-circle me-2"></i>Add New Question
                                </a>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white py-3">
            <nav aria-label="Page navigation">
                <c:if test="${questionsPage.totalPages > 1}">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${questionsPage.number == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/questions?page=0&categoryId=${selectedCategoryId}&difficulty=${selectedDifficulty}">First</a>
                        </li>
                        <li class="page-item ${questionsPage.number == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/questions?page=${questionsPage.number - 1}&categoryId=${selectedCategoryId}&difficulty=${selectedDifficulty}">Previous</a>
                        </li>

                        <c:forEach begin="${Math.max(0, questionsPage.number - 2)}" end="${Math.min(questionsPage.totalPages - 1, questionsPage.number + 2)}" var="i">
                            <li class="page-item ${questionsPage.number == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/questions?page=${i}&categoryId=${selectedCategoryId}&difficulty=${selectedDifficulty}">${i + 1}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${questionsPage.number + 1 == questionsPage.totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/questions?page=${questionsPage.number + 1}&categoryId=${selectedCategoryId}&difficulty=${selectedDifficulty}">Next</a>
                        </li>
                        <li class="page-item ${questionsPage.number + 1 >= questionsPage.totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/questions?page=${questionsPage.totalPages - 1}&categoryId=${selectedCategoryId}&difficulty=${selectedDifficulty}">Last</a>
                        </li>
                    </ul>
                </c:if>

                <div class="text-center mt-3">
                    <small class="text-muted">
                        Showing ${questionsPage.numberOfElements} of ${questionsPage.totalElements} questions
                        (Page ${questionsPage.number + 1} of ${questionsPage.totalPages})
                    </small>
                </div>
            </nav>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />