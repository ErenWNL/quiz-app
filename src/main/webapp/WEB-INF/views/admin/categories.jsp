<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="pageTitle" value="Manage Categories" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Manage Categories</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-folder me-2 text-primary"></i>Manage Categories
            </h1>
            <p class="lead">Create and manage quiz categories</p>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-5 mb-4">
            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Add New Category</h5>
                </div>
                <div class="card-body">
                    <form:form action="${pageContext.request.contextPath}/admin/categories" method="post" modelAttribute="newCategory">
                        <div class="mb-3">
                            <label for="name" class="form-label">Category Name</label>
                            <form:input path="name" type="text" class="form-control" id="name" required="required" />
                            <form:errors path="name" cssClass="text-danger" />
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <form:textarea path="description" class="form-control" id="description" rows="3" />
                            <form:errors path="description" cssClass="text-danger" />
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Add Category
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">All Categories</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Questions</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${categories}" var="category">
                                <tr>
                                    <td>${category.id}</td>
                                    <td>
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
                                    </td>
                                    <td>${category.description}</td>
                                    <td>
                                        <span class="badge bg-info">${category.questions.size()}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/categories/${category.id}/edit" class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/questions?categoryId=${category.id}" class="btn btn-sm btn-outline-info">
                                                <i class="fas fa-list"></i>
                                            </a>
                                            <form action="${pageContext.request.contextPath}/admin/categories/${category.id}/delete" method="post" class="d-inline">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button type="submit" class="btn btn-sm btn-outline-danger"
                                                        onclick="return confirm('Are you sure you want to delete this category? All associated questions will be deleted too.')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty categories}">
                                <tr>
                                    <td colspan="5" class="text-center py-4">
                                        <div class="text-muted">
                                            <i class="fas fa-info-circle me-2"></i>No categories found.
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />