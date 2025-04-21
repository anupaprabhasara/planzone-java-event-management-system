<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Events | Planzone</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/clientside/assets/favicon.png" type="image/png">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<%@ include file="partials/navbarsession.jsp" %>

<div class="max-w-4xl mx-auto my-12 bg-white p-6 rounded-lg shadow">
    <h2 class="text-2xl font-bold mb-6 text-indigo-700">My Registered Events</h2>

    <c:if test="${empty registrations}">
        <p class="text-gray-600">You have not registered for any events yet.</p>
    </c:if>

    <c:if test="${not empty registrations}">
        <div class="space-y-6">
            <c:forEach var="reg" items="${registrations}">
                <div class="border border-gray-200 rounded-lg p-4 bg-gray-50">
                    <div class="flex justify-between items-center">
                        <div>
                            <h3 class="text-lg font-semibold text-gray-800">${reg.eventTitle}</h3>
                            <p class="text-sm text-gray-600">Registered at: ${reg.registeredAt}</p>
                        </div>
                        <form method="post" action="${pageContext.request.contextPath}/myevents"
                              onsubmit="return confirm('Are you sure you want to unenroll from this event?');">
                            <input type="hidden" name="registrationId" value="${reg.registrationId}">
                            <button type="submit"
                                    class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">
                                Unenroll
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<%@ include file="partials/footer.jsp" %>
</body>
</html>