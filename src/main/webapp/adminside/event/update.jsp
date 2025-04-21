<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Event | Planzone Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminside/assets/favicon.png" type="image/png">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-orange-50 min-h-screen flex">

<%@ include file="../partials/sidebar.jsp" %>

<main class="flex-1 p-8">
    <h1 class="text-2xl font-bold text-orange-600 mb-6">
        <i class="fa-solid fa-calendar-pen mr-2"></i> Update Event
    </h1>

    <form method="post" action="${pageContext.request.contextPath}/admin/event" class="bg-white w-full p-6 rounded-lg shadow-md" id="eventForm">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${event.eventId}">

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Title -->
            <div>
                <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Event Title</label>
                <input type="text" name="title" id="title" value="${event.title}" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
            </div>

            <!-- Category -->
            <div>
                <label for="category_id" class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                <select name="category_id" id="category_id" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}"
                            <c:if test="${category.name == event.categoryName}">selected</c:if>>
                            ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Start Time -->
            <div>
                <label for="start_time" class="block text-sm font-medium text-gray-700 mb-1">Start Time</label>
                <input type="datetime-local" name="start_time" id="start_time"
                       value="${fn:replace(event.startTime, ' ', 'T')}" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                <p id="startTimeError" class="mt-1 text-sm text-red-500 hidden">Start time cannot be in the past.</p>
            </div>

            <!-- End Time -->
            <div>
                <label for="end_time" class="block text-sm font-medium text-gray-700 mb-1">End Time</label>
                <input type="datetime-local" name="end_time" id="end_time"
                       value="${fn:replace(event.endTime, ' ', 'T')}" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                <p id="endTimeError" class="mt-1 text-sm text-red-500 hidden">End time must be after start time.</p>
            </div>

            <!-- Venue -->
            <div>
                <label for="venue_id" class="block text-sm font-medium text-gray-700 mb-1">Venue</label>
                <select name="venue_id" id="venue_id" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">
                    <c:forEach var="venue" items="${venues}">
                        <option value="${venue.venueId}"
                            <c:if test="${venue.name == event.venueName}">selected</c:if>>
                            ${venue.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Organizer (read-only dropdown + hidden input to submit value) -->
			<div>
			    <label class="block text-sm font-medium text-gray-700 mb-1">Organizer</label>
			
			    <select disabled
			            class="w-full px-4 py-2 bg-gray-100 border border-gray-300 rounded-lg text-gray-600">
			        <c:forEach var="org" items="${organizers}">
			            <c:if test="${org.role == 'Organizer'}">
			                <option value="${org.user_id}"
			                        <c:if test="${org.full_name == event.organizerName}">selected</c:if>>
			                    ${org.full_name}
			                </option>
			            </c:if>
			        </c:forEach>
			    </select>
			
			    <!-- Hidden input to submit selected organizer_id -->
			    <c:forEach var="org" items="${organizers}">
			        <c:if test="${org.full_name == event.organizerName}">
			            <input type="hidden" name="organizer_id" value="${org.user_id}" />
			        </c:if>
			    </c:forEach>
			</div>

            <!-- Description -->
            <div class="md:col-span-2">
                <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                <textarea name="description" id="description" rows="4" required
                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-400">${event.description}</textarea>
            </div>
        </div>

        <!-- Buttons -->
        <div class="flex justify-end space-x-4 mt-8">
            <a href="${pageContext.request.contextPath}/admin/event"
               class="px-4 py-2 rounded-lg border border-gray-400 text-gray-700 hover:bg-gray-100 transition">
                Cancel
            </a>
            <button type="submit" id="updateBtn"
                    class="px-6 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition disabled:opacity-50 disabled:cursor-not-allowed">
                Update
            </button>
        </div>
    </form>
</main>

<script>
    const startInput = document.getElementById("start_time");
    const endInput = document.getElementById("end_time");
    const updateBtn = document.getElementById("updateBtn");
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

        updateBtn.disabled = !valid;
    }

    startInput.addEventListener("input", validateDateTime);
    endInput.addEventListener("input", validateDateTime);
    window.addEventListener("load", validateDateTime);
</script>

</body>
</html>