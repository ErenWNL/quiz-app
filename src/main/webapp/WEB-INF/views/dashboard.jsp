<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="pageTitle" value="Dashboard" scope="request" />
<jsp:include page="common/header.jsp" />

<div class="container py-4">
  <div class="row mb-4">
    <div class="col-md-8">
      <h1 class="h2 mb-3">
        <i class="fas fa-tachometer-alt me-2 text-primary"></i>Dashboard
      </h1>
      <p class="lead">Welcome back, <strong>${user.fullName}</strong>! Ready to test your knowledge today?</p>
    </div>
    <div class="col-md-4 text-md-end d-flex align-items-center justify-content-md-end">
      <a href="${pageContext.request.contextPath}/quiz/categories" class="btn btn-primary">
        <i class="fas fa-play-circle me-2"></i>Start a Quiz
      </a>
    </div>
  </div>

  <!-- Stats Cards -->
  <div class="row mb-4">
    <div class="col-md-4 mb-3">
      <div class="card border-0 bg-primary text-white shadow dashboard-stats">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <h6 class="text-uppercase mb-2">Total Quizzes</h6>
              <h2 class="mb-0">42</h2>
            </div>
            <div class="rounded-circle bg-white text-primary p-3">
              <i class="fas fa-clipboard-list fa-2x"></i>
            </div>
          </div>
        </div>
        <div class="card-footer bg-transparent border-0 text-white py-3">
          <i class="fas fa-calendar-alt me-1"></i> Last quiz: 2 days ago
        </div>
      </div>
    </div>

    <div class="col-md-4 mb-3">
      <div class="card border-0 bg-success text-white shadow dashboard-stats">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <h6 class="text-uppercase mb-2">Success Rate</h6>
              <h2 class="mb-0">78%</h2>
            </div>
            <div class="rounded-circle bg-white text-success p-3">
              <i class="fas fa-chart-pie fa-2x"></i>
            </div>
          </div>
        </div>
        <div class="card-footer bg-transparent border-0 text-white py-3">
          <i class="fas fa-arrow-up me-1"></i> 5% increase from last month
        </div>
      </div>
    </div>

    <div class="col-md-4 mb-3">
      <div class="card border-0 bg-warning text-dark shadow dashboard-stats">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <h6 class="text-uppercase mb-2">Highest Score</h6>
              <h2 class="mb-0">95%</h2>
            </div>
            <div class="rounded-circle bg-white text-warning p-3">
              <i class="fas fa-trophy fa-2x"></i>
            </div>
          </div>
        </div>
        <div class="card-footer bg-transparent border-0 text-dark py-3">
          <i class="fas fa-star me-1"></i> Java - Hard level
        </div>
      </div>
    </div>
  </div>

  <!-- Recent Activity & Categories -->
  <div class="row">
    <!-- Categories Section -->
    <div class="col-lg-6 mb-4">
      <div class="card border-0 shadow">
        <div class="card-header bg-white py-3">
          <h5 class="mb-0">
            <i class="fas fa-list me-2 text-primary"></i>Quiz Categories
          </h5>
        </div>
        <div class="card-body p-0">
          <div class="list-group list-group-flush">
            <a href="${pageContext.request.contextPath}/quiz/start?categoryId=1&difficulty=EASY" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between align-items-center">
                <div>
                  <h6 class="mb-1">
                    <i class="fab fa-python me-2 text-primary"></i>Python
                  </h6>
                  <small>Test your Python programming skills</small>
                </div>
                <span class="badge rounded-pill bg-success">Easy</span>
              </div>
            </a>
            <a href="${pageContext.request.contextPath}/quiz/start?categoryId=2&difficulty=EASY" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between align-items-center">
                <div>
                  <h6 class="mb-1">
                    <i class="fab fa-java me-2 text-danger"></i>Java
                  </h6>
                  <small>Challenge yourself with Java questions</small>
                </div>
                <span class="badge rounded-pill bg-success">Easy</span>
              </div>
            </a>
            <a href="${pageContext.request.contextPath}/quiz/start?categoryId=3&difficulty=EASY" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between align-items-center">
                <div>
                  <h6 class="mb-1">
                    <i class="fas fa-code me-2 text-success"></i>C Programming
                  </h6>
                  <small>Master the fundamentals of C</small>
                </div>
                <span class="badge rounded-pill bg-success">Easy</span>
              </div>
            </a>
          </div>
        </div>
        <div class="card-footer bg-white text-center py-3">
          <a href="${pageContext.request.contextPath}/quiz/categories" class="btn btn-outline-primary btn-sm">
            <i class="fas fa-th-list me-1"></i>View All Categories
          </a>
        </div>
      </div>
    </div>

    <!-- Recent Activity Section -->
    <div class="col-lg-6 mb-4">
      <div class="card border-0 shadow">
        <div class="card-header bg-white py-3">
          <h5 class="mb-0">
            <i class="fas fa-history me-2 text-primary"></i>Recent Activity
          </h5>
        </div>
        <div class="card-body p-0">
          <div class="list-group list-group-flush">
            <div class="list-group-item">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">Python - Easy Level</h6>
                <small>2 days ago</small>
              </div>
              <p class="mb-1">Score: 85% (Pass)</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">8/10 correct answers</small>
                <a href="${pageContext.request.contextPath}/quiz/result/1" class="btn btn-sm btn-link">View Details</a>
              </div>
            </div>
            <div class="list-group-item">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">Java - Medium Level</h6>
                <small>5 days ago</small>
              </div>
              <p class="mb-1">Score: 72% (Pass)</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">7/10 correct answers</small>
                <a href="${pageContext.request.contextPath}/quiz/result/2" class="btn btn-sm btn-link">View Details</a>
              </div>
            </div>
            <div class="list-group-item">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">C Programming - Easy Level</h6>
                <small>1 week ago</small>
              </div>
              <p class="mb-1">Score: 90% (Pass)</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">9/10 correct answers</small>
                <a href="${pageContext.request.contextPath}/quiz/result/3" class="btn btn-sm btn-link">View Details</a>
              </div>
            </div>
          </div>
        </div>
        <div class="card-footer bg-white text-center py-3">
          <a href="${pageContext.request.contextPath}/quiz/history" class="btn btn-outline-primary btn-sm">
            <i class="fas fa-clock me-1"></i>View All History
          </a>
        </div>
      </div>
    </div>
  </div>

  <!-- Progress Section -->
  <div class="row">
    <div class="col-12 mb-4">
      <div class="card border-0 shadow">
        <div class="card-header bg-white py-3">
          <h5 class="mb-0">
            <i class="fas fa-chart-line me-2 text-primary"></i>Your Progress
          </h5>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-md-4 mb-3">
              <h6 class="mb-3">Python</h6>
              <h5>
                <span class="badge bg-success">Easy: 85%</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-success" role="progressbar" style="width: 85%;" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
              <h5 class="mt-3">
                <span class="badge bg-warning text-dark">Medium: 60%</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-warning" role="progressbar" style="width: 60%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
              <h5 class="mt-3">
                <span class="badge bg-secondary">Hard: Locked</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-secondary" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
            </div>

            <div class="col-md-4 mb-3">
              <h6 class="mb-3">Java</h6>
              <h5>
                <span class="badge bg-success">Easy: 90%</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-success" role="progressbar" style="width: 90%;" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
              <h5 class="mt-3">
                <span class="badge bg-warning text-dark">Medium: 72%</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-warning" role="progressbar" style="width: 72%;" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
              <h5 class="mt-3">
                <span class="badge bg-danger">Hard: 45%</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-danger" role="progressbar" style="width: 45%;" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
            </div>

            <div class="col-md-4 mb-3">
              <h6 class="mb-3">C Programming</h6>
              <h5>
                <span class="badge bg-success">Easy: 95%</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-success" role="progressbar" style="width: 95%;" aria-valuenow="95" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
              <h5 class="mt-3">
                <span class="badge bg-warning text-dark">Medium: 68%</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-warning" role="progressbar" style="width: 68%;" aria-valuenow="68" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
              <h5 class="mt-3">
                <span class="badge bg-secondary">Hard: Locked</span>
              </h5>
              <div class="progress mb-1" style="height: 10px;">
                <div class="progress-bar bg-secondary" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
            </div>
          </div>
        </div>
        <div class="card-footer bg-white text-center py-3">
          <a href="${pageContext.request.contextPath}/quiz/progress" class="btn btn-outline-primary btn-sm">
            <i class="fas fa-chart-line me-1"></i>View Detailed Progress
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="common/footer.jsp" />