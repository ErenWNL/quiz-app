<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="pageTitle" value="Admin Dashboard" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
  <div class="row mb-4">
    <div class="col">
      <h1 class="h2 mb-3">
        <i class="fas fa-cog me-2 text-primary"></i>Admin Dashboard
      </h1>
      <p class="lead">Manage users, categories, and questions</p>
    </div>
  </div>

  <div class="row">
    <div class="col-md-4 mb-4">
      <div class="card border-0 shadow h-100">
        <div class="card-body text-center p-4">
          <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mx-auto mb-4" style="width: 80px; height: 80px;">
            <i class="fas fa-users fa-2x"></i>
          </div>
          <h3 class="h4 mb-3">User Management</h3>
          <p class="card-text mb-4">View, edit, and manage user accounts and permissions.</p>
          <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">
            <i class="fas fa-users me-2"></i>Manage Users
          </a>
        </div>
      </div>
    </div>

    <div class="col-md-4 mb-4">
      <div class="card border-0 shadow h-100">
        <div class="card-body text-center p-4">
          <div class="rounded-circle bg-success text-white d-flex align-items-center justify-content-center mx-auto mb-4" style="width: 80px; height: 80px;">
            <i class="fas fa-folder fa-2x"></i>
          </div>
          <h3 class="h4 mb-3">Category Management</h3>
          <p class="card-text mb-4">Create, edit, and organize quiz categories.</p>
          <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-success">
            <i class="fas fa-folder me-2"></i>Manage Categories
          </a>
        </div>
      </div>
    </div>

    <div class="col-md-4 mb-4">
      <div class="card border-0 shadow h-100">
        <div class="card-body text-center p-4">
          <div class="rounded-circle bg-warning text-dark d-flex align-items-center justify-content-center mx-auto mb-4" style="width: 80px; height: 80px;">
            <i class="fas fa-question-circle fa-2x"></i>
          </div>
          <h3 class="h4 mb-3">Question Management</h3>
          <p class="card-text mb-4">Create, edit, and organize quiz questions across categories and difficulty levels.</p>
          <a href="${pageContext.request.contextPath}/admin/questions" class="btn btn-warning text-dark">
            <i class="fas fa-question-circle me-2"></i>Manage Questions
          </a>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-12 mb-4">
      <div class="card border-0 shadow">
        <div class="card-header bg-white py-3">
          <h5 class="mb-0">Quick Actions</h5>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-md-4 mb-3">
              <a href="${pageContext.request.contextPath}/admin/questions/new" class="btn btn-outline-primary w-100 py-3">
                <i class="fas fa-plus-circle me-2"></i>Add New Question
              </a>
            </div>
            <div class="col-md-4 mb-3">
              <a href="${pageContext.request.contextPath}" class="btn btn-outline-info w-100 py-3">
                <i class="fas fa-home me-2"></i>Return to Home
              </a>
            </div>
            <div class="col-md-4 mb-3">
              <a href="${pageContext.request.contextPath}/quiz/categories" class="btn btn-outline-success w-100 py-3">
                <i class="fas fa-play-circle me-2"></i>Take a Quiz
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

</div>

<jsp:include page="../common/footer.jsp" />