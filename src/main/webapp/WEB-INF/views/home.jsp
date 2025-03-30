<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="pageTitle" value="Login" scope="request" />
<jsp:include page="common/header.jsp" />

<div class="container">
  <div class="row justify-content-center my-5">
    <div class="col-lg-5">
      <div class="card border-0 shadow-lg">
        <div class="card-body p-5">
          <div class="text-center mb-4">
            <i class="fas fa-user-circle fa-3x text-primary mb-3"></i>
            <h2 class="h3 mb-3 fw-normal">Login to Your Account</h2>
          </div>

          <c:if test="${param.error != null}">
            <div class="alert alert-danger">
              <i class="fas fa-exclamation-circle me-2"></i>
              Invalid username or password.
            </div>
          </c:if>

          <c:if test="${param.logout != null}">
            <div class="alert alert-success">
              <i class="fas fa-check-circle me-2"></i>
              You have been logged out successfully.
            </div>
          </c:if>

          <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="username" name="username" placeholder="Username" required autofocus>
              <label for="username">Username</label>
            </div>

            <div class="form-floating mb-4">
              <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
              <label for="password">Password</label>
            </div>

            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" name="remember-me" id="remember-me">
              <label class="form-check-label" for="remember-me">
                Remember me
              </label>
            </div>

            <button class="w-100 btn btn-lg btn-primary mb-3" type="submit">
              <i class="fas fa-sign-in-alt me-2"></i>Login
            </button>

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          </form>

          <div class="text-center mt-3">
            <p class="mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/register">Register</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="common/footer.jsp" />