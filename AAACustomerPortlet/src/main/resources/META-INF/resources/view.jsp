<%@ include file="/init.jsp" %>

<liferay-ui:tabs names="Service, Customer" refresh="false" tabsValues="Service, Customer">
    <liferay-ui:section>
         <%@ include file="/viewService.jsp" %>
    </liferay-ui:section>
    <liferay-ui:section>
        <%@ include file="/viewCustomer.jsp" %>
    </liferay-ui:section>
   
</liferay-ui:tabs>