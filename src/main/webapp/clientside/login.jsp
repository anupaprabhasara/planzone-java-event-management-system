<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | Planzone</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/clientside/assets/favicon.png" type="image/png">
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

  <%@ include file="partials/navbar.jsp" %>

  <!-- Login Section -->
  <section class="bg-gray-50 py-20">
    <div class="container mx-auto px-4">
      <div class="max-w-md mx-auto bg-white p-8 rounded-xl shadow-lg space-y-6">
        
        <!-- Branding -->
        <div class="text-center">
          <a href="${pageContext.request.contextPath}/" class="text-3xl font-bold text-indigo-600 flex items-center justify-center space-x-2">
            <i class="fas fa-calendar-check"></i>
            <span>Planzone</span>
          </a>
          <h2 class="mt-4 text-2xl font-bold text-gray-900">Log in to your account</h2>
          <p class="mt-2 text-sm text-gray-600">
            Or
            <a href="${pageContext.request.contextPath}/signup" class="font-medium text-indigo-600 hover:text-indigo-500">
              create a new account
            </a>
          </p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
          <div class="bg-red-100 text-red-800 px-4 py-2 rounded-md text-sm text-center font-medium">
            ${error}
          </div>
        </c:if>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/login" method="POST" class="space-y-5">
          <!-- Email -->
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email address</label>
            <input id="email" name="email" type="email" required autocomplete="email"
              class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              placeholder="you@example.com">
          </div>

          <!-- Password -->
          <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <input id="password" name="password" type="password" required autocomplete="current-password"
              class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              placeholder="••••••••">
          </div>

          <!-- Options -->
          <div class="flex items-center justify-between">
            <div class="flex items-center">
              <input id="remember-me" name="remember-me" type="checkbox"
                class="h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500">
              <label for="remember-me" class="ml-2 block text-sm text-gray-700">Remember me</label>
            </div>
            <div class="text-sm">
              <a href="${pageContext.request.contextPath}/login" class="text-indigo-600 hover:text-indigo-500 font-medium">Forgot password?</a>
            </div>
          </div>

          <!-- Submit -->
          <div>
            <button type="submit"
              class="w-full flex justify-center items-center space-x-2 px-4 py-2 text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-700 rounded-lg shadow focus:outline-none focus:ring-2 focus:ring-indigo-500">
              <i class="fas fa-lock"></i>
              <span>Sign in</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </section>

  <%@ include file="partials/footer.jsp" %>

</body>
</html>