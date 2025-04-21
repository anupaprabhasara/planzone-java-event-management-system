<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create User | Planzone Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminside/assets/favicon.png" type="image/png">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-orange-50 min-h-screen flex">

<%@ include file="../partials/sidebar.jsp" %>

<main class="flex-1 p-8">
    <h1 class="text-2xl font-bold text-orange-600 mb-6">
        <i class="fa-solid fa-user-plus mr-2"></i> Create New User
    </h1>

    <form method="post" action="${pageContext.request.contextPath}/admin/user" class="bg-white w-full p-6 rounded-lg shadow-md">
        <input type="hidden" name="action" value="create">

        <!-- Form Fields -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Full Name -->
            <div>
                <label for="full_name" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                <input type="text" name="full_name" id="full_name" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
            </div>

            <!-- Email -->
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input type="email" name="email" id="email" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
            </div>

            <!-- Role -->
            <div>
                <label for="role" class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                <select name="role" id="role" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                    <option value="" disabled selected>Select Role</option>
                    <option value="Admin">Admin</option>
                    <option value="Organizer">Organizer</option>
                </select>
            </div>

            <!-- Password -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input type="password" name="password" id="password" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                <p id="passwordHelp" class="mt-1 text-sm text-red-500 hidden">Password must be at least 8 characters long.</p>
            </div>
        </div>

        <!-- Buttons -->
        <div class="flex justify-end space-x-4 mt-8">
            <a href="${pageContext.request.contextPath}/admin/user"
               class="px-4 py-2 rounded-lg border border-gray-400 text-gray-700 hover:bg-gray-100 transition">
                Cancel
            </a>
            <button type="submit" id="createBtn"
                    class="px-6 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition disabled:opacity-50 disabled:cursor-not-allowed"
                    disabled>
                Create
            </button>
        </div>
    </form>
</main>

<script>
    const passwordField = document.getElementById("password");
    const passwordHelp = document.getElementById("passwordHelp");
    const createBtn = document.getElementById("createBtn");

    passwordField.addEventListener("input", () => {
        const value = passwordField.value;
        if (value.length < 8) {
            passwordHelp.classList.remove("hidden");
            createBtn.disabled = true;
        } else {
            passwordHelp.classList.add("hidden");
            createBtn.disabled = false;
        }
    });
</script>

</body>
</html>