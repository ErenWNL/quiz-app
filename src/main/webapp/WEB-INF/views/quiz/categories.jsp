<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Quiz Categories" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
  <div class="row mb-4">
    <div class="col">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
          <li class="breadcrumb-item active" aria-current="page">Categories</li>
        </ol>
      </nav>
      <h1 class="h2 mb-3">
        <i class="fas fa-list me-2 text-primary"></i>Quiz Categories
      </h1>
      <p class="lead">Choose a category and difficulty level to start your quiz</p>
    </div>
  </div>

  <div class="row">
    <c:forEach items="${categories}" var="category">
      <div class="col-md-4 mb-4">
        <div class="card border-0 shadow h-100">
          <div class="card-header bg-white py-3">
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
                ${category.name}
            </h5>
          </div>
          <div class="card-body">
            <p class="card-text">${category.description}</p>

            <h6 class="mt-4 mb-3">Select Difficulty:</h6>

            <!-- Easy Level - Always accessible -->
            <a href="${pageContext.request.contextPath}/quiz/start?categoryId=${category.id}&difficulty=EASY"
               class="btn btn-success btn-block w-100 mb-3">
              <i class="fas fa-baby me-2"></i>Easy
            </a>

            <!-- Medium Level - Check if accessible -->
            <c:choose>
              <c:when test="${accessMap[category.id]['MEDIUM']}">
                <a href="${pageContext.request.contextPath}/quiz/start?categoryId=${category.id}&difficulty=MEDIUM"
                   class="btn btn-warning btn-block w-100 mb-3">
                  <i class="fas fa-user me-2"></i>Medium
                </a>
              </c:when>
              <c:otherwise>
                <button class="btn btn-warning btn-block w-100 mb-3" disabled>
                  <i class="fas fa-lock me-2"></i>Medium (Pass Easy First)
                </button>
              </c:otherwise>
            </c:choose>

            <!-- Hard Level - Check if accessible -->
            <c:choose>
              <c:when test="${accessMap[category.id]['HARD']}">
                <a href="${pageContext.request.contextPath}/quiz/start?categoryId=${category.id}&difficulty=HARD"
                   class="btn btn-danger btn-block w-100">
                  <i class="fas fa-skull me-2"></i>Hard
                </a>
              </c:when>
              <c:otherwise>
                <button class="btn btn-danger btn-block w-100" disabled>
                  <i class="fas fa-lock me-2"></i>Hard (Pass Medium First)
                </button>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<jsp:include page="../common/footer.jsp" />