<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>About Us | Planzone</title>
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
	<section class="bg-indigo-50 py-24 text-center">
		<div class="container mx-auto px-4">
			<h1 class="text-5xl font-bold text-indigo-900 mb-4">About Planzone</h1>
			<p class="text-lg text-gray-600 max-w-3xl mx-auto">Your one-stop solution to discover, organize, and enjoy events of all kinds — brought to you with passion, innovation, and care.</p>
		</div>
	</section>

	<!-- Mission Section -->
	<section class="py-20 bg-white">
		<div class="container mx-auto px-4 max-w-4xl text-center">
			<h2 class="text-3xl font-bold text-gray-900 mb-6">Our Mission</h2>
			<p class="text-lg text-gray-600 leading-relaxed">At Planzone, we believe events are more than just dates and venues. They're opportunities to connect, learn, celebrate, and grow. Our mission is to empower organizers and inspire attendees with a platform that's fast, flexible, and full of possibilities.</p>
		</div>
	</section>

	<!-- Features Section -->
	<section class="bg-gray-50 py-20">
		<div class="container mx-auto px-4">
			<h2 class="text-3xl font-bold text-center text-gray-900 mb-12">Why Choose Planzone?</h2>
			<div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
				<div class="p-6 bg-white rounded-xl shadow">
					<i class="fas fa-bolt text-3xl text-indigo-600 mb-4"></i>
					<h3 class="text-xl font-semibold mb-2">Simple and Fast</h3>
					<p class="text-gray-600">Easily create and discover events with a user-friendly interface designed for speed and simplicity.</p>
				</div>
				<div class="p-6 bg-white rounded-xl shadow">
					<i class="fas fa-users text-3xl text-indigo-600 mb-4"></i>
					<h3 class="text-xl font-semibold mb-2">Community Driven</h3>
					<p class="text-gray-600">Join a growing network of organizers and attendees who share your interests and passions.</p>
				</div>
				<div class="p-6 bg-white rounded-xl shadow">
					<i class="fas fa-shield-alt text-3xl text-indigo-600 mb-4"></i>
					<h3 class="text-xl font-semibold mb-2">Secure and Reliable</h3>
					<p class="text-gray-600">Your data and experiences are protected with modern technology and trusted design practices.</p>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="partials/footer.jsp"%>
</body>
</html>