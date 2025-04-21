<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>All Events | Planzone</title>
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
	<section class="py-20 bg-gray-50">
		<div class="container mx-auto px-4">
			<div class="flex justify-between items-center mb-8">
				<h2 class="text-3xl font-bold text-gray-900">All Events</h2>
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
							<div class="flex items-center justify-between mb-5">
								<h3 class="text-xl font-bold text-gray-900">${event.title}</h3>
								<span class="inline-block text-xs font-semibold bg-indigo-100 text-indigo-800 px-3 py-1 rounded-full">
									${event.categoryName}
								</span>
							</div>
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

	<%@ include file="partials/footer.jsp"%>

	<!-- JS Confirmation -->
	<script>
		function confirmRegistration() {
			return confirm("Are you sure you want to register for this event?");
		}
	</script>
</body>
</html>