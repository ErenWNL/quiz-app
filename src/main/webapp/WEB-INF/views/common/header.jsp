<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quiz Application - ${pageTitle}</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

  <!-- Custom CSS -->
  <style>
    :root {
      --primary-color: #0d6efd;
      --secondary-color: #6c757d;
      --success-color: #198754;
      --danger-color: #dc3545;
      --warning-color: #ffc107;
      --info-color: #0dcaf0;
      --light-color: #f8f9fa;
      --dark-color: #212529;
    }

    body {
      background-color: #f5f5f5;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .navbar {
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .card {
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s;
    }

    .card:hover {
      transform: translateY(-5px);
    }

    .btn {
      border-radius: 5px;
      font-weight: 500;
    }

    .locked-card {
      opacity: 0.7;
      filter: grayscale(50%);
    }

    .difficulty-badge.easy {
      background-color: var(--success-color);
    }

    .difficulty-badge.medium {
      background-color: var(--warning-color);
      color: #333;
    }

    .difficulty-badge.hard {
      background-color: var(--danger-color);
    }

    .result-passed {
      color: var(--success-color);
      font-weight: bold;
    }

    .result-failed {
      color: var(--danger-color);
      font-weight: bold;
    }

    .quiz-timer {
      font-size: 1.5rem;
      font-weight: bold;
      color: var(--dark-color);
    }

    .correct-answer {
      background-color: rgba(25, 135, 84, 0.2);
      border-left: 4px solid var(--success-color);
    }

    .incorrect-answer {
      background-color: rgba(220, 53, 69, 0.2);
      border-left: 4px solid var(--danger-color);
    }

    .progress-table td,
    .progress-table th {
      vertical-align: middle;
    }

    .dashboard-stats {
      transition: all 0.3s;
    }

    .dashboard-stats:hover {
      transform: scale(1.05);
    }
  </style>
</head>
<body>
<header>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <i class="fas fa-brain me-2"></i>Quiz App
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <sec:authorize access="isAuthenticated()">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                <i class="fas fa-home me-1"></i> Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/quiz/categories">
                <i class="fas fa-list me-1"></i> Categories
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/quiz/progress">
                <i class="fas fa-chart-line me-1"></i> My Progress
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/quiz/history">
                <i class="fas fa-history me-1"></i> History
              </a>
            </li>
          </sec:authorize>

          <sec:authorize access="hasRole('ADMIN')">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button"
                 data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-cog me-1"></i> Admin
              </a>
              <ul class="dropdown-menu" aria-labelledby="adminDropdown">
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt me-1"></i> Admin Dashboard
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users me-1"></i> Manage Users
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories">
                    <i class="fas fa-tags me-1"></i> Manage Categories
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/questions">
                    <i class="fas fa-question-circle me-1"></i> Manage Questions
                  </a>
                </li>
              </ul>
            </li>
          </sec:authorize>
        </ul>

        <ul class="navbar-nav">
          <sec:authorize access="!isAuthenticated()">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/login">
                <i class="fas fa-sign-in-alt me-1"></i> Login
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/register">
                <i class="fas fa-user-plus me-1"></i> Register
              </a>
            </li>
          </sec:authorize>

          <sec:authorize access="isAuthenticated()">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                 data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-user-circle me-1"></i> <sec:authentication property="principal.username" />
              </a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/quiz/progress">
                    <i class="fas fa-chart-line me-1"></i> My Progress
                  </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                  <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                  </a>
                </li>
              </ul>
            </li>
          </sec:authorize>
        </ul>
      </div>
    </div>
  </nav>
</header>

<main class="container py-4">
<!-- Alert messages -->
<c:if test="${not empty successMessage}">
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <i class="fas fa-check-circle me-2"></i> ${successMessage}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</c:if>

<c:if test="${not empty errorMessage}">
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</c:if>

<c:if test="${not empty infoMessage}">
  <div class="alert alert-info alert-dismissible fade show" role="alert">
    <i class="fas fa-info-circle me-2"></i> ${infoMessage}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</c:if>