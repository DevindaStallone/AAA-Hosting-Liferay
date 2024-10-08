<%@ include file="init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	sitiCustomer customer = (sitiCustomer) row.getObject();
	long groupId = customer.getGroupId();
	String name = sitiCustomer.class.getName();
	long customerId = customer.getCustomerId();
	String redirect = PortalUtil.getCurrentURL(renderRequest);
%>

<liferay-ui:icon-menu>
	<portlet:renderURL var="editURL">
		<portlet:param name="mvcPath" value="/updateCustomer.jsp" />
		<portlet:param name="customerId" value="<%= String.valueOf(customerId) %>" />
		<portlet:param name="redirect" value="<%= redirect %>" />
	</portlet:renderURL>

	<liferay-ui:icon image="edit" url="<%= editURL.toString() %>" />

	<portlet:actionURL name="deleteCustomer" var="deleteURL">
		<portlet:param name="customerId" value="<%= String.valueOf(customerId) %>" />
		<portlet:param name="redirect" value="<%= redirect %>" />
	</portlet:actionURL>

	<liferay-ui:icon image="delete" url="<%= deleteURL.toString() %>" />
</liferay-ui:icon-menu>