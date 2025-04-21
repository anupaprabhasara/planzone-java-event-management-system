<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Planzone Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminside/assets/favicon.png" type="image/png">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-orange-50 min-h-screen flex">

<%@ include file="./partials/sidebar.jsp" %>

<main class="flex-1 p-8">
    <!-- Greeting Message -->
    <div class="mb-6">
        <p class="text-lg font-semibold text-gray-700">
            Hello, ${sessionScope.name}! You are logged in as <span class="text-orange-500">${sessionScope.role}</span>.
        </p>
    </div>

    <!-- Dashboard Title -->
    <div class="mb-6">
        <h1 class="text-2xl font-bold text-orange-600">
            <i class="fa-solid fa-gauge-high mr-2"></i> Dashboard Overview
        </h1>
    </div>

    <!-- Statistic Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <div class="bg-white p-6 rounded-xl shadow border-l-4 border-orange-500">
            <h2 class="text-gray-600 text-sm mb-2">Total Events</h2>
            <p class="text-2xl font-bold text-orange-600">${totalEvents}</p>
        </div>
        <div class="bg-white p-6 rounded-xl shadow border-l-4 border-orange-500">
            <h2 class="text-gray-600 text-sm mb-2">Total Registrations</h2>
            <p class="text-2xl font-bold text-orange-600">${totalRegistrations}</p>
        </div>
        <div class="bg-white p-6 rounded-xl shadow border-l-4 border-orange-500">
            <h2 class="text-gray-600 text-sm mb-2">Total Venues</h2>
            <p class="text-2xl font-bold text-orange-600">${totalVenues}</p>
        </div>
        <div class="bg-white p-6 rounded-xl shadow border-l-4 border-orange-500">
            <h2 class="text-gray-600 text-sm mb-2">Total Users</h2>
            <p class="text-2xl font-bold text-orange-600">${totalUsers}</p>
        </div>
    </div>

	<div class="mt-10">
	    <h2 class="text-xl font-semibold text-gray-700 mb-4">
	        <i class="fa-solid fa-lightbulb mr-2"></i> Quick Tips
	    </h2>
	
	    <div class="bg-white border border-orange-300 rounded-xl p-6 shadow">
	        <ul class="list-disc pl-6 space-y-2 text-gray-700">
	            <li>You can create, update, and delete events under the “Events” tab.</li>
	            <li>Only organizers can add or delete users and manage event data.</li>
	            <li>Use the search bars on listing pages to quickly filter content.</li>
	            <li>Check the "Registrations" page to monitor user sign-ups.</li>
	            <li>New notifications are generated automatically when an event is created.</li>
	        </ul>
	    </div>
	</div>
</main>

</body>
</html>