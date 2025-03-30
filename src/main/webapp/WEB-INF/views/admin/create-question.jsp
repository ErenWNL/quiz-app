<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="pageTitle" value="Create Question" scope="request" />
<jsp:include page="../common/header.jsp" />

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/questions">Manage Questions</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Create Question</li>
                </ol>
            </nav>
            <h1 class="h2 mb-3">
                <i class="fas fa-plus-circle me-2 text-primary"></i>Create New Question
            </h1>
        </div>
    </div>

    <div class="card border-0 shadow">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0">Question Details</h5>
        </div>
        <div class="card-body">
            <form:form action="${pageContext.request.contextPath}/admin/questions" method="post" modelAttribute="questionDto">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="categoryId" class="form-label">Category</label>
                        <form:select path="categoryId" id="categoryId" class="form-select" required="required">
                            <option value="">Select Category</option>
                            <c:forEach items="${categories}" var="category">
                                <form:option value="${category.id}">${category.name}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="categoryId" cssClass="text-danger" />
                    </div>

                    <div class="col-md-6">
                        <label for="difficulty" class="form-label">Difficulty Level</label>
                        <form:select path="difficulty" id="difficulty" class="form-select" required="required">
                            <option value="">Select Difficulty</option>
                            <c:forEach items="${difficulties}" var="difficulty">
                                <form:option value="${difficulty}">${difficulty}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="difficulty" cssClass="text-danger" />
                    </div>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">Question Content</label>
                    <form:textarea path="content" id="content" class="form-control" rows="3" required="required" />
                    <form:errors path="content" cssClass="text-danger" />
                </div>

                <div class="mb-3">
                    <label for="explanation" class="form-label">Explanation (Optional)</label>
                    <form:textarea path="explanation" id="explanation" class="form-control" rows="2" />
                    <small class="text-muted">This will be shown to users after they answer the question.</small>
                    <form:errors path="explanation" cssClass="text-danger" />
                </div>

                <hr class="my-4">

                <h5 class="mb-3">Answer Options</h5>

                <div id="options-container">
                    <div class="row mb-3 option-row">
                        <div class="col-md-10">
                            <label class="form-label">Option 1</label>
                            <input type="text" name="options[0].content" class="form-control" required />
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <div class="form-check">
                                <input class="form-check-input correct-option" type="radio" name="correctOption" value="0" id="option0" required />
                                <label class="form-check-label" for="option0">
                                    Correct Answer
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3 option-row">
                        <div class="col-md-10">
                            <label class="form-label">Option 2</label>
                            <input type="text" name="options[1].content" class="form-control" required />
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <div class="form-check">
                                <input class="form-check-input correct-option" type="radio" name="correctOption" value="1" id="option1" />
                                <label class="form-check-label" for="option1">
                                    Correct Answer
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3 option-row">
                        <div class="col-md-10">
                            <label class="form-label">Option 3</label>
                            <input type="text" name="options[2].content" class="form-control" required />
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <div class="form-check">
                                <input class="form-check-input correct-option" type="radio" name="correctOption" value="2" id="option2" />
                                <label class="form-check-label" for="option2">
                                    Correct Answer
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3 option-row">
                        <div class="col-md-10">
                            <label class="form-label">Option 4</label>
                            <input type="text" name="options[3].content" class="form-control" required />
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <div class="form-check">
                                <input class="form-check-input correct-option" type="radio" name="correctOption" value="3" id="option3" />
                                <label class="form-check-label" for="option3">
                                    Correct Answer
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <button type="button" id="addOption" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-plus me-2"></i>Add Another Option
                    </button>
                    <button type="button" id="removeOption" class="btn btn-outline-danger btn-sm ms-2" disabled>
                        <i class="fas fa-minus me-2"></i>Remove Last Option
                    </button>
                </div>

                <hr class="my-4">

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="${pageContext.request.contextPath}/admin/questions" class="btn btn-outline-secondary me-md-2">
                        <i class="fas fa-times me-2"></i>Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Save Question
                    </button>
                </div>
            </form:form>
        </div>
    </div>
</div>

<c:set var="pageSpecificScript">
    // Add hidden fields for correct option
    document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    const optionsContainer = document.getElementById('options-container');
    const addOptionBtn = document.getElementById('addOption');
    const removeOptionBtn = document.getElementById('removeOption');
    let optionCount = 4; // Start with 4 options

    // Enable/disable remove button based on option count
    function updateRemoveButton() {
    removeOptionBtn.disabled = optionCount <= 2;
    }

    // Add a new option
    addOptionBtn.addEventListener('click', function() {
    const newRow = document.createElement('div');
    newRow.className = 'row mb-3 option-row';

    newRow.innerHTML = `
    <div class="col-md-10">
        <label class="form-label">Option ${optionCount + 1}</label>
        <input type="text" name="options[${optionCount}].content" class="form-control" required />
    </div>
    <div class="col-md-2 d-flex align-items-end">
        <div class="form-check">
            <input class="form-check-input correct-option" type="radio" name="correctOption" value="${optionCount}" id="option${optionCount}" />
            <label class="form-check-label" for="option${optionCount}">
                Correct Answer
            </label>
        </div>
    </div>
    `;

    optionsContainer.appendChild(newRow);
    optionCount++;
    updateRemoveButton();
    });

    // Remove the last option
    removeOptionBtn.addEventListener('click', function() {
    if (optionCount > 2) {
    const lastOption = optionsContainer.querySelector('.option-row:last-child');
    optionsContainer.removeChild(lastOption);
    optionCount--;
    updateRemoveButton();
    }
    });

    // Before form submission, set the correct option
    form.addEventListener('submit', function(e) {
    e.preventDefault();

    // Find which option is marked as correct
    const correctOptionRadio = document.querySelector('input[name="correctOption"]:checked');
    if (!correctOptionRadio) {
    alert('Please select the correct answer!');
    return;
    }

    const correctIndex = correctOptionRadio.value;

    // Add hidden fields for marking the correct option
    for (let i = 0; i < optionCount; i++) {
    const isCorrect = i.toString() === correctIndex;
    const hiddenField = document.createElement('input');
    hiddenField.type = 'hidden';
    hiddenField.name = `options[${i}].isCorrect`;
    hiddenField.value = isCorrect;
    form.appendChild(hiddenField);
    }

    form.submit();
    });
    });
</c:set>

<jsp:include page="../common/footer.jsp" />