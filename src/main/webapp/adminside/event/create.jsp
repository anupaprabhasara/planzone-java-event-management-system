<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Event | Planzone Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminside/assets/favicon.png" type="image/png">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-orange-50 min-h-screen flex">

<%@ include file="../partials/sidebar.jsp" %>

<main class="flex-1 p-8">
    <h1 class="text-2xl font-bold text-orange-600 mb-6">
        <i class="fa-solid fa-calendar-plus mr-2"></i> Create New Event
    </h1>

    <form method="post" action="${pageContext.request.contextPath}/admin/event" class="bg-white w-full p-6 rounded-lg shadow-md" id="eventForm">
        <input type="hidden" name="action" value="create">

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Title -->
            <div>
                <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Event Title</label>
                <input type="text" name="title" id="title" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
            </div>

            <!-- Category -->
            <div>
                <label for="category_id" class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                <select name="category_id" id="category_id" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                    <option value="" disabled selected>Select Category</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}">${category.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Start Time -->
            <div>
                <label for="start_time" class="block text-sm font-medium text-gray-700 mb-1">Start Time</label>
                <input type="datetime-local" name="start_time" id="start_time" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                <p id="startTimeError" class="mt-1 text-sm text-red-500 hidden">Start time cannot be in the past.</p>
            </div>

            <!-- End Time -->
            <div>
                <label for="end_time" class="block text-sm font-medium text-gray-700 mb-1">End Time</label>
                <input type="datetime-local" name="end_time" id="end_time" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                <p id="endTimeError" class="mt-1 text-sm text-red-500 hidden">End time must be after start time.</p>
            </div>

            <!-- Venue -->
            <div>
                <label for="venue_id" class="block text-sm font-medium text-gray-700 mb-1">Venue</label>
                <select name="venue_id" id="venue_id" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                    <option value="" disabled selected>Select Venue</option>
                    <c:forEach var="venue" items="${venues}">
                        <option value="${venue.venueId}">${venue.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Organizer -->
            <input type="hidden" name="organizer_id" value="${sessionScope.user.user_id}">
            
            <!-- Organizer (auto-filled) -->
			<div>
			    <label class="block text-sm font-medium text-gray-700 mb-1">Organizer</label>
			    <input type="text" value="${sessionScope.user.full_name}" readonly
			           class="w-full px-4 py-2 bg-gray-100 border border-gray-300 rounded-lg text-gray-600 focus:outline-none focus:ring-0">
			    <input type="hidden" name="organizer_id" value="${sessionScope.user.user_id}">
			</div>

            <!-- Description -->
            <div class="md:col-span-2">
                <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                <textarea name="description" id="description" rows="4" required
                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400"></textarea>
            </div>
        </div>

        <!-- Buttons -->
        <div class="flex justify-end space-x-4 mt-8">
            <a href="${pageContext.request.contextPath}/admin/event"
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
    const startInput = document.getElementById("start_time");
    const endInput = document.getElementById("end_time");
    const createBtn = document.getElementById("createBtn");
    const startError = document.getElementById("startTimeError");
    const endError = document.getElementById("endTimeError");

    function validateDateTime() {
        const now = new Date().toISOString().slice(0, 16);
        startInput.min = now;
        endInput.min = startInput.value;

        const startVal = new Date(startInput.value);
        const endVal = new Date(endInput.value);
        const currentTime = new Date();

        let valid = true;

        if (startVal < currentTime) {
            startError.classList.remove("hidden");
            valid = false;
        } else {
            startError.classList.add("hidden");
        }

        if (endVal <= startVal) {
            endError.classList.remove("hidden");
            valid = false;
        } else {
            endError.classList.add("hidden");
        }

        createBtn.disabled = !valid;
    }

    startInput.addEventListener("change", validateDateTime);
    endInput.addEventListener("change", validateDateTime);
    window.addEventListener("load", validateDateTime);
</script>

</body>
</html>