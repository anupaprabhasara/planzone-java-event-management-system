<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Home | Planzone</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/clientside/assets/favicon.png"
	type="image/png">
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

	<!-- Dynamic Navbar -->
	<c:choose>
		<c:when test="${isLoggedIn}">
			<%@ include file="partials/navbarsession.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="partials/navbar.jsp"%>
		</c:otherwise>
	</c:choose>

	<!-- Main Content -->
	<section
		class="bg-gradient-to-b from-indigo-50 to-white py-24 text-center">
		<div class="container mx-auto px-4">
			<h1 class="text-5xl font-bold text-indigo-900 mb-6 leading-tight">Discover
				Events That Inspire</h1>
			<p class="text-xl text-gray-600 max-w-2xl mx-auto mb-8">Join,
				host, and explore events across different interests — all in one
				platform.</p>
			<div class="flex flex-col md:flex-row justify-center gap-4">
				<a href="${pageContext.request.contextPath}/events"
					class="bg-indigo-600 text-white px-8 py-3 rounded-lg hover:bg-indigo-700 transition transform hover:-translate-y-1 shadow">
					<i class="fas fa-search mr-2"></i> Find Events
				</a> <a href="#"
					class="border-2 border-indigo-600 text-indigo-600 px-8 py-3 rounded-lg hover:bg-indigo-50 transition transform hover:-translate-y-1 shadow">
					<i class="fas fa-user mr-2"></i> Became an Organizer
				</a>
			</div>
		</div>
	</section>

	<section class="py-20 bg-gray-50">
		<div class="container mx-auto px-4">
			<div class="flex justify-between items-center mb-8">
				<h2 class="text-3xl font-bold text-gray-900">Featured Events</h2>
				<a href="${pageContext.request.contextPath}/events"
					class="text-indigo-600 hover:text-indigo-800 flex items-center font-medium">
					View All Events <i class="fas fa-arrow-right ml-2"></i>
				</a>
			</div>

			<!-- Optional Registration Alert Message -->
			<c:if test="${not empty registrationMessage}">
				<div
					class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mx-auto max-w-xl mb-8">
					${registrationMessage}</div>
			</c:if>

			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
				<c:forEach var="event" items="${events}">
					<div
						class="bg-white border border-gray-200 rounded-xl shadow-sm hover:shadow-lg transition-all duration-300">
						<div class="px-6 py-5">
							<div class="flex items-center justify-between mb-3">
								<span
									class="inline-block text-xs font-semibold bg-indigo-100 text-indigo-800 px-3 py-1 rounded-full">
									${event.categoryName} </span> <span
									class="inline-block text-xs font-semibold bg-red-100 text-red-600 px-3 py-1 rounded-full">
									Featured </span>
							</div>

							<h3 class="text-xl font-bold text-gray-900 mb-2">${event.title}</h3>
							<p class="text-sm text-gray-600 mb-4">${event.description}</p>

							<div class="space-y-2 text-sm text-gray-700">
								<div class="flex items-start">
									<i class="far fa-calendar-alt text-indigo-600 mr-2 mt-1"></i> <span><strong>When:</strong>
										${event.startTime} – ${event.endTime}</span>
								</div>
								<div class="flex items-start">
									<i class="fas fa-map-marker-alt text-indigo-600 mr-2 mt-1"></i>
									<span><strong>Where:</strong> ${event.venueName}</span>
								</div>
								<div class="flex items-start">
									<i class="fas fa-user text-indigo-600 mr-2 mt-1"></i> <span><strong>Organizer:</strong>
										${event.organizerName}</span>
								</div>
							</div>

							<div class="mt-6 text-center">
								<form method="post"
									action="${pageContext.request.contextPath}/register"
									onsubmit="return confirmRegistration()">
									<input type="hidden" name="eventId" value="${event.eventId}">
									<button type="submit"
										class="w-full bg-indigo-600 text-white py-2 rounded-lg hover:bg-indigo-700 transition">
										Register Now</button>
								</form>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<section class="py-16">
		<div class="container mx-auto px-4">
			<h2 class="text-3xl font-bold text-center mb-12">How It Works</h2>
			<div class="grid grid-cols-1 md:grid-cols-4 gap-8 text-center">
				<div>
					<div
						class="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mx-auto mb-4">
						<i class="fas fa-search text-2xl text-indigo-600"></i>
					</div>
					<h3 class="text-xl font-semibold mb-2">Find Events</h3>
					<p class="text-gray-600">Discover events by interest</p>
				</div>
				<div>
					<div
						class="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mx-auto mb-4">
						<i class="fas fa-ticket-alt text-2xl text-indigo-600"></i>
					</div>
					<h3 class="text-xl font-semibold mb-2">Make Booking</h3>
					<p class="text-gray-600">Reserve your spot in seconds</p>
				</div>
				<div>
					<div
						class="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mx-auto mb-4">
						<i class="fas fa-calendar-check text-2xl text-indigo-600"></i>
					</div>
					<h3 class="text-xl font-semibold mb-2">Get Ready</h3>
					<p class="text-gray-600">Receive confirmations and reminders</p>
				</div>
				<div>
					<div
						class="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mx-auto mb-4">
						<i class="fas fa-star text-2xl text-indigo-600"></i>
					</div>
					<h3 class="text-xl font-semibold mb-2">Enjoy Event</h3>
					<p class="text-gray-600">Make memories that matter</p>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="partials/footer.jsp"%>

	<!-- JS Confirmation -->
	<script>
		function confirmRegistration() {
			return confirm("Are you sure you want to register for this event?");
		}
	</script>
</body>
</html>