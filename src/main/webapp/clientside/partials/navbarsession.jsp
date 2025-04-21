<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Navigation Bar -->
<nav class="bg-indigo-600 text-white sticky top-0 z-50 shadow-lg">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center h-16">

      <!-- Brand -->
      <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-2 text-2xl font-bold">
        <i class="fas fa-calendar-check"></i> <span>Planzone</span>
      </a>

      <!-- Navigation Links -->
      <div class="hidden md:flex space-x-6">
        <a href="${pageContext.request.contextPath}/" class="hover:text-indigo-200 transition">Home</a>
        <a href="${pageContext.request.contextPath}/events" class="hover:text-indigo-200 transition">Events</a>
        <a href="${pageContext.request.contextPath}/about" class="hover:text-indigo-200 transition">About</a>
        <a href="${pageContext.request.contextPath}/contact" class="hover:text-indigo-200 transition">Contact</a>
      </div>

      <!-- Right Section -->
      <div class="flex items-center space-x-4">

        <!-- Notifications -->
        <div class="relative">
          <button onclick="toggleNotifications()" class="relative hover:text-indigo-200 focus:outline-none">
            <i class="fas fa-bell text-lg"></i>
            <c:if test="${not empty notifications}">
              <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center animate-pulse">
                ${fn:length(notifications)}
              </span>
            </c:if>
          </button>

          <!-- Dropdown -->
          <div id="notificationDropdown"
               class="hidden absolute right-0 mt-2 w-80 bg-white text-gray-700 rounded-md shadow-lg border border-gray-100 overflow-hidden z-50 max-h-96 overflow-y-auto">
            <c:forEach var="note" items="${notifications}">
              <div class="p-4 flex items-start space-x-3 border-b">
                <div class="bg-orange-100 p-2 rounded-full">
                  <i class="fas fa-bell text-orange-500"></i>
                </div>
                <div>
                  <p class="font-semibold">${note.message}</p>
                  <p class="text-sm text-gray-500">${note.createdAt}</p>
                </div>
              </div>
            </c:forEach>
            <c:if test="${empty notifications}">
              <div class="p-4 text-gray-500 text-sm text-center">No notifications</div>
            </c:if>
          </div>
        </div>

        <!-- User Menu -->
        <div class="relative">
          <button onclick="toggleUserMenu()" class="flex items-center space-x-2 hover:text-indigo-200 focus:outline-none">
            <img src="https://ui-avatars.com/api/?name=${sessionScope.name}&background=818CF8&color=fff"
                 alt="${sessionScope.name}" class="w-8 h-8 rounded-full">
            <span class="hidden sm:block">${sessionScope.name}</span>
            <i class="fas fa-chevron-down text-sm"></i>
          </button>

          <!-- Dropdown -->
          <div id="userDropdown"
               class="hidden absolute right-0 mt-2 w-48 bg-white text-gray-700 rounded-md shadow-lg border border-gray-100 z-50 overflow-hidden">
            <div class="px-4 py-3 border-b">
              <p class="text-xs text-gray-500">Signed in as</p>
              <p class="font-semibold break-words text-sm text-gray-800">${sessionScope.email}</p>
            </div>
            <a href="${pageContext.request.contextPath}/profile" class="flex items-center px-4 py-2 hover:bg-gray-50"><i class="fas fa-user mr-2 text-gray-500"></i>Profile</a>
            <a href="${pageContext.request.contextPath}/myevents" class="flex items-center px-4 py-2 hover:bg-gray-50"><i class="fas fa-calendar mr-2 text-gray-500"></i>My Events</a>
            <a href="${pageContext.request.contextPath}/settings" class="flex items-center px-4 py-2 hover:bg-gray-50"><i class="fas fa-cog mr-2 text-gray-500"></i>Settings</a>
            <div class="border-t">
              <a href="${pageContext.request.contextPath}/logout"
                 class="flex items-center px-4 py-2 text-red-600 hover:bg-red-50"><i class="fas fa-sign-out-alt mr-2"></i>Logout</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</nav>

<script>
  function toggleNotifications() {
    const dropdown = document.getElementById('notificationDropdown');
    dropdown.classList.toggle('hidden');
    document.getElementById('userDropdown').classList.add('hidden');
  }

  function toggleUserMenu() {
    const dropdown = document.getElementById('userDropdown');
    dropdown.classList.toggle('hidden');
    document.getElementById('notificationDropdown').classList.add('hidden');
  }

  document.addEventListener('click', (event) => {
    const notificationDropdown = document.getElementById('notificationDropdown');
    const userDropdown = document.getElementById('userDropdown');
    if (!event.target.closest('button')) {
      notificationDropdown.classList.add('hidden');
      userDropdown.classList.add('hidden');
    }
  });
</script>