<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!--FOOTER-->
            <div id="footer" class="footer">
                <div class="custom-footer">
                    Copyright © 2016 PaaS-TA. All rights reserved.
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var isAdmin = <%=request.isUserInRole("ROLE_ADMIN")%>;

    $(document).ready(function () {
        var currentPage = document.location.href;

        // SET TOP MENU LIST
        procGetTopMenuList();

        // SET LEFT MENU LIST
        if (currentPage.search("http://") > -1 && 'catalog' != currentPage.substr(7).split('/')[1]) {
            procGetOrgs();
        }

        procInitLeftMenuScrollbar();
        procGetManagedOrgForUser();

        $('#createSpace-TextField').keypress(function (e) {
            if (e.which == 13) {
                e.preventDefault();
                if (document.getElementById("btn-createSpace").disabled == false) {
                    procCreateSpace('createSpace');
                }
            }
        });
    });

</script>
</body>
</html>
