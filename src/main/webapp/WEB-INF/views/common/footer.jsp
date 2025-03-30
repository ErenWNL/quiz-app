</main>

<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5><i class="fas fa-brain me-2"></i>Quiz Application</h5>
                <p>Test your knowledge across multiple categories and difficulty levels.</p>
            </div>
            <div class="col-md-3">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/" class="text-white">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/quiz/categories" class="text-white">Categories</a></li>
                    <li><a href="${pageContext.request.contextPath}/quiz/progress" class="text-white">My Progress</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>Help & Support</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white">Contact Us</a></li>
                    <li><a href="#" class="text-white">FAQ</a></li>
                    <li><a href="#" class="text-white">Terms of Service</a></li>
                </ul>
            </div>
        </div>
        <hr>
        <div class="text-center">
            <p class="mb-0">&copy; <script>document.write(new Date().getFullYear())</script> Quiz Application. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript for various functionalities -->
<script>
    // Auto-close alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    });
</script>

<!-- Page-specific JavaScript -->
<c:if test="${not empty pageSpecificScript}">
    <script>
        ${pageSpecificScript}
    </script>
</c:if>
</body>
</html>