<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="${category.name} Quiz - ${difficulty} Level" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/quiz/categories">Categories</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${category.name} - ${difficulty}</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-8">
            <h1 class="h2 mb-2">
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
                ${category.name} Quiz
            </h1>
            <p class="mb-0">
                <span class="badge
                    <c:choose>
                        <c:when test="${difficulty eq 'EASY'}">bg-success</c:when>
                        <c:when test="${difficulty eq 'MEDIUM'}">bg-warning text-dark</c:when>
                        <c:when test="${difficulty eq 'HARD'}">bg-danger</c:when>
                    </c:choose>
                ">
                    ${difficulty} Level
                </span>
                <span class="ms-2 text-muted">${fn:length(quiz.questions)} Questions</span>
            </p>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <div class="quiz-timer text-center">
                        <i class="fas fa-clock me-2"></i>
                        <span id="minutes">00</span>:<span id="seconds">00</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card border-0 shadow">
        <div class="card-body p-4">
            <form id="quizForm" action="${pageContext.request.contextPath}/quiz/submit" method="post">
                <input type="hidden" name="categoryId" value="${quiz.categoryId}">
                <input type="hidden" name="difficulty" value="${quiz.difficulty}">
                <input type="hidden" name="timeTakenSeconds" id="timeTakenSeconds" value="0">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <c:forEach items="${quiz.questions}" var="question" varStatus="status">
                    <div class="mb-4 p-3 border-bottom">
                        <h5 class="mb-3">Question ${status.count}: ${question.content}</h5>

                        <c:forEach items="${question.options}" var="option">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="question_${question.id}"
                                       id="option_${option.id}" value="${option.id}" required>
                                <label class="form-check-label" for="option_${option.id}">
                                        ${option.content}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </c:forEach>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                    <a href="${pageContext.request.contextPath}/quiz/categories" class="btn btn-outline-secondary me-md-2">
                        <i class="fas fa-times me-2"></i>Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-2"></i>Submit Quiz
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Timer functionality
    let seconds = 0;
    let minutes = 0;
    let totalSeconds = 0;

    function startTimer() {
    timerId = setInterval(updateTimer, 1000);
    }

    function updateTimer() {
    totalSeconds++;
    seconds++;
    if (seconds >= 60) {
    seconds = 0;
    minutes++;
    }

    document.getElementById("seconds").textContent = padNumber(seconds);
    document.getElementById("minutes").textContent = padNumber(minutes);
    document.getElementById("timeTakenSeconds").value = totalSeconds;
    }

    function padNumber(number) {
    return (number < 10) ? "0" + number : number;
    }

    // Start the timer when the page loads
    document.addEventListener('DOMContentLoaded', function() {
    startTimer();

    // Confirm before leaving the page
    window.addEventListener('beforeunload', function(e) {
    const confirmationMessage = 'Are you sure you want to leave? Your quiz progress will be lost.';
    e.returnValue = confirmationMessage;
    return confirmationMessage;
    });

    // Remove confirmation when submitting the form
    document.getElementById('quizForm').addEventListener('submit', function() {
    window.removeEventListener('beforeunload', function() {});
    });
    });
</script>

<jsp:include page="../common/footer.jsp" />