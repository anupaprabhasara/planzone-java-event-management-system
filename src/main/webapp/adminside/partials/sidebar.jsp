<!-- Sidebar -->
<aside class="w-64 bg-white h-screen shadow-lg p-6 flex flex-col justify-between">
    <div>
        <h2 class="text-2xl font-extrabold text-orange-600 mb-8">
            <i class="fa-solid fa-calendar-days mr-2"></i> Planzone
        </h2>

        <nav>
            <ul class="space-y-4 text-sm font-medium text-gray-700">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="hover:text-orange-500"><i class="fa-solid fa-chart-line mr-2"></i>Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/venue" class="hover:text-orange-500"><i class="fa-solid fa-map-location-dot mr-2"></i>Venues</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/event" class="hover:text-orange-500"><i class="fa-solid fa-calendar-check mr-2"></i>Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/category" class="hover:text-orange-500"><i class="fa-solid fa-tags mr-2"></i>Categories</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/registration" class="hover:text-orange-500"><i class="fa-solid fa-user-check mr-2"></i>Registrations</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/user" class="hover:text-orange-500"><i class="fa-solid fa-users-gear mr-2"></i>Users</a></li>
            </ul>
        </nav>
    </div>

    <div>
        <a href="${pageContext.request.contextPath}/admin/logout"
           class="text-red-600 hover:text-red-800 text-sm font-medium flex items-center">
            <i class="fa-solid fa-right-from-bracket mr-2"></i> Logout
        </a>
    </div>
</aside>