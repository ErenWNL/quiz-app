<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="pageTitle" value="Edit Category" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/categories">Manage Categories</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Edit Category</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-edit me-2 text-primary"></i>Edit Category
            </h1>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card border-0 shadow">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Edit Category</h5>
                </div>
                <div class="card-body">
                    <form:form action="${pageContext.request.contextPath}/admin/categories/${category.id}" method="post" modelAttribute="category">
                        <form:hidden path="id" />

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

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary me-md-2">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Changes
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />