package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.lib.domain.CloudUser;
import org.cloudfoundry.identity.uaa.api.common.model.expr.FilterRequestBuilder;
import org.cloudfoundry.identity.uaa.api.group.UaaGroupOperations;
import org.cloudfoundry.identity.uaa.api.user.UaaUserOperations;
import org.cloudfoundry.identity.uaa.rest.SearchResults;
import org.cloudfoundry.identity.uaa.scim.ScimGroup;
import org.cloudfoundry.identity.uaa.scim.ScimUser;
import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.common.CustomCloudFoundryClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Future;

/**
 * Created by Dojun on 2016-08-31.
 */

@Service
public class AsyncUtilService extends Common {

//    @Async
    public Future<List<Map<String, Object>>> getUsers(UUID orgGuid, CustomCloudFoundryClient client) throws Exception{
        List<Map<String, Object>> users = client.getUsers(orgGuid);
        return  new AsyncResult<>(users);
    }

    //users
    @Async
    public Future< Map<String, CloudUser>> getUsersForOrgRole_managers(UUID orgGuid, CustomCloudFoundryClient client) throws Exception{
        Map<String, CloudUser> managers = client.getUsersForOrgRole(orgGuid, "managers");
        return  new AsyncResult<>(managers);
    }
    @Async
    public Future< Map<String, CloudUser>> getUsersForOrgRole_billingManagers(UUID orgGuid, CustomCloudFoundryClient client) throws Exception{
        Map<String, CloudUser> billingManagers = client.getUsersForOrgRole(orgGuid, "billing_managers");
        return new AsyncResult<>(billingManagers);
    }
    @Async
    public Future< Map<String, CloudUser>> getUsersForOrgRole_auditors(UUID orgGuid, CustomCloudFoundryClient client) throws Exception{
        Map<String, CloudUser> auditors = client.getUsersForOrgRole(orgGuid, "auditors");
        return new AsyncResult<>(auditors);
    }
    @Async
    public Future< Map<String, CloudUser>> getUsersForSpaceRole_managers(UUID orgGuid,String spaceName, CustomCloudFoundryClient client) throws Exception{
        Map<String, CloudUser> managers = client.getUsersForSpaceRole(orgGuid, spaceName,"managers");
        return  new AsyncResult<>(managers);
    }
    @Async
    public Future< Map<String, CloudUser>> getUsersForSpaceRole_developers(UUID orgGuid,String spaceName, CustomCloudFoundryClient client) throws Exception{
        Map<String, CloudUser> billingManagers = client.getUsersForSpaceRole(orgGuid,spaceName, "developers");
        return new AsyncResult<>(billingManagers);
    }
    @Async
    public Future< Map<String, CloudUser>> getUsersForSpaceRole_auditors(UUID orgGuid, String spaceName, CustomCloudFoundryClient client) throws Exception{
        Map<String, CloudUser> auditors = client.getUsersForSpaceRole(orgGuid,spaceName, "auditors");
        return new AsyncResult<>(auditors);
    }
}
