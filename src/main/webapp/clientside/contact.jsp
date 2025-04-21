<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Contact Us | Planzone</title>
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

	<!-- Hero Section -->
	<section class="bg-gradient-to-r from-indigo-50 to-indigo-100 py-24 text-center">
		<div class="container mx-auto px-4">
			<h1 class="text-5xl font-bold text-indigo-900 mb-4">Let's Talk</h1>
			<p class="text-lg text-gray-600 max-w-2xl mx-auto">We’d love to hear from you! Whether it's a question, suggestion, or collaboration idea — we're just a message away.</p>
		</div>
	</section>

	<!-- Interactive Contact Info -->
	<section class="py-20 bg-white">
		<div class="container mx-auto px-4">
			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 text-center">

				<!-- Office -->
				<div class="p-8 bg-indigo-50 rounded-2xl shadow hover:shadow-lg transition transform hover:-translate-y-1">
					<div class="w-16 h-16 mx-auto mb-4 bg-indigo-100 rounded-full flex items-center justify-center text-indigo-600 text-2xl">
						<i class="fas fa-map-marker-alt"></i>
					</div>
					<h3 class="text-xl font-bold mb-2 text-indigo-900">Visit Us</h3>
					<p class="text-gray-600">123 Event Street<br>Cityville, CV 45678<br>Country</p>
				</div>

				<!-- Email -->
				<div class="p-8 bg-blue-50 rounded-2xl shadow hover:shadow-lg transition transform hover:-translate-y-1">
					<div class="w-16 h-16 mx-auto mb-4 bg-blue-100 rounded-full flex items-center justify-center text-blue-600 text-2xl">
						<i class="fas fa-envelope"></i>
					</div>
					<h3 class="text-xl font-bold mb-2 text-blue-900">Email</h3>
					<p><a href="mailto:support@planzone.com" class="text-blue-600 hover:underline">support@planzone.com</a></p>
				</div>

				<!-- Phone -->
				<div class="p-8 bg-green-50 rounded-2xl shadow hover:shadow-lg transition transform hover:-translate-y-1">
					<div class="w-16 h-16 mx-auto mb-4 bg-green-100 rounded-full flex items-center justify-center text-green-600 text-2xl">
						<i class="fas fa-phone"></i>
					</div>
					<h3 class="text-xl font-bold mb-2 text-green-900">Call</h3>
					<p class="text-gray-600">+94 712 345 678<br>+94 112 345 678</p>
				</div>

				<!-- Social -->
				<div class="p-8 bg-pink-50 rounded-2xl shadow hover:shadow-lg transition transform hover:-translate-y-1">
					<div class="w-16 h-16 mx-auto mb-4 bg-pink-100 rounded-full flex items-center justify-center text-pink-600 text-2xl">
						<i class="fas fa-share-alt"></i>
					</div>
					<h3 class="text-xl font-bold mb-2 text-pink-900">Follow Us</h3>
					<div class="flex justify-center gap-4 text-2xl text-pink-600 mt-2">
						<a href="https://facebook.com/planzone" target="_blank"><i class="fab fa-facebook"></i></a>
						<a href="https://twitter.com/planzone" target="_blank"><i class="fab fa-twitter"></i></a>
						<a href="https://instagram.com/planzone" target="_blank"><i class="fab fa-instagram"></i></a>
						<a href="https://linkedin.com/company/planzone" target="_blank"><i class="fab fa-linkedin"></i></a>
					</div>
				</div>

			</div>
		</div>
	</section>

	<!-- Call to Action -->
	<section class="py-16 bg-indigo-600 text-white text-center">
		<div class="container mx-auto px-4">
			<h2 class="text-3xl font-bold mb-4">Want to work with us?</h2>
			<p class="text-lg mb-6">We're open to partnerships, sponsors, and creative collabs. Reach out and let’s make something awesome together.</p>
			<a href="mailto:support@planzone.com" class="bg-white text-indigo-600 font-semibold px-6 py-3 rounded-lg hover:bg-indigo-50 transition">
				Contact Our Team
			</a>
		</div>
	</section>

	<%@ include file="partials/footer.jsp"%>
</body>
</html>