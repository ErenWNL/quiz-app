<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Access Denied" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <div class="display-1 text-danger mb-3">
                <i class="fas fa-exclamation-circle"></i>
            </div>
            <h1 class="h2 mb-3">Access Denied</h1>
            <p class="lead mb-4">Sorry, you don't have permission to access this page.</p>
            <div class="mb-5">
                <p>Please contact the administrator if you believe this is an error.</p>
            </div>
            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary me-md-2">
                    <i class="fas fa-home me-2"></i>Return to Home
                </a>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary">
                    <i class="fas fa-tachometer-alt me-2"></i>Go to Dashboard
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />