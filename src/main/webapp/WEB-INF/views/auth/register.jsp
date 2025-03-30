<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="pageTitle" value="Register" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container">
  <div class="row justify-content-center my-5">
    <div class="col-lg-6">
      <div class="card border-0 shadow-lg">
        <div class="card-body p-5">
          <div class="text-center mb-4">
            <i class="fas fa-user-plus fa-3x text-primary mb-3"></i>
            <h2 class="h3 mb-3 fw-normal">Create Your Account</h2>
          </div>

          <form:form action="${pageContext.request.contextPath}/register" method="post" modelAttribute="user">
            <div class="form-floating mb-3">
              <form:input path="username" type="text" class="form-control" id="username" placeholder="Username" required="required" />
              <label for="username">Username</label>
              <form:errors path="username" cssClass="text-danger" />
            </div>

            <div class="form-floating mb-3">
              <form:input path="email" type="email" class="form-control" id="email" placeholder="Email" required="required" />
              <label for="email">Email address</label>
              <form:errors path="email" cssClass="text-danger" />
            </div>

            <div class="form-floating mb-3">
              <form:input path="fullName" type="text" class="form-control" id="fullName" placeholder="Full Name" required="required" />
              <label for="fullName">Full Name</label>
              <form:errors path="fullName" cssClass="text-danger" />
            </div>

            <div class="form-floating mb-3">
              <form:password path="password" class="form-control" id="password" placeholder="Password" required="required" />
              <label for="password">Password</label>
              <form:errors path="password" cssClass="text-danger" />
            </div>

            <div class="form-floating mb-4">
              <form:password path="confirmPassword" class="form-control" id="confirmPassword" placeholder="Confirm Password" required="required" />
              <label for="confirmPassword">Confirm Password</label>
              <form:errors path="confirmPassword" cssClass="text-danger" />
            </div>

            <button class="w-100 btn btn-lg btn-primary mb-3" type="submit">
              <i class="fas fa-user-plus me-2"></i>Register
            </button>
          </form:form>

          <div class="text-center mt-3">
            <p class="mb-0">Already have an account? <a href="${pageContext.request.contextPath}/login">Login</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp" />