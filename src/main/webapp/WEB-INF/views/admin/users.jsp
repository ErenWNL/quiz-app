<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Manage Users" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Manage Users</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-users me-2 text-primary"></i>Manage Users
            </h1>
            <p class="lead">View and manage user accounts</p>
        </div>
    </div>

    <div class="card border-0 shadow">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0">All Users</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Full Name</th>
                        <th>Status</th>
                        <th>Roles</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${usersPage.content}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.fullName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.enabled}">
                                        <span class="badge bg-success">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Disabled</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:forEach items="${user.roles}" var="role" varStatus="loop">
                                    <span class="badge bg-info">${role.name}</span>${!loop.last ? ' ' : ''}
                                </c:forEach>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/admin/users/${user.id}" class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <form action="${pageContext.request.contextPath}/admin/users/${user.id}/toggle-status" method="post" class="d-inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-sm btn-outline-warning" title="${user.enabled ? 'Disable' : 'Enable'} User">
                                            <i class="fas ${user.enabled ? 'fa-toggle-off' : 'fa-toggle-on'}"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty usersPage.content}">
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <div class="text-muted">
                                    <i class="fas fa-info-circle me-2"></i>No users found.
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white py-3">
            <nav aria-label="Page navigation">
                <c:if test="${usersPage.totalPages > 1}">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${usersPage.number == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=0">First</a>
                        </li>
                        <li class="page-item ${usersPage.number == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${usersPage.number - 1}">Previous</a>
                        </li>

                        <c:forEach begin="${Math.max(0, usersPage.number - 2)}" end="${Math.min(usersPage.totalPages - 1, usersPage.number + 2)}" var="i">
                            <li class="page-item ${usersPage.number == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${i}">${i + 1}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${usersPage.number + 1 == usersPage.totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${usersPage.number + 1}">Next</a>
                        </li>
                        <li class="page-item ${usersPage.number + 1 >= usersPage.totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${usersPage.totalPages - 1}">Last</a>
                        </li>
                    </ul>
                </c:if>

                <div class="text-center mt-3">
                    <small class="text-muted">
                        Showing ${usersPage.numberOfElements} of ${usersPage.totalElements} users
                        (Page ${usersPage.number + 1} of ${usersPage.totalPages})
                    </small>
                </div>
            </nav>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />