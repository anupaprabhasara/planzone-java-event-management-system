<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Planzone Admin</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminside/assets/favicon.png" type="image/png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-gradient-to-tr from-orange-100 to-white min-h-screen flex items-center justify-center">

    <div class="bg-white shadow-xl rounded-2xl w-full max-w-md p-8">
        <div class="text-center mb-6">
            <h1 class="text-3xl font-extrabold text-orange-600">Planzone Admin Login</h1>
            <p class="text-gray-500 text-sm mt-1">Access restricted to Admins and Organizers</p>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/admin/login" class="space-y-5">
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">
                    Email address
                </label>
                <div class="mt-1 relative">
                    <input type="email" name="email" id="email" required
                           class="block w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500 sm:text-sm">
                    <div class="absolute left-3 top-2.5 text-gray-400">
                        <i class="fa fa-envelope"></i>
                    </div>
                </div>
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">
                    Password
                </label>
                <div class="mt-1 relative">
                    <input type="password" name="password" id="password" required
                           class="block w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500 sm:text-sm">
                    <div class="absolute left-3 top-2.5 text-gray-400">
                        <i class="fa fa-lock"></i>
                    </div>
                </div>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="bg-red-100 text-red-700 border border-red-300 p-3 rounded-md text-sm">
                    <i class="fa-solid fa-circle-exclamation mr-2"></i>${error}
                </div>
            </c:if>

            <div class="flex items-center justify-between">
                <label class="flex items-center text-sm text-gray-600">
                    <input type="checkbox" class="form-checkbox text-orange-500 mr-2"> Remember me
                </label>
                <a href="mailto:admin@planzone.com" class="text-orange-500 hover:underline text-sm">Forgot password?</a>
            </div>

            <button type="submit"
                    class="w-full py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition duration-150 font-medium">
                <i class="fa fa-sign-in-alt mr-2"></i> Sign In
            </button>
        </form>
    </div>

</body>
</html>